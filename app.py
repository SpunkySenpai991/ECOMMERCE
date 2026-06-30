import os
import pymysql
from functools import wraps
from flask import Flask, flash, redirect, render_template, request, url_for, session

app = Flask(__name__)
app.secret_key = "customer-frontend-secret-key"

# Pointing to the NEW database you just created
DB_CONFIG = {
    "host": os.environ.get("DB_HOST", "localhost"),
    "user": os.environ.get("DB_USER", "root"),
    "password": os.environ.get("DB_PASSWORD", "Aditya@098"),
    "database": os.environ.get("DB_NAME", "ecom_copy1"), 
    "charset": "utf8mb4",
    "cursorclass": pymysql.cursors.DictCursor,
}

def get_connection():
    return pymysql.connect(**DB_CONFIG)

def customer_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "customer_id" not in session:
            flash("Please log in first.", "error")
            return redirect(url_for("login"))
        return f(*args, **kwargs)
    return decorated_function

# --- NEW: Fetch Categories for the Dropdown globally ---
@app.context_processor
def inject_categories():
    """ This runs on every page load so the Navbar always has the categories. """
    sql = """
        SELECT 
            c.ProductCategoryName,
            sc.ProductSubCategoryName,
            ssc.ProductSubSubCategoryID, 
            ssc.ProductSubSubCategoryName
        FROM ProductCategory c
        JOIN ProductSubCategory sc ON c.ProductCategoryID = sc.ProductCategoryID
        JOIN ProductSubSubCategory ssc ON sc.ProductSubCategoryID = ssc.ProductSubCategoryID
        WHERE c.IsDeleted = 0 AND sc.IsDeleted = 0 AND ssc.IsDeleted = 0
        ORDER BY c.ProductCategoryName, sc.ProductSubCategoryName, ssc.ProductSubSubCategoryName
    """
    category_tree = {}
    try:
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute(sql)
                rows = cursor.fetchall()
                
                # Build a nested dictionary: {Category: {SubCategory: [SubSubCategories]}}
                for row in rows:
                    cat = row['ProductCategoryName']
                    subcat = row['ProductSubCategoryName']
                    subsub = {'id': row['ProductSubSubCategoryID'], 'name': row['ProductSubSubCategoryName']}
                    
                    if cat not in category_tree:
                        category_tree[cat] = {}
                    if subcat not in category_tree[cat]:
                        category_tree[cat][subcat] = []
                    
                    category_tree[cat][subcat].append(subsub)
    except Exception:
        pass # If DB is empty, just pass an empty dict
        
    return dict(categories=category_tree)

@app.route("/")
def home():
    # We removed the search logic here, so the search bar won't actually filter anything yet!
    
    sql = """
        SELECT 
            vp.VendorProductID,
            vp.Price,
            vp.StockQuantity,
            p.ProductName,
            p.ProductDescription,
            b.BrandName,
            c.CompanyName,
            u.FullName AS VendorName,
            cur.CurrencySymbol
        FROM VendorProduct vp
        JOIN Product p ON vp.ProductID = p.ProductID
        JOIN Model m ON p.ModelID = m.ModelID
        JOIN Brand b ON m.BrandID = b.BrandID
        JOIN Company c ON b.CompanyID = c.CompanyID
        JOIN `User` u ON vp.VendorUserID = u.UserID
        JOIN Currency cur ON vp.CurrencyID = cur.CurrencyID
        WHERE vp.IsActive = 1 AND vp.IsDeleted = 0 
          AND p.IsDeleted = 0 AND u.IsActive = 1 AND vp.StockQuantity > 0
        ORDER BY p.ProductName ASC
    """
    with get_connection() as connection:
        with connection.cursor() as cursor:
            cursor.execute(sql)
            vendor_products = cursor.fetchall()
            
    return render_template("index.html", products=vendor_products)

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("username")
        password = request.form.get("password")
        
        sql = "SELECT * FROM Customer WHERE LoginName=%s AND PasswordHash=%s AND IsDeleted=0 AND IsActive=1"
        with get_connection() as connection:
            with connection.cursor() as cursor:
                cursor.execute(sql, (username, password))
                customer = cursor.fetchone()
                
                if customer:
                    session['customer_id'] = customer['CustomerID']
                    session['customer_name'] = customer['FullName']
                    flash(f"Welcome back, {customer['FullName']}!", "success")
                    return redirect(url_for("home"))
                else:
                    flash("Invalid username or password.", "error")
                    
    return render_template("login.html")

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        login_name = request.form.get("login_name")
        password = request.form.get("password")
        full_name = request.form.get("full_name")
        email = request.form.get("email")
        
        try:
            sql = "INSERT INTO Customer (LoginName, PasswordHash, FullName, Email, IsActive) VALUES (%s, %s, %s, %s, 1)"
            with get_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute(sql, (login_name, password, full_name, email))
                connection.commit()
            flash("Account created! You can now log in.", "success")
            return redirect(url_for("login"))
        except Exception as exc:
            flash("Registration failed. That username might already be taken.", "error")
            
    return render_template("register.html")

@app.route("/logout")
def logout():
    session.clear()
    flash("You have been logged out.", "success")
    return redirect(url_for("home"))

if __name__ == "__main__":
    app.run(debug=True, port=5001)