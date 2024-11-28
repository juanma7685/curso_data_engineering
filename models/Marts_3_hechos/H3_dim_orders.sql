with 

dim_orders as (
    select
        order_id,
        shipping_service,
        shipping_cost,
        created_at,
        estimated_delivery_at,
        p.name as nombre_promocion,
        EUR_discount,
        p.status as promo_estado,
        st.status as order_status,
        order_cost,
        order_total,
        delivered_at,
        tracking_id,
        o.llegada_id
    from 
    {{ ref('stg_sql_server_dbo__orders') }} o
    left join {{ ref('stg_sql_server_dbo__promos') }} p on o.promo_id = p.promo_id
    left join {{ ref('stg_sql_server_dbo__shipping_service') }} s on o.shipping_service_id = s.shipping_service_id
    left join {{ ref('stg_sql_server_dbo__status') }} st on o.status_id = st.status_id
)

select * from dim_orders
