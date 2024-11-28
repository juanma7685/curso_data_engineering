with 

source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed as (

    select
        address_id,
        zipcode,
        country,
        address,
        split_part(address, ' ', 1) as address_number,
        regexp_substr(address, ' (.*)', 1, 1, 'e',1) as street,
        state,
        _DLT_LOAD_ID as llegada_id

    from source

)

select * from renamed
