WITH ventas_facturacion_por_estado AS (
    SELECT
        dp.product_id AS producto_id,
        dp.nombre_producto AS producto,
        da.state AS estado,
        da.country AS pais,
        SUM(fo.quantity) AS total_ventas,
        SUM(fo.quantity * dp.precio) AS total_facturacion
    FROM
        {{ ref('facts_orders') }} fo
    INNER JOIN {{ ref('dim_products') }} dp ON fo.product_id = dp.product_id
    INNER JOIN {{ ref('dim_addresses') }} da ON fo.address_id = da.address_id
    GROUP BY
        dp.product_id, dp.nombre_producto, da.state, da.country
),
estado_mas_vendido AS (
    SELECT
        producto_id,
        producto,
        estado AS estado_mas_vendido,
        pais AS pais_estado_mas_vendido,
        total_ventas
    FROM (
        SELECT
            producto_id,
            producto,
            estado,
            pais,
            total_ventas,
            RANK() OVER (PARTITION BY producto_id ORDER BY total_ventas DESC, estado ASC) AS rank_ventas
        FROM ventas_facturacion_por_estado
    ) ranked_ventas
    WHERE rank_ventas = 1
),
estado_mas_facturado AS (
    SELECT
        producto_id,
        producto,
        estado AS estado_mas_facturado,
        pais AS pais_estado_mas_facturado,
        total_facturacion
    FROM (
        SELECT
            producto_id,
            producto,
            estado,
            pais,
            total_facturacion,
            RANK() OVER (PARTITION BY producto_id ORDER BY total_facturacion DESC, estado ASC) AS rank_facturacion
        FROM ventas_facturacion_por_estado
    ) ranked_facturacion
    WHERE rank_facturacion = 1
)
SELECT
    emv.producto_id AS producto_id,
    emv.producto AS producto,
    emv.estado_mas_vendido,
    emv.pais_estado_mas_vendido,
    emv.total_ventas AS ventas_estado_mas_vendido,
    emf.estado_mas_facturado,
    emf.pais_estado_mas_facturado,
    emf.total_facturacion AS facturacion_estado_mas_facturado
FROM
    estado_mas_vendido emv
FULL JOIN estado_mas_facturado emf ON emv.producto_id = emf.producto_id
