from firebase_admin import initialize_app, firestore
from firebase_functions import identity_fn, logger, https_fn

from shared.utils import generate_uuid, check_if_user_can_edit

from shared.config import COMPANY_EMAIL_DOMAIN

from google.cloud.firestore_v1 import SERVER_TIMESTAMP

initialize_app()


@https_fn.on_call()
def add_document(req: https_fn.CallableRequest) -> dict:
    """
    Firebase callable cloud function to add data to a Firestore collection.

    The caller must be authenticated and possess a custom claim whose value
    is one of the ALLOWED_ROLES (e.g. {"role": "admin"}).

    Expected request payload:
    {
        "collection": "users", # (required) Firestore collection name
        "document_id": "abc123", # (optional) custom doc ID; auto-generated if omitted
        "data": { # (required) fields to write
            "name": "Alice",
            "email": "alice@example.com"
        }
    }

    Returns:
    {
        "success": True,
        "document_id": "<id of the written document>"
    }
    """

    logger.info("Received request to add document:", req.data)
    # ── 1. Authentication guard
    if req.auth is None:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
            message="You must be signed in to call this function.",
        )

    uid = req.auth.uid  # caller's Firebase UID, available for auditing / ownership

    # ── 2. Role-based authorization
    # They arrive in req.auth.token as a plain dict.
    token_claims: dict = req.auth.token or {}
    can_edit = check_if_user_can_edit(token_claims)

    if not can_edit:
        logger.error("user doesn't have permission to edit")
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.PERMISSION_DENIED,
            message="Access denied."
        )

    # ── 3. Validate input
    data = req.data  # dict sent by the client

    collection_name: str = data.get("collection", "").strip()
    if not collection_name:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="'collection' is required and must be a non-empty string.",
        )

    document_data: dict = data.get("data")
    if not isinstance(document_data, dict) or not document_data:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="'data' is required and must be a non-empty object.",
        )

    document_id: str | None = data.get("document_id")  # maybe None → auto-id

    # This is a flag that will be used to auto-set an internal id for the document
    should_add_id_to_document: bool = data.get("should_add_id_to_document", False)

    # ── 4. Enrich the payload
    document_data["created_by"] = uid  # record who created the doc
    document_data["created_at"] = SERVER_TIMESTAMP  # server-side timestamp

    # ── 5. Write to Firestore
    db = firestore.client()
    collection_ref = db.collection(collection_name)
    final_document_id = document_id or generate_uuid()

    if should_add_id_to_document:
        document_data["id"] = final_document_id

    try:
        logger.info(f"Writing document to {collection_name} with id {final_document_id}")
        doc_ref = collection_ref.document(final_document_id)
        doc_ref.set(document_data)

    except Exception as exc:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INTERNAL,
            message=f"Failed to write document: {exc}",
        )

    # ── 6. Return the result
    logger.info(f"Document written to {collection_name} with id {final_document_id}")
    return {"success": True, "document_id": doc_ref.id}


@identity_fn.before_user_created()
def intercept_user_creation(event: identity_fn.AuthBlockingEvent) -> identity_fn.BeforeCreateResponse:
    """ Intercepts a user that is about to be created and tries to add / modify some of their info such as:
    1. marks them as verified should their email belong to incampagna's domain
    2. assign them a role """
    email = event.data.email
    logger.info(f"Event email is {email}")
    is_company_email = email is not None and COMPANY_EMAIL_DOMAIN in email
    user_email_verified = event.data.email_verified or is_company_email

    return identity_fn.BeforeCreateResponse(email_verified=user_email_verified,
                                            custom_claims={"role": "editor" if is_company_email else "viewer"})
