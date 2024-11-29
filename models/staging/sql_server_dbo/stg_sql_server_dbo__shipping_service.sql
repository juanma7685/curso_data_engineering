with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(["shipping_service"]) }} as shipping_service_id,
        shipping_service
    from source
)

select distinct * from renamed
