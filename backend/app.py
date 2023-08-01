from flask import Flask, render_template, jsonify
import requests

app = Flask(__name__)

@app.route('/dict/<word>')
def get_meaning(word):

    dict_url = f'https://api.dictionaryapi.dev/api/v2/entries/en/{word}'
    response = requests.get(dict_url)
    print("here")
    if response.status_code == 200:
        data = response.json()
        definition = data[0]['meanings'][0]['definitions'][0]['definition']
        print(definition)
        return jsonify({'word': word, 'definition': definition})
    
    else:
        return jsonify({'error': 'Word not found'})

if __name__ == "__main__":
    app.run(debug=True, port=5001, host="0.0.0.0")


