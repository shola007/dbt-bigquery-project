    {{
    config(
    materialized='incremental',
    event_time='created_at',
    incremental_strategy='microbatch',
    batch_size = 'day',
    begin='2025-01-01',
    lookback=2,
    on_schema_change='sync_all_columns',
    partition_by={
        "field": "created_at",
        "data_type": "timestamp",
        "granularity": "day"
    }
    )

 }}
 WITH source AS(
    SELECT 
        * 
    FROM 
        {{ source('thelook_ecommerce', 'events') }}
    
 )
 SELECT
    id AS event_id,
	user_id,
	sequence_number,
	session_id,
	created_at,
	ip_address,
	city,
	state,
	postal_code,
	browser,
	traffic_source,
	uri AS web_link,
	event_type
FROM source
  