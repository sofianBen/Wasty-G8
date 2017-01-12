from flask import Flask, jsonify
from recommendation_view import recommendation_view

app = Flask(__name__)

# On place les parametre dans l'URL
@app.route('/<int:id_user>/', methods=['GET'])
# Fonction retournant les probabilites au format json
def determine_object_to_recommend(id_user):
    
    one,two,three,four,five = recommendation_view(id_user)

    payload = {
        'first_recommend': str(one),
        'second_recommend': str(two),
        'third_recommend' : str(three),
        'fourth_recommend' : str(four),
        'fifth_recommend' : str(five)
    }
    return jsonify(payload)

if __name__ == '__main__':
    app.run(debug=True)
