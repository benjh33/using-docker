import requests
import hashlib
import redis
import html
import os

from flask import Flask, Response, request

app = Flask(__name__)
default_name = "Joe Bloggs"
unique_salt = "unique-salt"
cache = redis.StrictRedis(os.environ.get('REDIS_PORT_6379_TCP_ADDR', ''))
dmonster = "http://{}:{}".format(
        os.environ.get('DNMONSTER_PORT_8080_TCP_ADDR', ''), 
        os.environ.get('DNMONSTER_PORT_8080_TCP_PORT', ''))


@app.route('/monster/<name>')
def get_identicon(name):
    image = cache.get(html.escape(name, quote=True))
    if image is None:
        r = requests.get(dmonster + '/monster/' + \
                name + '?size=80')
        image = r.content
        cache.set(name, image)
    return Response(image, mimetype='image/png')

@app.route('/', methods=['GET', 'POST'])
def main():
    name = default_name
    if request.method == "POST":
        name = html.escape(request.form.get('name'), quote=True)
    hash_name = hashlib.sha256((name + unique_salt).encode()).hexdigest()
    header = """
    <html><head><title>Identidock</title></head><body>
    """
    body = """
    <form method="POST">Hello <input type="text" name="name" value="{name}">
    <input type="submit" value="submit">
    </form>
    <p>You look like a: <img src="/monster/{hash_name}.png"/></p>
    """.format(name = name, hash_name = hash_name)
    footer = "</body></html>"
    return header + body + footer


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')

