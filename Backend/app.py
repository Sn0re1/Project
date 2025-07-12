from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS
import json
import os


app = Flask(__name__, static_folder="../frontend", static_url_path="")
CORS(app)

DATA_FILE = "products.json"
def load_products():
    if not os.path.exists(DATA_FILE):
        return []
    with open(DATA_FILE, "r") as file:
        return json.load(file)


def save_products(products):
    with open(DATA_FILE, "w") as file:
        json.dump(products, file, indent=4)
        
@app.route("/")
def index():
    return send_from_directory(app.static_folder, "login.html")


@app.route("/<path:path>")
def serve_static(path):
    return send_from_directory(app.static_folder, path)

@app.route("/api/products", methods=["GET"])
def get_products():
    return jsonify(load_products())

@app.route("/api/products", methods=["POST"])
def create_product():
    new_product = request.json
    products = load_products()
    products.append(new_product)
    save_products(products)
    return jsonify({"message": "Product added"}), 201

@app.route("/api/products/<id>", methods=["PUT"])
def update_product(id):
    data = request.json
    products = load_products()
    for product in products:
        if str(product["id"]) == str(id):
            product.update(data)
            save_products(products)
            return jsonify({"message": "Product updated"})
    return jsonify({"error": "Product not found"}), 404

@app.route("/api/products/<id>", methods=["DELETE"])
def delete_product(id):
    products = load_products()
    products = [p for p in products if str(p["id"]) != str(id)]
    save_products(products)
    return jsonify({"message": "Product deleted"}), 200



