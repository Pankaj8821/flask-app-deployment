from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def home():
    # Get client IP - handling potential proxy headers
    if request.headers.getlist("X-Forwarded-For"):
        ip = request.headers.getlist("X-Forwarded-For")[0]
    else:
        ip = request.remote_addr

    return jsonify({
        "timestamp": datetime.now().isoformat(),
        "ip": ip
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
