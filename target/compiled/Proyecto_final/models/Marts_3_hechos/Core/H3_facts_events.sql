

with 

filtered_events as (
    select * 
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__events
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_events)
    
),

source as (
    select
        e.event_id,
        e.page_url,
        t.event_type,
        e.user_id,
        e.product_id,
        e.session_id,
        e.created_at,
        e.llegada_id
    from 
        filtered_events e
    join ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__event_type t 
        on e.event_type_id = t.event_type_id
),

renamed as (
    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        created_at,
        llegada_id
    from source
)

select * from renamed