from .logging import logHandler


def create_health():
    """
    Create a basic Flask app with only kube health endpoints and default logging configuration
    """
    from flask import Flask
    app = Flask(__name__)
    app.logger.handlers = [logHandler]

    @app.route("/health/liveness")
    def liveness():
        return "OK", 200

    @app.route("/health/readiness")
    def readiness():
        return "OK", 200

    return app

def create_post(func):
    from flask import request
    from cloudevents.core.bindings.http import from_http_event, HTTPMessage
    app = create_health()

    @app.route("/", methods=["POST"])
    def home():
        # create a CloudEvent from the Knative-delivered binary CloudEvent
        event = from_http_event(HTTPMessage(headers=dict(request.headers), body=request.get_data()))
        # call a main() function on the cloudevent
        resp = func.main(event)
        return resp

    return app