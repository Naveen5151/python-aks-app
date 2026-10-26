from flask import Blueprint, jsonify, request

from services.user_service import create_user, get_all_users

user_bp = Blueprint("user", __name__)


@user_bp.route("/add-user", methods=["POST"])
def add_user():
    data = request.get_json(silent=True) or {}
    username = data.get("username")
    email = data.get("email")
    role = data.get("role", "user")

    if not username or not email:
        return jsonify({"error": "username and email are required"}), 400

    user = create_user(username, email, role)
    return jsonify({
        "message": "User Added",
        "user": {
            "id": user.id,
            "username": user.username,
            "email": user.email,
            "role": user.role,
        }
    }), 201


@user_bp.route("/users", methods=["GET"])
def get_users():
    users = get_all_users()
    return jsonify({
        "users": [
            {
                "id": user.id,
                "username": user.username,
                "email": user.email,
                "role": user.role,
            }
            for user in users
        ]
    })
