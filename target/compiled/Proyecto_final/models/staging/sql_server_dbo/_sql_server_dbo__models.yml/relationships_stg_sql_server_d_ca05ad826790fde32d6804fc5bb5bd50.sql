
    
    

with child as (
    select address_id as from_field
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__orders
    where address_id is not null
),

parent as (
    select address_id as to_field
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__addresses
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


