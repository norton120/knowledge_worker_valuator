WITH 
newest_record_date AS (
    SELECT
	MAX({{extract_etl_date('filename')}}) AS MAX_DATE
    FROM
        lake.gcals
)
,partial_durations AS (
    SELECT
        title
	,given_planned_earliest_start::date AS event_date
	,(given_planned_earliest_end::date) - (given_planned_earliest_start::date) AS days
        ,DATE_PART('hour',given_planned_earliest_end::timestamp - given_planned_earliest_start::timestamp) AS hours
        ,DATE_PART('minute',given_planned_earliest_end::timestamp - given_planned_earliest_start::timestamp) AS minutes
        ,DATE_PART('second',given_planned_earliest_end::timestamp - given_planned_earliest_start::timestamp) AS seconds
    ,CASE 
        WHEN notes ILIKE '%KWV=%' THEN 
            TRIM(RIGHT(SUBSTR(notes, POSITION('KWV=' IN  notes),6),2)) 
        ELSE 
            NULL 
        END AS raw_kwv
    FROM 
        lake.gcals
    WHERE
	{{extract_etl_date('filename')}}  = (SELECT MAX_DATE FROM newest_record_date)
)
,merged_durations AS (
    SELECT
        title
	,event_date
        ,MAX((days * 24 * 60 * 60) + (hours * 60 * 60) + (minutes * 60) + seconds ) AS duration
	,MAX(CASE 
            WHEN raw_kwv~E'^\\d+$' THEN raw_kwv::integer 
	    ELSE 0 
        END) AS kw_value_key
    FROM
        partial_durations
    WHERE event_date >= '2019-11-04'::date
    GROUP BY 1,2
)
SELECT
    title
    ,event_date
    ,duration
    ,kw_value_key
FROM
    merged_durations
