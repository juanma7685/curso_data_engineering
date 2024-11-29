with 

source as (
    select * 
    from {{ source('sql_server_dbo', 'addresses') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(["address", "zipcode", "country", "state"]) }} as address_id,
        zipcode,
        country,
        address,
        split_part(address, ' ', 1) as address_number,
        regexp_substr(address, ' (.*)', 1, 1, 'e', 1) as street,
        state,
        _DLT_LOAD_ID as llegada_id
    from source
),

no_addresses as (
    select
        {{ dbt_utils.generate_surrogate_key(["null","null","null","null"]) }} as address_id,
        null as zipcode,
        'no address' as country,
        'no address' as address,
        null as address_number,
        null as street,
        null as state,
        null as llegada_id
)

select * from renamed

union all

select * from no_addresses
