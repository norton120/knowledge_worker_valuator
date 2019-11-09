FROM python:3.7

RUN mkdir /app 
COPY . /app
WORKDIR /app
RUN apt-get update && \
pip3 install -r requirements.txt


