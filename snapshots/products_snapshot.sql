{% snapshot products_snapshot %}

{{
  config(
    target_schema = 'snapshots',
    unique_key='product_id',
    strategy='check',
    check_cols=['price','name', 'category', 'inventory']
  )
}}

select *,
{{ dbt_utils.generate_surrogate_key(["name", "category"]) }} as product_id
from {{ source('sql_server_dbo', 'products') }}  p

{% endsnapshot %}
