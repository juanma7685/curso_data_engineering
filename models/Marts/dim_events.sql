with 

source as (
    select * from {{ ref('stg_sql_server_dbo__events') }}
),

renamed as (
    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        created_at
    from source
)

select * from renamed