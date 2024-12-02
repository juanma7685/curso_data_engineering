{% snapshot products_snapshot %}

{{
  config(
    target_schema = 'snapshots',
    unique_key = 'product_id',
    strategy = 'check',
    check_cols = ['price', 'name', 'category', 'inventory']
  )
}}

WITH deduplicated_products AS (
    SELECT 
        *,
        {{ dbt_utils.generate_surrogate_key(["name", "category"]) }} AS product_id,
        ROW_NUMBER() OVER (PARTITION BY {{ dbt_utils.generate_surrogate_key(["name", "category"]) }} ORDER BY _DLT_LOAD_ID DESC) AS row_num
    FROM {{ source('sql_server_dbo', 'products') }} p
)
SELECT *
FROM deduplicated_products
WHERE row_num = 1

{% endsnapshot %}
