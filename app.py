import json
import os
import re
from functools import wraps
import pymysql
from flask import Flask, flash, redirect, render_template, request, url_for, session

app = Flask(__name__)
app.secret_key = os.environ.get("FLASK_SECRET_KEY", "dev-secret-change-later")

# --- DATABASE CONFIG (Corrected for your setup) ---
DB_CONFIG = {
    "host": os.environ.get("DB_HOST", "localhost"),
    "user": os.environ.get("DB_USER", "root"),
    "password": os.environ.get("DB_PASSWORD", "Aditya@098"),
    "database": os.environ.get("DB_NAME", "ecom_copy1"),
    "charset": "utf8mb4",
    "cursorclass": pymysql.cursors.DictCursor,
}

# ==============================================================================
# MANAGEMENT BACKEND CONFIGURATION & HELPERS (From your exact file!)
# ==============================================================================
ALL_TABLES = {
    "Admin": "Admin Accounts", "User": "Staff, Vendors & Couriers", "Customer": "Customers",
    "Continent": "Continent", "Country": "Country", "State": "State", "District": "District", "Locality": "Locality",
    "Company": "Company", "Brand": "Brand", "Model": "Model",
    "ProductCategory": "Product Category", "ProductSubCategory": "Product Sub Category", "ProductSubSubCategory": "Product Sub Sub Category",
    "Color": "Color", "Shape": "Shape", "Size": "Size", "Unit": "Unit", "Material": "Material", "Currency": "Currency",
    "Product": "Product Catalog", "ProductImages": "Product Images", "VendorProduct": "My Listings (Vendor Products)",
    "Purchase": "Orders", "VendorProductCustomerCourier": "Logistics & Tracking", "Feedback": "Feedback",
}

ROLE_PERMISSIONS = {
    "SuperUser": ["Admin"],
    "Admin": [
        "User", "Customer", "Continent", "Country", "State", "District", "Locality", 
        "Company", "Brand", "Model", "ProductCategory", "ProductSubCategory", 
        "ProductSubSubCategory", "Color", "Shape", "Size", "Unit", "Material", "Currency"
    ],
    "Operator": ["Product", "ProductImages"],
    "Vendor": ["Product", "ProductImages", "VendorProduct", "Purchase", "VendorProductCustomerCourier"],
    "Courier": ["VendorProductCustomerCourier"],
    "Manager": []
}

TABLE_CATEGORIES = {
    "User Management": ["Admin", "User", "Customer"],
    "Geography & Locations": ["Continent", "Country", "State", "District", "Locality"],
    "Catalog Hierarchy": ["Company", "Brand", "Model", "ProductCategory", "ProductSubCategory", "ProductSubSubCategory"],
    "Product Specifications": ["Color", "Shape", "Size", "Unit", "Material", "Currency"],
    "Inventory & Listings": ["Product", "ProductImages", "VendorProduct"],
    "Orders & Logistics": ["Purchase", "VendorProductCustomerCourier", "Feedback"]
}

READ_ONLY_COLUMNS = {
    "RecordCreationTimeStamp", "LastUpdationTimeStamp", "RecordCreationLogin", "LastUpdationLogin",
    "VerificationTimeStamp", "ActivationTimeStamp", "SuspensionTimeStamp", "BlacklistTimeStamp",
    "DeadTimeStamp", "ReturnTimeStamp", "DeliveryTimeStamp", "OutForDeliveryTimeStamp",
    "DispatchedTimeStamp", "PickedByCourierTimeStamp", "ReadyForPickupTimeStamp", "IsDeleted",
    "IsActive", "IsSuspended", "IsBlacklisted", "IsDead", "IsVerified", "IsActivated",
    "CreatedBySuperUserID", "CreatedByAdminID"
}

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "user_id" not in session: return redirect(url_for("login"))
        return f(*args, **kwargs)
    return decorated_function

def get_connection(): return pymysql.connect(**DB_CONFIG)

def get_database_tables():
    sql = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = %s"
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql, (DB_CONFIG["database"],))
            return [row["TABLE_NAME"] for row in cursor.fetchall()]

