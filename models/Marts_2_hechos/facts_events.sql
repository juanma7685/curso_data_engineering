{{ config(
    materialized='incremental',
    unique_key='event_id'
) }}

with 

source as (
    select * from {{ ref('stg_sql_server_dbo__events') }} 
    join {{ ref('stg_sql_server_dbo__event_type') }}
    on stg_sql_server_dbo__events.event_type_id = stg_sql_server_dbo__event_type.event_type_id
    {% if is_incremental() %}
        where stg_sql_server_dbo__events._fivetran_synced > (select max(_fivetran_synced) from {{ this }})
    {% endif %}
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
        _fivetran_deleted,
        _fivetran_synced
    from source
)

select * from renamed