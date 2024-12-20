

with 

source as (

    select * from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.order_items

),

renamed as (

    select
        md5(cast(coalesce(cast(order_id as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as order_items_id,
        order_id,
        md5(cast(coalesce(cast(name as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(category as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as product_id,
        quantity,
        _DLT_LOAD_ID as llegada_id

    from source

)

select * from renamed


where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__order_items)
