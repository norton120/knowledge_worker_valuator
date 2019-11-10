FROM python:3.7

RUN mkdir /app 
COPY ./transforms /app
COPY ./profiles.yml /app/profiles.yml
WORKDIR /app
RUN apt-get update && \
pip3 install -r requirements.txt && \
sleep 20 