def normalize_table_name(table_name):
    for real_name in ALL_TABLES:
        if real_name.lower() == table_name.lower(): return real_name
    return None

def get_db_table_name(table_name):
    for db_table in get_database_tables():
        if db_table.lower() == table_name.lower(): return db_table
    return table_name

def get_columns(table_name):
    db_table_name = get_db_table_name(table_name)
    sql = "SELECT COLUMN_NAME, DATA_TYPE, COLUMN_TYPE, IS_NULLABLE, COLUMN_DEFAULT, EXTRA, COLUMN_KEY FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = %s AND TABLE_NAME = %s ORDER BY ORDINAL_POSITION"
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql, (DB_CONFIG["database"], db_table_name))
            columns = cursor.fetchall()
            for col in columns:
                if col["DATA_TYPE"] == "enum":
                    match = re.search(r"enum\((.*)\)", col["COLUMN_TYPE"])
                    if match: col["ENUM_VALUES"] = [v.strip("'") for v in match.group(1).split(",")]
            return columns

def get_primary_key(columns):
    for column in columns:
        if column["COLUMN_KEY"] == "PRI": return column["COLUMN_NAME"]
    return None

def get_foreign_keys(table_name):
    db_table_name = get_db_table_name(table_name)
    sql = "SELECT COLUMN_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE TABLE_SCHEMA = %s AND TABLE_NAME = %s AND REFERENCED_TABLE_NAME IS NOT NULL"
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql, (DB_CONFIG["database"], db_table_name))
            return {row["COLUMN_NAME"]: row for row in cursor.fetchall()}

def get_fk_display_column(referenced_table):
    sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = %s AND TABLE_NAME = %s AND DATA_TYPE IN ('varchar', 'text') ORDER BY ORDINAL_POSITION LIMIT 1"
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql, (DB_CONFIG["database"], referenced_table))
            res = cursor.fetchone()
            return res["COLUMN_NAME"] if res else None

def is_form_column(column):
    name, extra = column["COLUMN_NAME"], column["EXTRA"] or ""
    if "auto_increment" in extra or name in READ_ONLY_COLUMNS: return False
    if session.get("role") == "Vendor" and name == "VendorUserID": return False
    return True

def clean_value(column, value):
    name, data_type, nullable = column["COLUMN_NAME"], column["DATA_TYPE"], column["IS_NULLABLE"] == "YES"
    if value == "":
        if nullable: return None
        if data_type in {"int", "tinyint", "decimal"}: return 0
        return ""
    if data_type in {"int", "tinyint"}: return int(value)
    if data_type == "decimal": return value
    if data_type == "json" or name.endswith("_JSON"): return json.loads(value)
    return value

def fetch_rows(table_name, include_deleted=False):
    db_table_name = get_db_table_name(table_name)
    columns = get_columns(table_name)
    has_deleted = any(column["COLUMN_NAME"] == "IsDeleted" for column in columns)
    where = "" if include_deleted or not has_deleted else "WHERE IsDeleted = 0"
    sql = f"SELECT * FROM `{db_table_name}` {where} ORDER BY 1 DESC LIMIT 100"
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql)
            return cursor.fetchall()

def fetch_row(table_name, primary_key, record_id):
    db_table_name = get_db_table_name(table_name)
    sql = f"SELECT * FROM `{db_table_name}` WHERE `{primary_key}` = %s"
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql, (record_id,))
            return cursor.fetchone()

