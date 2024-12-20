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
),

deduplicated as (
    select *, 
           row_number() over (partition by event_type_id order by llegada_id desc) as row_num
    from renamed
)

select *
from deduplicated
where row_num = 1

{% if is_incremental() %}

and llegada_id > (select max(llegada_id) from {{ this }})

{% endif %}