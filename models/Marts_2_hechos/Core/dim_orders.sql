{{ config(
    materialized='incremental',
    unique_key='order_id'  
) }}

with 

-- Filtra datos incrementales antes de las uniones
filtered_orders as (
    select * 
    from {{ ref('stg_sql_server_dbo__orders') }}
    {% if is_incremental() %}
        where llegada_id > (select max(llegada_id) from {{ this }})
    {% endif %}
),

-- Construye la dimension combinando con otras tablas
dim_orders as (
    select
        o.order_id,
        s.shipping_service,
        o.shipping_cost,
        o.created_at,
        o.estimated_delivery_at,
        p.name as nombre_promocion,
        p.EUR_discount,
        p.status as promo_estado,
        st.status as order_status,
        o.order_cost,
        o.order_total,
        o.delivered_at,
        o.tracking_id,
        o.llegada_id
    from 
        filtered_orders o
    left join {{ ref('stg_sql_server_dbo__promos') }} p on o.promo_id = p.promo_id
    left join {{ ref('stg_sql_server_dbo__shipping_service') }} s on o.shipping_service_id = s.shipping_service_id
    left join {{ ref('stg_sql_server_dbo__status') }} st on o.status_id = st.status_id
)

select * from dim_orders
