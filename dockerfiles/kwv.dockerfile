FROM python:3.7

RUN mkdir /app && mkdir /.dbt 
COPY ./profiles.yml /.dbt/profiles.yml 
COPY ./transforms /app
ENV DBT_PROFILES_DIR=/.dbt
WORKDIR /app
RUN apt-get update && \
pip3 install -r requirements.txt
