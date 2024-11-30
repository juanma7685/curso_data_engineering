
{{ config(
    materialized='incremental',
    unique_key='return_id'  
) }}

with 

source as (
    select * from {{ ref('stg_google_sheets__returns') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),

renamed as (
    select
        return_id,
        order_id,
        user_id,
        return_date,
        llegada_id
    from source
)

select * from renamed