#!/bin/bash
sleep 20 && \
dbt seed --profiles-dir ./ --full-refresh && \
dbt run --profiles-dir ./ 
