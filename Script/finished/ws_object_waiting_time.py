from flask import Flask, jsonify
from object_waiting_time import object_waiting_time

app = Flask(__name__)

# On place les parametre dans l'URL
@app.route('/<int:id_sub_category>/<object_state>/', methods=['GET'])
# Fonction retournant les probabilites au format json
def determine_waiting_time(id_sub_category, object_state):
    
    [h,d,w,m] = object_waiting_time(id_sub_category,object_state)

    payload = {
        'proba_hour': h,
        'proba_day': d,
        'proba_week' : w,
        'proba_month' : m
    }
    return jsonify(payload)

if __name__ == '__main__':
    app.run(debug=True)