# ==============================================================================
# MANAGEMENT ROUTES
# ==============================================================================
@app.route("/mgm/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        account_type, username, password = request.form.get("account_type"), request.form.get("username"), request.form.get("password")
        with get_connection() as connection:
            with connection.cursor() as cursor:
                if account_type == "SuperUser":
                    cursor.execute("SELECT * FROM SuperUser WHERE LoginName=%s AND PasswordHash=%s AND IsDeleted=0 AND IsActive=1 AND IsSuspended=0 AND IsBlacklisted=0", (username, password))
                    user = cursor.fetchone()
                    if user:
                        session['user_id'], session['role'], session['name'] = user['SuperUserID'], 'SuperUser', user['FullName']
                        return redirect(url_for('management_home'))
                elif account_type == "Admin":
                    cursor.execute("SELECT * FROM Admin WHERE LoginName=%s AND PasswordHash=%s AND IsDeleted=0 AND IsActive=1 AND IsSuspended=0 AND IsBlacklisted=0", (username, password))
                    user = cursor.fetchone()
                    if user:
                        session['user_id'], session['role'], session['name'] = user['AdminID'], 'Admin', user['FullName']
                        return redirect(url_for('management_home'))
                elif account_type in ["Manager", "Operator", "Vendor", "Courier"]:
                    cursor.execute("SELECT * FROM `User` WHERE LoginName=%s AND PasswordHash=%s AND UserRole=%s AND IsDeleted=0 AND IsActive=1 AND IsSuspended=0 AND IsBlacklisted=0", (username, password, account_type))
                    user = cursor.fetchone()
                    if user:
                        session['user_id'], session['role'], session['name'] = user['UserID'], user['UserRole'], user['FullName']
                        return redirect(url_for('management_home'))
        flash("Invalid Role, Username, Password, or Account is Inactive/Suspended.", "error")
    return render_template("login.html")

@app.route("/mgm/logout")
def logout():
    session.pop('user_id', None)
    session.pop('role', None)
    session.pop('name', None)
    flash("You have been logged out.", "success")
    return redirect(url_for("login"))

@app.route("/mgm")
@login_required
def management_home():
    return render_template("management_home.html", all_tables=ALL_TABLES, role_permissions=ROLE_PERMISSIONS, table_categories=TABLE_CATEGORIES)

@app.route("/mgm/<table_name>")
@login_required
def table_list(table_name):
    table_name = normalize_table_name(table_name)
    if not table_name: return redirect(url_for("management_home"))
    if table_name not in ROLE_PERMISSIONS.get(session.get('role'), []):
        flash("You do not have permission to access this module.", "error")
        return redirect(url_for("management_home"))

    include_deleted = request.args.get("include_deleted") == "1"
    columns = get_columns(table_name)
    rows = fetch_rows(table_name, include_deleted=include_deleted)
    primary_key = get_primary_key(columns)
    return render_template("table_list.html", table_name=table_name, table_label=ALL_TABLES[table_name], columns=columns, rows=rows, primary_key=primary_key, include_deleted=include_deleted)

@app.route("/mgm/<table_name>/new", methods=["GET", "POST"])
@login_required
def create_record(table_name):
    table_name = normalize_table_name(table_name)
    if not table_name or table_name not in ROLE_PERMISSIONS.get(session.get('role'), []): return redirect(url_for("management_home"))
    columns = get_columns(table_name)
    form_columns = [column for column in columns if is_form_column(column)]

    fks = get_foreign_keys(table_name)
    fk_options = {}
    for col_name, fk_info in fks.items():
        ref_table = fk_info["REFERENCED_TABLE_NAME"]
        ref_pk = fk_info["REFERENCED_COLUMN_NAME"]
        display_col = get_fk_display_column(ref_table) or ref_pk
        sql = f"SELECT `{ref_pk}` as id, `{display_col}` as text FROM `{ref_table}` WHERE IsDeleted=0"
        if ref_table.lower() == "user":
            if "vendor" in col_name.lower(): sql += " AND UserRole = 'Vendor'"
            elif "courier" in col_name.lower(): sql += " AND UserRole = 'Courier'"
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute(sql)
                fk_options[col_name] = cursor.fetchall()

    if request.method == "POST":
        try:
            db_table_name = get_db_table_name(table_name)
            names = [column["COLUMN_NAME"] for column in form_columns]
            values = [clean_value(column, request.form.get(column["COLUMN_NAME"], "")) for column in form_columns]
            
            if any(col["COLUMN_NAME"] == "RecordCreationLogin" for col in columns): names.extend(["RecordCreationLogin"]); values.extend([session.get("name")])
            if table_name == "Admin" and any(col["COLUMN_NAME"] == "CreatedBySuperUserID" for col in columns): names.extend(["CreatedBySuperUserID"]); values.extend([session.get("user_id")])
            if table_name == "User" and any(col["COLUMN_NAME"] == "CreatedByAdminID" for col in columns): names.extend(["CreatedByAdminID"]); values.extend([session.get("user_id")])
            if session.get("role") == "Vendor" and any(col["COLUMN_NAME"] == "VendorUserID" for col in columns):
                if "VendorUserID" not in names: names.extend(["VendorUserID"]); values.extend([session.get("user_id")])
            if any(col["COLUMN_NAME"] == "IsActive" for col in columns): names.extend(["IsActive"]); values.extend([1])

            placeholders = ", ".join(["%s"] * len(names))
            column_sql = ", ".join(f"`{name}`" for name in names)
            sql = f"INSERT INTO `{db_table_name}` ({column_sql}) VALUES ({placeholders})"
            with get_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute(sql, values)
                connection.commit()
            flash("Record created.", "success")
            return redirect(url_for("table_list", table_name=table_name))
        except Exception as exc: flash(f"Could not create record: {exc}", "error")

    return render_template("record_form.html", mode="Create", table_name=table_name, table_label=ALL_TABLES[table_name], columns=form_columns, row={}, fk_options=fk_options)

@app.route("/mgm/<table_name>/<int:record_id>/edit", methods=["GET", "POST"])
@login_required
def edit_record(table_name, record_id):
    table_name = normalize_table_name(table_name)
    if not table_name or table_name not in ROLE_PERMISSIONS.get(session.get('role'), []): return redirect(url_for("management_home"))
    columns = get_columns(table_name)
    primary_key = get_primary_key(columns)
    form_columns = [column for column in columns if is_form_column(column) and column["COLUMN_NAME"] != primary_key]
    row = fetch_row(table_name, primary_key, record_id)
    if not row: return redirect(url_for("table_list", table_name=table_name))

    fks = get_foreign_keys(table_name)
    fk_options = {}
    for col_name, fk_info in fks.items():
        ref_table, ref_pk = fk_info["REFERENCED_TABLE_NAME"], fk_info["REFERENCED_COLUMN_NAME"]
        display_col = get_fk_display_column(ref_table) or ref_pk
        sql = f"SELECT `{ref_pk}` as id, `{display_col}` as text FROM `{ref_table}` WHERE IsDeleted=0"
        if ref_table.lower() == "user":
            if "vendor" in col_name.lower(): sql += " AND UserRole = 'Vendor'"
            elif "courier" in col_name.lower(): sql += " AND UserRole = 'Courier'"
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute(sql)
                fk_options[col_name] = cursor.fetchall()

    if request.method == "POST":
        try:
            db_table_name = get_db_table_name(table_name)
            assignments = ", ".join(f"`{column['COLUMN_NAME']}` = %s" for column in form_columns)
            values = [clean_value(column, request.form.get(column["COLUMN_NAME"], "")) for column in form_columns]
            values.append(record_id)
            sql = f"UPDATE `{db_table_name}` SET {assignments} WHERE `{primary_key}` = %s"
            with get_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute(sql, values)
                connection.commit()
            flash("Record updated.", "success")
            return redirect(url_for("table_list", table_name=table_name))
        except Exception as exc: flash(f"Could not update record: {exc}", "error")

    return render_template("record_form.html", mode="Update", table_name=table_name, table_label=ALL_TABLES[table_name], columns=form_columns, row=row, fk_options=fk_options)

@app.route("/mgm/<table_name>/<int:record_id>/delete", methods=["POST"])
@login_required
def delete_record(table_name, record_id):
    table_name = normalize_table_name(table_name)
    columns = get_columns(table_name)
    primary_key = get_primary_key(columns)
    has_deleted = any(column["COLUMN_NAME"] == "IsDeleted" for column in columns)
    try:
        db_table_name = get_db_table_name(table_name)
        sql = f"UPDATE `{db_table_name}` SET IsDeleted = 1 WHERE `{primary_key}` = %s" if has_deleted else f"DELETE FROM `{db_table_name}` WHERE `{primary_key}` = %s"
        with get_connection() as connection:
            with connection.cursor() as cursor: cursor.execute(sql, (record_id,))
            connection.commit()
        flash("Record deleted.", "success")
    except Exception as exc: flash(f"Could not delete record: {exc}", "error")
    return redirect(url_for("table_list", table_name=table_name))

@app.route("/mgm/<table_name>/<int:record_id>/undelete", methods=["POST"])
@login_required
def undelete_record(table_name, record_id):
    table_name = normalize_table_name(table_name)
    columns = get_columns(table_name)
    primary_key = get_primary_key(columns)
    try:
        db_table_name = get_db_table_name(table_name)
        with get_connection() as connection:
            with connection.cursor() as cursor: cursor.execute(f"UPDATE `{db_table_name}` SET IsDeleted = 0 WHERE `{primary_key}` = %s", (record_id,))
            connection.commit()
        flash("Record restored.", "success")
    except Exception as exc: flash(f"Could not restore record: {exc}", "error")
    return redirect(url_for("table_list", table_name=table_name, include_deleted=1))

# ==============================================================================
# STOREFRONT FRONTEND (ShopVerse)
# ==============================================================================
def customer_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "customer_id" not in session:
            flash("Please log in to your customer account first.", "error")
            return redirect(url_for("store_login"))
        return f(*args, **kwargs)
    return decorated_function

@app.context_processor
def inject_globals():
    category_tree, cart_count = {}, 0
    try:
        with get_connection() as connection:
            with connection.cursor() as cursor:
                sql_cat = """
                    SELECT c.ProductCategoryID, c.ProductCategoryName, sc.ProductSubCategoryID, sc.ProductSubCategoryName,
                           ssc.ProductSubSubCategoryID, ssc.ProductSubSubCategoryName
                    FROM ProductCategory c
                    JOIN ProductSubCategory sc ON c.ProductCategoryID = sc.ProductCategoryID
                    JOIN ProductSubSubCategory ssc ON sc.ProductSubCategoryID = ssc.ProductSubCategoryID
                    WHERE c.IsDeleted = 0 AND sc.IsDeleted = 0 AND ssc.IsDeleted = 0
                    ORDER BY c.ProductCategoryName, sc.ProductSubCategoryName, ssc.ProductSubSubCategoryName
                """
                cursor.execute(sql_cat)
                for row in cursor.fetchall():
                    cat_id, cat_name = row['ProductCategoryID'], row['ProductCategoryName']
                    subcat_id, subcat_name = row['ProductSubCategoryID'], row['ProductSubCategoryName']
                    subsub = {'id': row['ProductSubSubCategoryID'], 'name': row['ProductSubSubCategoryName']}
                    
                    if cat_id not in category_tree: category_tree[cat_id] = {'name': cat_name, 'subcats': {}}
                    if subcat_id not in category_tree[cat_id]['subcats']: category_tree[cat_id]['subcats'][subcat_id] = {'name': subcat_name, 'subsubcats': []}
                    category_tree[cat_id]['subcats'][subcat_id]['subsubcats'].append(subsub)
                
                if 'customer_id' in session:
                    cursor.execute("SELECT SUM(Quantity) as total FROM ShoppingCart WHERE CustomerID=%s AND IsDeleted=0", (session['customer_id'],))
                    res = cursor.fetchone()
                    cart_count = res['total'] if res and res['total'] else 0
    except Exception: pass
    return dict(categories=category_tree, cart_count=cart_count)

@app.route("/")
def home():
    search_query, main_cat, sub_cat, ss_cat = request.args.get('search', '').strip(), request.args.get('main_cat'), request.args.get('sub_cat'), request.args.get('ss_cat')
    sql = """
        SELECT vp.VendorProductID, vp.Price, vp.StockQuantity, p.ProductName, p.ProductDescription, 
               b.BrandName, c.CompanyName, u.FullName AS VendorName, cur.CurrencySymbol
        FROM VendorProduct vp
        JOIN Product p ON vp.ProductID = p.ProductID
        JOIN ProductSubSubCategory ssc ON p.ProductSubSubCategoryID = ssc.ProductSubSubCategoryID
        JOIN ProductSubCategory sc ON ssc.ProductSubCategoryID = sc.ProductSubCategoryID
        JOIN Model m ON p.ModelID = m.ModelID
        JOIN Brand b ON m.BrandID = b.BrandID
        JOIN Company c ON b.CompanyID = c.CompanyID
        JOIN `User` u ON vp.VendorUserID = u.UserID
        JOIN Currency cur ON vp.CurrencyID = cur.CurrencyID
        WHERE vp.IsActive = 1 AND vp.IsDeleted = 0 AND p.IsDeleted = 0 AND u.IsActive = 1 AND vp.StockQuantity > 0
    """
    params = []
    if search_query: sql += " AND (p.ProductName LIKE %s OR b.BrandName LIKE %s OR c.CompanyName LIKE %s)"; params.extend([f"%{search_query}%"] * 3)
    if main_cat: sql += " AND sc.ProductCategoryID = %s"; params.append(main_cat)
    if sub_cat: sql += " AND sc.ProductSubCategoryID = %s"; params.append(sub_cat)
    if ss_cat: sql += " AND p.ProductSubSubCategoryID = %s"; params.append(ss_cat)
        
    sql += " ORDER BY p.ProductName ASC"
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql, params) if params else cursor.execute(sql)
            vendor_products = cursor.fetchall()
            
    return render_template("index.html", products=vendor_products, search_query=search_query)

