
    
    

with child as (
    select product_id as from_field
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__budget
    where product_id is not null
),

parent as (
    select product_id as to_field
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__products
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


