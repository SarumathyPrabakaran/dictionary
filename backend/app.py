from flask import Flask, jsonify, request
import requests
from flask_caching import Cache
import dotenv, os

dotenv.load_dotenv()

app = Flask(__name__)

app.config.from_object('config.Config') 

cache = Cache(app) 

print(os.environ)
@app.route('/dict/<word>', methods=['GET', 'POST'])
@cache.cached(timeout=300, query_string=True)
def get_meaning(word):
        definition = cache.get(word)

        if definition:
            print("Yayyy")
            return jsonify({'word': word, 'definition': definition})

        dict_url = f'https://api.dictionaryapi.dev/api/v2/entries/en/{word}'
        response = requests.get(dict_url)
        if response.status_code == 200:
            data = response.json()
            definition = data[0]['meanings'][0]['definitions'][0]['definition']
   
            return jsonify({'word': word, 'definition': definition})
        else:
            return jsonify({'error': 'Failed to fetch word definition'})



if __name__ == "__main__":
    app.run(debug=True, port=5001, host="0.0.0.0")
