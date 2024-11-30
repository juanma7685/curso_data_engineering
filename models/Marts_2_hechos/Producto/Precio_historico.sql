WITH product_history AS (
    SELECT 
        product_id,
        precio AS current_price,
        FIRST_VALUE(precio) OVER (PARTITION BY product_id ORDER BY dbt_valid_from ASC) AS original_price
    FROM {{ ref('products_snapshot') }}
    WHERE dbt_valid_to IS NULL -- Solo toma la versión actual del producto
)

SELECT
    product_id,
    original_price,
    current_price,
    current_price - original_price AS price_difference
FROM product_history
