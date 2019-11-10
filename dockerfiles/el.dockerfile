FROM python:3.7

RUN mkdir /app && mkdir /app_data
COPY ./extract_load /app
WORKDIR /app
COPY ./data /app_data
RUN apt-get update && \
pip3 install -r requirements.txt 

