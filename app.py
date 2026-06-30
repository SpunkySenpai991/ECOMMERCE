import os, json
import pymysql
from functools import wraps
from flask import Flask, flash, redirect, render_template, request, url_for, session

app = Flask(__name__)
app.secret_key = "customer-frontend-secret-key"

DB_CONFIG = {
    "host": os.environ.get("DB_HOST", "localhost"),
    "user": os.environ.get("DB_USER", "root"),
    "password": os.environ.get("DB_PASSWORD", "Aditya@098"),
    "database": os.environ.get("DB_NAME", "ecom_copy1"), 
    "charset": "utf8mb4",
    "cursorclass": pymysql.cursors.DictCursor,
}

def get_connection(): return pymysql.connect(**DB_CONFIG)

def customer_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "customer_id" not in session:
            flash("Please log in first.", "error")
            return redirect(url_for("login"))
        return f(*args, **kwargs)
    return decorated_function

# --- GLOBALS (Categories & Cart) ---
@app.context_processor
def inject_globals():
    category_tree = {}
    cart_count = 0
    try:
        with get_connection() as connection:
            with connection.cursor() as cursor:
                # Updated SQL to grab IDs for Main and Sub categories so they can be clicked!
                sql_cat = """
                    SELECT c.ProductCategoryID, c.ProductCategoryName, 
                           sc.ProductSubCategoryID, sc.ProductSubCategoryName,
                           ssc.ProductSubSubCategoryID, ssc.ProductSubSubCategoryName
                    FROM ProductCategory c
                    JOIN ProductSubCategory sc ON c.ProductCategoryID = sc.ProductCategoryID
                    JOIN ProductSubSubCategory ssc ON sc.ProductSubCategoryID = ssc.ProductSubCategoryID
                    WHERE c.IsDeleted = 0 AND sc.IsDeleted = 0 AND ssc.IsDeleted = 0
                    ORDER BY c.ProductCategoryName, sc.ProductSubCategoryName, ssc.ProductSubSubCategoryName
                """
                cursor.execute(sql_cat)
                for row in cursor.fetchall():
                    # Build a dictionary that holds IDs and names for every level
                    cat_id, cat_name = row['ProductCategoryID'], row['ProductCategoryName']
                    subcat_id, subcat_name = row['ProductSubCategoryID'], row['ProductSubCategoryName']
                    subsub = {'id': row['ProductSubSubCategoryID'], 'name': row['ProductSubSubCategoryName']}
                    
                    if cat_id not in category_tree: 
                        category_tree[cat_id] = {'name': cat_name, 'subcats': {}}
                    if subcat_id not in category_tree[cat_id]['subcats']: 
                        category_tree[cat_id]['subcats'][subcat_id] = {'name': subcat_name, 'subsubcats': []}
                    
                    category_tree[cat_id]['subcats'][subcat_id]['subsubcats'].append(subsub)
                
                if 'customer_id' in session:
                    cursor.execute("SELECT SUM(Quantity) as total FROM ShoppingCart WHERE CustomerID=%s AND IsDeleted=0", (session['customer_id'],))
                    res = cursor.fetchone()
                    cart_count = res['total'] if res and res['total'] else 0
    except Exception: pass
    return dict(categories=category_tree, cart_count=cart_count)

