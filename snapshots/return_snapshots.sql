{% snapshot returns_snapshot %}

{{
  config(
    target_schema='snapshots',
    unique_key='return_id',
    strategy='check',
    check_cols=['order_id', 'user_id', 'return_date']
  )
}}

select
    return_id,
    order_id,
    user_id,
    return_date,
    r.llegada_id
from {{ ref('stg_sql_server_dbo__returns') }} r

{% endsnapshot %}
