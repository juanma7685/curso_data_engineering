{{ config(
    materialized='incremental',
    unique_key='budget_id'  
) }}


with 

source as (
    select * from {{ ref('stg_google_sheets__budget') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),

renamed as (
    select
        budget_id,
        product_id,
        quantity,
        mes,
        anyo,
        llegada_id
    from source
)

select * from renamed