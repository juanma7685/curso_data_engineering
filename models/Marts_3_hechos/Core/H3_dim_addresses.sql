{{ config(
    materialized='incremental',
    unique_key='address_id'  
) }}

with 
source as (
    select * 
    from {{ ref('stg_sql_server_dbo__addresses') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }}) -- Solo datos nuevos o actualizados
    {% endif %}
),

renamed as (
    select
        address_id,
        zipcode,
        country,
        address,
        street,
        address_number,
        state,
        llegada_id
    from source
)

select * from renamed
