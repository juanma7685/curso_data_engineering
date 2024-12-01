{% snapshot reviews_snapshot %}

{{
  config(
    target_schema='snapshots',
    unique_key='review_id',
    strategy='check',
    check_cols=['user_id', 'product_id', 'rating', 'comments', 'created_at']
  )
}}

select
    review_id,
    user_id,
    product_id,
    rating,
    comments,
    created_at,
    r.llegada_id
from {{ ref('stg_google_sheets__reviews') }} r

{% endsnapshot %}
