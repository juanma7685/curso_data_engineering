
with 

source as (
    select * from {{ ref('stg_sql_server_dbo__event_type') }}
),

renamed as (
    select
        event_type,
        {{ dbt_utils.generate_surrogate_key(['event_type']) }} as event_type_id
    from source
    group by event_type
)

select * from renamed