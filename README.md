
# Dockerized Dictionary App

The Dictionary App is a simple microservices application built using Flask. It allows users to look up the definition of a word using a free dictionary API.

## How it Works
The app consists of two microservices:

* Frontend: The frontend service provides a user interface where users can enter a word and request its definition. It communicates with the backend service to fetch the definition for the entered word.

* Backend: The backend service is responsible for interacting with the free dictionary API to retrieve the definition for a given word. It responds to requests from the frontend service with the word's definition.

## Installation and Setup

Make sure you have Docker installed on your system.

Clone this repository to your local machine:

`git clone https://github.com/your-username/dictionary.git`

`cd dictionary`

Run the following command to build and start the containers:

`docker-compose up --build`

Open your web browser and visit the frontend service url to access the app.

Enter a word in the input field and click the "Find Meaning" button. The app will display the definition of the entered word, fetched from the dictionary API.

To stop the application, press Ctrl + C in the terminal where the Docker containers are running.

## Technologies Used
* Flask: Python web framework used to build the microservices.
* Docker: Containerization tool used to package the app and its dependencies into containers.
* Bootstrap: Frontend framework for a responsive and visually appealing user interface.
* Requests: Python library used for making HTTP requests to the free dictionary API.


