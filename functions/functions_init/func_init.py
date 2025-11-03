import firebase_admin
from firebase_functions.options import set_global_options


def init_firebase_app() -> None:
    # For cost control, you can set the maximum number of containers that can be
    # running at the same time. This helps mitigate the impact of unexpected
    # traffic spikes by instead downgrading performance. This limit is a per-function
    # limit. You can override the limit for each function using the max_instances
    # parameter in the decorator, e.g. @https_fn.on_request(max_instances=5).
    set_global_options(max_instances=10)
    firebase_admin.initialize_app()
