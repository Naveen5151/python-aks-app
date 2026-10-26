from models.user import User, db


def create_user(username, email, role):
    user = User(username=username, email=email, role=role)
    db.session.add(user)
    db.session.commit()
    return user


def get_all_users():
    return User.query.order_by(User.id.asc()).all()
