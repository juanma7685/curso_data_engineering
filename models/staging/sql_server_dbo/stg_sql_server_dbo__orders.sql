with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        order_id,
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(shipping_service, ''), 'Waiting')"]) }} as shipping_service_id,
        shipping_cost,
        address_id,
        CAST(created_at AS DATE) as created_at,
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(promo_id, ''), 'No Promo')"]) }} as promo_id,
        CAST(estimated_delivery_at AS DATE) as estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        CAST(delivered_at AS DATE) as delivered_at,
        tracking_id,
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
        _fivetran_deleted,
        _fivetran_synced
    from source 
)

select * from renamed
