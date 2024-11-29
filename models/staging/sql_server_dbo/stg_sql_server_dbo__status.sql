{{ config(
    materialized='incremental',
    unique_key='status_id'
) }}

with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
        status,
        _DLT_LOAD_ID as llegada_id
    from source
)

select distinct * from renamed

{% if is_incremental() %}

where llegada_id > (select max(llegada_id) from {{ this }})

{% endif %}