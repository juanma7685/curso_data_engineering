with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
        status,
    from source
)

select * from renamed