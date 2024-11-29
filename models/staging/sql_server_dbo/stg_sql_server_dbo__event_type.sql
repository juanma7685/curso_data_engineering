{{ config(
    materialized='incremental',
    unique_key='event_type_id'
) }}

with 

source as (
    select * from {{ source('sql_server_dbo', 'events') }}
),

renamed as (
    select
        event_type,
        {{ dbt_utils.generate_surrogate_key(['event_type']) }} as event_type_id,
        _DLT_LOAD_ID as llegada_id
    from source
    group by event_type, _DLT_LOAD_ID
)

select * from renamed

{% if is_incremental() %}

where llegada_id > (select max(llegada_id) from {{ this }})

{% endif %}