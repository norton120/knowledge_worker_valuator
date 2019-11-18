SELECT 
    *
FROM 
   (SELECT
	value_key
	,value_title
	,description
    FROM
        lake.knowledge_worker_values
    UNION 
    SELECT
        0
        ,'No Value'
	,'No value was recorded'
    ) kwv
