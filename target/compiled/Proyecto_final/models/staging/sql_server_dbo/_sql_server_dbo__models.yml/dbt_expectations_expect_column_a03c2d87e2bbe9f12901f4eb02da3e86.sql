

with all_values as (

    select
        status as value_field

    from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__status
    

),
set_values as (

    select
        cast('preparing' as TEXT) as value_field
    union all
    select
        cast('delivered' as TEXT) as value_field
    union all
    select
        cast('shipped' as TEXT) as value_field
    
    
),
validation_errors as (
    -- values from the model that are not in the set
    select
        v.value_field
    from
        all_values v
        left join
        set_values s on v.value_field = s.value_field
    where
        s.value_field is null

)

select *
from validation_errors

