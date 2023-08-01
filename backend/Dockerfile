FROM python:3.9.5-slim-buster

WORKDIR /app

COPY requirements.txt .
COPY app.py .

RUN pip install -r requirements.txt

CMD ["python","app.py"]

