from flask import Flask, jsonify


app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    payload = {
        'confiance': 0.8,
        'tag': 'meuble'
    }
    return jsonify(payload)

@app.route('/<float:lat>/<float:lon>', methods=['GET'])
def determine_waiting_time(lat, lon):
    payload = {
        'lat': lat * 2,
        'lon': lon * 2
    }
    return jsonify(payload)

if __name__ == '__main__':
    app.run(debug=True)
