# config.py

COMPANY_EMAIL_DOMAIN = '@incampagna.eu'

# Extend or restrict this set to match your application's access model.
ALLOWED_EDIT_ROLES: frozenset[str] = frozenset({"admin", "editor"})
