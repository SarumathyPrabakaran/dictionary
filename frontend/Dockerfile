FROM python:3.9.5-slim-buster

WORKDIR /app

COPY requirements.txt .
COPY . .

RUN pip install -r requirements.txt

EXPOSE 5002

CMD ["python","app.py"]