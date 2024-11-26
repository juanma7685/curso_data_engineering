{{ config(
    materialized='incremental',
    unique_key='address_id'  
) }}

with 
source as (
    select * 
    from {{ ref('stg_sql_server_dbo__addresses') }}
    {% if is_incremental() %}
        where _fivetran_synced > (select max(_fivetran_synced) from {{ this }}) -- Solo datos nuevos o actualizados
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
        _fivetran_deleted,
        _fivetran_synced
    from source
)

select * from renamed
