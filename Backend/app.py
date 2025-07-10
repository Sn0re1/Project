from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS
import json
import os


app = Flask(__name__, static_folder="../frontend", static_url_path="")
CORS(app)

DATA_FILE = "products.json"
