with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(shipping_service, ''), 'Waiting')"]) }} as shipping_service_id,
        COALESCE(NULLIF(shipping_service, ''), 'Waiting') as shipping_service,
    from source
)

select distinct *
from renamed
