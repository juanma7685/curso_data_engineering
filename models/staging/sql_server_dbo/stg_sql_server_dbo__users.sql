with 

source as (
    select * from {{ source('sql_server_dbo', 'users') }}
),

renamed as (
    select
        user_id,
        CAST(updated_at AS DATE) as updated_at,
        address_id,
        last_name,
        CAST(created_at AS DATE) as created_at,
        phone_number,
        first_name,
        email,
        _DLT_LOAD_ID as llegada_id
    from source
)

select * from renamed
