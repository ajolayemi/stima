import uuid

from shared.config import ALLOWED_EDIT_ROLES


def generate_uuid():
    """ Generates a UUID without the dashes"""
    return str(uuid.uuid4()).replace("-", "")


def check_if_user_can_edit(claims: dict) -> bool:
    """ Checks if the user has the required role to edit a document"""
    current_role = claims.get("role", "")

    return current_role in ALLOWED_EDIT_ROLES
