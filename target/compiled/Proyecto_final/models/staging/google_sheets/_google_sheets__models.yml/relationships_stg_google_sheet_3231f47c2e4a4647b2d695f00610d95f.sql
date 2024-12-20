
    
    

with child as (
    select order_id as from_field
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__returns
    where order_id is not null
),

parent as (
    select order_id as to_field
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__orders
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


