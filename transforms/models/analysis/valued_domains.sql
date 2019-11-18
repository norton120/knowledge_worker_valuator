WITH
mapped_domains AS (
    SELECT
        {{extract_etl_date('w.filename')}} AS domain_date
        ,w.domain
	,m.value_key AS kw_value_key
	,SUM(w.timesec::integer) AS duration
    FROM
        lake.web_domains w
    INNER JOIN
        lake.domain_mappings m
    ON 
        w.domain = m.domain
    GROUP BY
        1,2,3
)

SELECT 
    *
FROM
    mapped_domains
