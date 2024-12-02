{% snapshot reviews_snapshot %}

{{
  config(
    target_schema='snapshots',
    unique_key='review_id',
    strategy='check',
    check_cols=['email', 'name','category', 'rating', 'comments', 'created_at']
  )
}}

select *
from {{ source('google_sheets', 'reviews') }} r

{% endsnapshot %}