@app.route("/product/<int:vp_id>")
def product_detail(vp_id):
    sql_prod = """
        SELECT vp.VendorProductID, vp.Price, vp.StockQuantity, p.ProductName, p.Attributes_JSON,
               p.ProductDescription, b.BrandName, u.FullName AS VendorName, cur.CurrencySymbol
        FROM VendorProduct vp
        JOIN Product p ON vp.ProductID = p.ProductID
        JOIN Model m ON p.ModelID = m.ModelID
        JOIN Brand b ON m.BrandID = b.BrandID
        JOIN `User` u ON vp.VendorUserID = u.UserID
        JOIN Currency cur ON vp.CurrencyID = cur.CurrencyID
        WHERE vp.VendorProductID = %s AND vp.IsActive = 1 AND p.IsDeleted = 0
    """
    sql_reviews = """
        SELECT f.ProductRating, f.FeedbackText, f.RecordCreationTimeStamp, c.FullName 
        FROM Feedback f
        JOIN Purchase p ON f.PurchaseID = p.PurchaseID
        JOIN Customer c ON f.CustomerID = c.CustomerID
        WHERE p.VendorProductID = %s AND f.IsDeleted = 0
        ORDER BY f.RecordCreationTimeStamp DESC
    """
    with get_connection() as conn:
        with conn.cursor() as cursor:
            cursor.execute(sql_prod, (vp_id,))
            product = cursor.fetchone()
            if not product:
                flash("Product not found.", "error")
                return redirect(url_for('home'))
            cursor.execute(sql_reviews, (vp_id,))
            reviews = cursor.fetchall()

    product['Specs'] = {}
    if product['Attributes_JSON']:
        try: product['Specs'] = json.loads(product['Attributes_JSON'])
        except: pass
        
    avg_rating = round(sum(r['ProductRating'] for r in reviews if r['ProductRating']) / len(reviews), 1) if reviews else 0
    return render_template("product.html", p=product, reviews=reviews, avg_rating=avg_rating)

