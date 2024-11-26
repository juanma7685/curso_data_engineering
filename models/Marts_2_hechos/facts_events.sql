{{ config(
    materialized='incremental',
    unique_key='event_id'  
) }}

with 

-- Filtra datos incrementales antes de las uniones
filtered_events as (
    select * 
    from {{ ref('stg_sql_server_dbo__events') }}
    {% if is_incremental() %}
        where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})
    {% endif %}
),

-- Une los eventos filtrados con los tipos de eventos
source as (
    select
        e.event_id,
        e.page_url,
        t.event_type,
        e.user_id,
        e.product_id,
        e.session_id,
        e.created_at,
        e._fivetran_deleted,
        e._fivetran_synced
    from 
        filtered_events e
    join {{ ref('stg_sql_server_dbo__event_type') }} t 
        on e.event_type_id = t.event_type_id
),

-- Renombra columnas para la salida final
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
