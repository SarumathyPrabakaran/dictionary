FROM python:3.9.5-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY app.py .
COPY config.py .



CMD ["python","app.py"]

