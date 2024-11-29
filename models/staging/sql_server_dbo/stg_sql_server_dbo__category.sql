with 

source as (
    select * 
    from {{ source('sql_server_dbo', 'products') }}
),

renamed as (
    select DISTINCT
        {{ dbt_utils.generate_surrogate_key(["category"]) }} as category_id,
        category
    from source
)

select * from renamed
