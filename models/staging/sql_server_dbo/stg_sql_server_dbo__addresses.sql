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
        _fivetran_deleted,
        _fivetran_synced


    from source

)

select * from renamed
