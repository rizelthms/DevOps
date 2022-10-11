from flask import Flask, abort
from random import randint 
import logging

app = Flask(__name__)


@app.route("/")
def home():
    return str([randint(1, 6) for _ in range(5)])


@app.route("/error")
def error():
    abort(500)


if __name__ == '__main__':
    # Log to file.
    logger = logging.getLogger('werkzeug')
    handler = logging.FileHandler('access.log')
    logger.addHandler(handler)

    app.run(debug=True)