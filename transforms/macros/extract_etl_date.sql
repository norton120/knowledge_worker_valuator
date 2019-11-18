{% macro extract_etl_date(filename) %}
    TO_DATE(SUBSTR({{filename}},0,10),'YYYYMMDD') 
{% endmacro %}
