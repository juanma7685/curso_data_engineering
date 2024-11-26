{{ config(
    materialized='incremental',
    unique_key='user_id'
) }}

with 

source as (
    select * from {{ ref('stg_sql_server_dbo__users') }}
    {% if is_incremental() %}
        where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})
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
        _fivetran_deleted,
        _fivetran_synced
    from source
)

select * from renamed