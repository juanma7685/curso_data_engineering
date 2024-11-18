with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        order_id,
        shipping_service,
        shipping_cost,
        address_id,
        created_at,
        b.promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        tracking_id,
        a.status,
        a._fivetran_deleted,
        a._fivetran_synced
    from source a
    inner join {{ ref("stg_sql_server_dbo__promos") }} b 
        on COALESCE(NULLIF(a.promo_id, ''), 'No Promo') = b.name -- Aseguramos que name no tenga espacios extra
)

select * from renamed
