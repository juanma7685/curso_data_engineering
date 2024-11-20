
with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        order_id,
        address_id,
        user_id,
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(shipping_service, ''), 'Waiting')"]) }} as shipping_service_id,
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(promo_id, ''), 'No Promo')"]) }} as promo_id,
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id
    from source 
)

select * from renamed