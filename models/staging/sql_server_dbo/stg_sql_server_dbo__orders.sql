with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        order_id,
        address_id,
        user_id,
        shipping_cost,
        CAST(created_at AS DATE) as created_at,
        CAST(estimated_delivery_at AS DATE) as estimated_delivery_at,
        order_cost,
        order_total,
        CAST(delivered_at AS DATE) as delivered_at,
        tracking_id,
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(shipping_service, ''), 'Waiting')"]) }} as shipping_service_id,
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(promo_id, ''), 'No Promo')"]) }} as promo_id,
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
        _DLT_LOAD_ID as llegada_id
    from source 
)

select * from renamed
