from flask import Flask
# added a comment
app = Flask(__name__)


@app.route('/')
def hello_Docker():
    return 'hello, Docker'


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')

