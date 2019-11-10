FROM python:3.7

RUN mkdir /app
COPY ./dash /app
WORKDIR /app
EXPOSE 8050
RUN apt-get update && \
pip3 install -r requirements.txt && \
python3 app.py

