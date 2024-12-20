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
),

deduplicated as (
    select *, 
           row_number() over (partition by status_id order by llegada_id desc) as row_num
    from renamed
)

select *
from deduplicated
where row_num = 1

{% if is_incremental() %}

and llegada_id > (select max(llegada_id) from {{ this }})

{% endif %}