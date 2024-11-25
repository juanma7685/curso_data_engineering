with 

source as (
    select * from {{ ref('stg_sql_server_dbo__addresses') }}
),

renamed as (
    select
        address_id,
        zipcode,
        country,
        address,
        street,
        address_number,
        state
    from source
)

select * from renamed