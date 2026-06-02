from firebase_admin import initialize_app
from firebase_functions import identity_fn

initialize_app()

from firestore_funcs.data_reader import (
    read_counter, transaction
)
from firebase_functions.firestore_fn import (
    on_document_created,
    Event,
    DocumentSnapshot,
)

from shared.config import COMPANY_EMAIL_DOMAIN


@identity_fn.before_user_created()
def intercept_user_creation(event: identity_fn.AuthBlockingEvent) -> identity_fn.BeforeCreateResponse:
    """ Intercepts a user that is about to be created and tries to add / modify some of their info such as:
    1. marks them as verified should their email belong to incampagna's domain
    2. assign them a role """
    email = event.data.email
    print(f"Event email is {email}")
    is_company_email = email is not None and COMPANY_EMAIL_DOMAIN in email
    user_email_verified = event.data.email_verified or is_company_email

    return identity_fn.BeforeCreateResponse(email_verified=user_email_verified,
                                            custom_claims={"role": "editor" if is_company_email else "viewer"})
