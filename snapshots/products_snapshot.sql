{% snapshot products_snapshot %}

{{
  config(
    target_schema = 'snapshots',
    unique_key='product_id',
    strategy='check',
    check_cols=['precio', 'nombre_producto', 'category', 'inventory']
  )
}}

select
    product_id,
    precio,
    nombre_producto,
    category,
    inventory,
    p.llegada_id
from {{ ref('stg_sql_server_dbo__products') }} p
join {{ ref('stg_sql_server_dbo__category') }} c 
    on p.category_id = c.category_id

{% endsnapshot %}
