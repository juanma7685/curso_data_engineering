

with 

source as (
    select * from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.orders
),

renamed as (
    select
        order_id,
        md5(cast(coalesce(cast(address as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(zipcode as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(country as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(state as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as address_id,
        md5(cast(coalesce(cast(email as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as user_id,
        shipping_cost,
        CAST(created_at AS DATE) as created_at,
        CAST(estimated_delivery_at AS DATE) as estimated_delivery_at,
        order_cost,
        order_total,
        CAST(delivered_at AS DATE) as delivered_at,
        tracking_id,
        md5(cast(coalesce(cast(shipping_service as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as shipping_service_id,
        md5(cast(coalesce(cast(promo_id as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as promo_id,
        md5(cast(coalesce(cast(status as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as status_id,
        _DLT_LOAD_ID as llegada_id
    from source 
)

select * from renamed


where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__orders)
