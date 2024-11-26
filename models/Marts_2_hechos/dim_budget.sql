{{ config(
    materialized='incremental',
    unique_key='budget_id'
) }}

with 

source as (
    select * from {{ ref('stg_google_sheets__budget') }}
    {% if is_incremental() %}
        where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})
    {% endif %}
),

renamed as (
    select
        budget_id,
        product_id,
        quantity,
        mes,
        anyo,
        _fivetran_deleted,
        _fivetran_synced
    from source
)

select * from renamed