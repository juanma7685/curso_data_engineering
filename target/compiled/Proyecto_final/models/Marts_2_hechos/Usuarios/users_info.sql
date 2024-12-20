WITH user_data AS (
    SELECT 
        u.user_id,
        u.first_name,
        u.last_name,
        u.email,
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(d.order_total) AS total_spent, -- Ajustado a `dim_orders.order_total`
        COALESCE(SUM(d.shipping_cost), 0) AS total_shipping_cost, -- Ajustado a `dim_orders.shipping_cost`
        COALESCE(SUM(d.EUR_discount), 0) AS total_discount,
        COALESCE(SUM(o.quantity), 0) AS total_products_bought,
        COUNT(DISTINCT o.product_id) AS total_unique_products_bought
    FROM 
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_users u
    LEFT JOIN 
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.facts_orders o ON u.user_id = o.user_id
    LEFT JOIN 
        ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_orders d ON o.order_id = d.order_id -- Agregado para usar columnas de `dim_orders`
    GROUP BY 
        u.user_id, u.first_name, u.last_name, u.email
    ORDER BY total_orders DESC
)

SELECT * 
FROM user_data