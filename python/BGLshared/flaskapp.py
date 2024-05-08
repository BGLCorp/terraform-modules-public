from flask import Flask, request
from cloudevents.http import from_http
from .logging import logHandler


def create_health():
    """
    Create a basic Flask app with only kube health endpoints and default logging configuration
    """
    app = Flask(__name__)
    app.logger.handlers = logHandler

    @app.route("/health/liveness")
    def liveness():
        return "OK", 200

    @app.route("/health/readiness")
    def readiness():
        return "OK", 200

    return app

def create_post(func):
    app = create_health()

    @app.route("/", methods=["POST"])
    def home():
        # create a CloudEvent
        event = from_http(request.headers, request.get_data())
        # call a main() function on the cloudevent
        resp = func.main(event)
        return resp
    
    return app