from firebase_admin import firestore
from google.cloud.firestore_v1 import Transaction

_db = firestore.client()
transaction = _db.transaction()


@firestore.transactional
def read_counter(transaction_to_use: Transaction) -> int:
    counter_doc_ref = _db.document('counters/company_id_counter')
    snapshot = counter_doc_ref.get(transaction=transaction_to_use)
    current_id = snapshot.get("id")
    print(f"Current counter id for company is {current_id}")
    new_id = (current_id if current_id is not None else 0) + 1

    # Increase counter id
    if current_id is not None:
        print("Updating counter id")
        transaction.update(counter_doc_ref, {"id": new_id})
    else:
        print("Creating new counter id")
        transaction.set(counter_doc_ref, {"id": new_id})
    return new_id
    return new_id

