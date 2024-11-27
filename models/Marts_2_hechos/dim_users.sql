{{ config(
    materialized='incremental',
    unique_key='user_id'
) }}

with 

source as (
    select * from {{ ref('stg_sql_server_dbo__users') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),

renamed as (
    select
        user_id,
        updated_at,
        address_id,
        last_name,
        created_at,
        phone_number,
        first_name,
        email,
        llegada_id
    from source
)

select * from renamed