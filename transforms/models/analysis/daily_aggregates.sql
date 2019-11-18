WITH
dates_kwv_cartesian AS (
   SELECT 
       date
       ,value_title
       ,value_key
   FROM
       (SELECT
	    DISTINCT domain_date AS date
	FROM
            {{ref('valued_domains')}}
        UNION
	SELECT
	    DISTINCT event_date AS date
	 FROM
            {{ref('gcal_events')}}) u
   FULL OUTER  JOIN
        {{ref('complete_knowledge_worker_values')}} 
   ON 1=1
)
,domain_aggs AS (
    SELECT
        domain_date AS date
	,kw_value_key
	,SUM(duration) AS duration
    FROM
        {{ref('valued_domains')}}
    GROUP BY 1,2
)
,gcal_aggs AS (
    SELECT
        event_date AS date
	,kw_value_key
	,SUM(duration) AS duration
    FROM
        {{ref('gcal_events')}}
    GROUP BY 1,2
)
SELECT
   kv.date
   ,COALESCE(merged.kw_value_key,kv.value_key) AS kw_value_key
   ,value_title AS kw_value_name
   ,SUM(COALESCE(duration,0)) AS duration
FROM
   (SELECT * FROM domain_aggs 
UNION ALL
   SELECT * FROM gcal_aggs) merged 
RIGHT JOIN 
   dates_kwv_cartesian kv
ON
   kw_value_key =value_key
GROUP BY
   1,2,3
