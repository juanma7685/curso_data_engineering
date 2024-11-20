
with 

source as (
    select * from {{ ref('stg_sql_server_dbo__users') }}
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
        email
    from source
    where _fivetran_deleted = false
)

select * from renamed