# --- HOME / STOREFRONT ---
@app.route("/")
def home():
    search_query = request.args.get('search', '').strip()
    # We can now filter by ANY level of category!
    main_cat = request.args.get('main_cat')
    sub_cat = request.args.get('sub_cat')
    ss_cat = request.args.get('ss_cat')
    
    sql = """
        SELECT vp.VendorProductID, vp.Price, vp.StockQuantity, p.ProductName,
               p.ProductDescription, b.BrandName, c.CompanyName, u.FullName AS VendorName, cur.CurrencySymbol
        FROM VendorProduct vp
        JOIN Product p ON vp.ProductID = p.ProductID
        JOIN ProductSubSubCategory ssc ON p.ProductSubSubCategoryID = ssc.ProductSubSubCategoryID
        JOIN ProductSubCategory sc ON ssc.ProductSubCategoryID = sc.ProductSubCategoryID
        JOIN Model m ON p.ModelID = m.ModelID
        JOIN Brand b ON m.BrandID = b.BrandID
        JOIN Company c ON b.CompanyID = c.CompanyID
        JOIN `User` u ON vp.VendorUserID = u.UserID
        JOIN Currency cur ON vp.CurrencyID = cur.CurrencyID
        WHERE vp.IsActive = 1 AND vp.IsDeleted = 0 
          AND p.IsDeleted = 0 AND u.IsActive = 1 AND vp.StockQuantity > 0
    """
    
    params = []
    if search_query:
        sql += " AND (p.ProductName LIKE %s OR b.BrandName LIKE %s OR c.CompanyName LIKE %s)"
        params.extend([f"%{search_query}%"] * 3)
    if main_cat:
        sql += " AND sc.ProductCategoryID = %s"
        params.append(main_cat)
    if sub_cat:
        sql += " AND sc.ProductSubCategoryID = %s"
        params.append(sub_cat)
    if ss_cat:
        sql += " AND p.ProductSubSubCategoryID = %s"
        params.append(ss_cat)
        
    sql += " ORDER BY p.ProductName ASC"
    
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql, params) if params else cursor.execute(sql)
            vendor_products = cursor.fetchall()
            
    return render_template("index.html", products=vendor_products, search_query=search_query)

# --- PRODUCT DETAILS PAGE (NEW!) ---
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

    # Parse JSON attributes (Specs) safely
    product['Specs'] = {}
    if product['Attributes_JSON']:
        try: product['Specs'] = json.loads(product['Attributes_JSON'])
        except: pass
        
    # Calculate average rating
    avg_rating = 0
    if reviews:
        avg_rating = round(sum(r['ProductRating'] for r in reviews if r['ProductRating']) / len(reviews), 1)

    return render_template("product.html", p=product, reviews=reviews, avg_rating=avg_rating)

# --- CART SYSTEM ---
@app.route("/cart/add", methods=["POST"])
@customer_required
def add_to_cart():
    vendor_product_id = request.form.get("vendor_product_id")
    qty_to_add = int(request.form.get("quantity", 1)) # Allow adding multiple from product page
    customer_id = session['customer_id']
    
    with get_connection() as conn:
        with conn.cursor() as cursor:
            cursor.execute("SELECT ShoppingCartID FROM ShoppingCart WHERE CustomerID=%s AND VendorProductID=%s AND IsDeleted=0", (customer_id, vendor_product_id))
            item = cursor.fetchone()
            if item:
                cursor.execute("UPDATE ShoppingCart SET Quantity = Quantity + %s WHERE ShoppingCartID=%s", (qty_to_add, item['ShoppingCartID']))
            else:
                cursor.execute("INSERT INTO ShoppingCart (CustomerID, VendorProductID, Quantity) VALUES (%s, %s, %s)", (customer_id, vendor_product_id, qty_to_add))
        conn.commit()
    flash("Added to cart successfully!", "success")
    # NEW: Redirect back to the exact page they were on!
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

# --- AUTH SYSTEM ---
@app.route("/login", methods=["GET", "POST"])
def login():
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
    return render_template("login.html")

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        full_name, email, password = request.form.get("full_name"), request.form.get("email"), request.form.get("password")
        try:
            with get_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute("INSERT INTO Customer (LoginName, PasswordHash, FullName, Email, IsActive) VALUES (%s, %s, %s, %s, 1)", (email, password, full_name, email))
                connection.commit()
            flash("Account created! You can now log in.", "success")
            return redirect(url_for("login"))
        except Exception: flash("Registration failed. Email might be in use.", "error")
    return render_template("register.html")

@app.route("/logout")
def logout():
    session.clear()
    flash("You have been logged out.", "success")
    return redirect(url_for("home"))

if __name__ == "__main__":
    app.run(debug=True, port=5001)