
    
    

with child as (
    select user_id as from_field
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__orders
    where user_id is not null
),

parent as (
    select user_id as to_field
    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__users
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null

