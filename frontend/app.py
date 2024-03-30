from flask import Flask, render_template, request
import requests

app = Flask(__name__)


BACKEND_SERVICE_URL = 'http://saru-server.saru:5001/dict'
# BACKEND_SERVICE_URL = 'http://backend:5001/dict'
print(BACKEND_SERVICE_URL)

@app.route('/', methods = ["GET","POST"])
def home():
    print(BACKEND_SERVICE_URL)
    if request.method== "POST":
        word = request.form.get('word', None)
        try:
            response = requests.get(f'{BACKEND_SERVICE_URL}/{word}')
            print(response)
            if response.status_code == 200:
                data = response.json()
                if 'definition' in data:
                    meaning =  data['definition']
                else:
                    meaning = "No definition found for the word."
            else:
                meaning =  "Failed to retrieve definition. Please try again later."
        except requests.exceptions.RequestException:
            meaning =  "An error occurred while connecting to the dictionary service."
        print(meaning)
        return render_template('index.html',meaning = meaning)
        
    return render_template('index.html')

if __name__ == "__main__":
    app.run(port=5002, debug= True, host="0.0.0.0")

