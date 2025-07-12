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
