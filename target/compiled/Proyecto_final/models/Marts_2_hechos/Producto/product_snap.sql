

with 

source as (
    select * from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo_snap_product
    
        where llegada_id > (select max(llegada_id) from ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.product_snap)
    
),
renamed as (
    select
        product_id,
        precio,
        nombre_producto,
        category,
        inventory,
        p.llegada_id
    from source p
    join ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__category c 
        on p.category_id = c.category_id
)

select * from renamed