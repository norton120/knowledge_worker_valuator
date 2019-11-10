FROM python:3.7

RUN mkdir /app 
COPY ./transforms /app
WORKDIR /app
RUN apt-get update && \
pip3 install -r requirements.txt && \
sleep 20 && \
dbt seed --profiles-dir . &&  dbt run --profiles-dir .



