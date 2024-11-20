
with 

source as (
    select * from {{ ref('stg_sql_server_dbo__promos') }}
),

renamed as (
    select
        promo_id,
        name,
        EUR_discount,
        status
    from source
    where _fivetran_deleted = false
)

select * from renamed

union all

select
    promo_id,
    name,
    EUR_discount,
    status
from {{ ref('stg_sql_server_dbo__promos') }}
where name = 'No Promo'