@app.route("/cart/add", methods=["POST"])
@customer_required
def add_to_cart():
    vendor_product_id = request.form.get("vendor_product_id")
    qty_to_add = int(request.form.get("quantity", 1))
    customer_id = session['customer_id']
    with get_connection() as conn:
        with conn.cursor() as cursor:
            cursor.execute("SELECT ShoppingCartID FROM ShoppingCart WHERE CustomerID=%s AND VendorProductID=%s AND IsDeleted=0", (customer_id, vendor_product_id))
            item = cursor.fetchone()
            if item: cursor.execute("UPDATE ShoppingCart SET Quantity = Quantity + %s WHERE ShoppingCartID=%s", (qty_to_add, item['ShoppingCartID']))
            else: cursor.execute("INSERT INTO ShoppingCart (CustomerID, VendorProductID, Quantity) VALUES (%s, %s, %s)", (customer_id, vendor_product_id, qty_to_add))
        conn.commit()
    flash("Added to cart successfully!", "success")
    return redirect(request.referrer or url_for('home'))

@app.route("/cart")
@customer_required
def view_cart():
    sql = """
        SELECT sc.ShoppingCartID, sc.Quantity, sc.IsSelectedForPurchase, 
               vp.Price, p.ProductName, cur.CurrencySymbol, vp.StockQuantity
        FROM ShoppingCart sc
        JOIN VendorProduct vp ON sc.VendorProductID = vp.VendorProductID
        JOIN Product p ON vp.ProductID = p.ProductID
        JOIN Currency cur ON vp.CurrencyID = cur.CurrencyID
        WHERE sc.CustomerID = %s AND sc.IsDeleted = 0
    """
    with get_connection() as conn:
        with conn.cursor() as cursor:
            cursor.execute(sql, (session['customer_id'],))
            cart_items = cursor.fetchall()
            
    total_value = sum(item['Price'] * item['Quantity'] for item in cart_items if item['IsSelectedForPurchase'])
    return render_template("cart.html", cart_items=cart_items, total_value=total_value)

