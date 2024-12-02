
{{ config(
    materialized='incremental',
    unique_key='review_id'  
) }}

with 

source as (
    select * from {{ ref('stg_google_sheets__snap_reviews') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),

renamed as (
    select
        review_id,
        user_id,
        product_id,
        rating,
        comments,
        created_at,
        llegada_id
    from source
)

select * from renamed