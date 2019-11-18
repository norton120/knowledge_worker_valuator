#!/bin/bash
sleep 20 && \
dbt seed --full-refresh && \
tail -f /dev/null