@app.route("/cart/update", methods=["POST"])
@customer_required
def update_cart():
    cart_id, action = request.form.get("cart_id"), request.form.get("action")
    with get_connection() as conn:
        with conn.cursor() as cursor:
            if action == 'increase': cursor.execute("UPDATE ShoppingCart SET Quantity = Quantity + 1 WHERE ShoppingCartID=%s", (cart_id,))
            elif action == 'decrease': cursor.execute("UPDATE ShoppingCart SET Quantity = Quantity - 1 WHERE ShoppingCartID=%s AND Quantity > 1", (cart_id,))
            elif action == 'delete': cursor.execute("DELETE FROM ShoppingCart WHERE ShoppingCartID=%s", (cart_id,))
            elif action == 'toggle': cursor.execute("UPDATE ShoppingCart SET IsSelectedForPurchase = NOT IsSelectedForPurchase WHERE ShoppingCartID=%s", (cart_id,))
        conn.commit()
    return redirect(url_for('view_cart'))

@app.route("/store/login", methods=["GET", "POST"])
def store_login():
    if request.method == "POST":
        username, password = request.form.get("username"), request.form.get("password")
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute("SELECT * FROM Customer WHERE LoginName=%s AND PasswordHash=%s AND IsDeleted=0 AND IsActive=1", (username, password))
                customer = cursor.fetchone()
                if customer:
                    session['customer_id'], session['customer_name'] = customer['CustomerID'], customer['FullName']
                    flash(f"Welcome back, {customer['FullName']}!", "success")
                    return redirect(url_for("home"))
                else: flash("Invalid email or password.", "error")
    return render_template("store_login.html")

@app.route("/store/register", methods=["GET", "POST"])
def store_register():
    if request.method == "POST":
        full_name, email, password = request.form.get("full_name"), request.form.get("email"), request.form.get("password")
        try:
            with get_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute("INSERT INTO Customer (LoginName, PasswordHash, FullName, Email, IsActive) VALUES (%s, %s, %s, %s, 1)", (email, password, full_name, email))
                connection.commit()
            flash("Account created! You can now log in.", "success")
            return redirect(url_for("store_login"))
        except Exception: flash("Registration failed. Email might be in use.", "error")
    return render_template("store_register.html")

@app.route("/store/logout")
def store_logout():
    session.pop('customer_id', None)
    session.pop('customer_name', None)
    flash("You have been logged out of the store.", "success")
    return redirect(url_for("home"))

if __name__ == "__main__":
    app.run(debug=True, port=5000)