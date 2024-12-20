-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo_snap_product as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo_snap_product__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.product_id = DBT_INTERNAL_DEST.product_id
            )

    
    when matched then update set
        "PRODUCT_ID" = DBT_INTERNAL_SOURCE."PRODUCT_ID","PRECIO" = DBT_INTERNAL_SOURCE."PRECIO","NOMBRE_PRODUCTO" = DBT_INTERNAL_SOURCE."NOMBRE_PRODUCTO","CATEGORY_ID" = DBT_INTERNAL_SOURCE."CATEGORY_ID","INVENTORY" = DBT_INTERNAL_SOURCE."INVENTORY","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID","ROW_NUM" = DBT_INTERNAL_SOURCE."ROW_NUM"
    

    when not matched then insert
        ("PRODUCT_ID", "PRECIO", "NOMBRE_PRODUCTO", "CATEGORY_ID", "INVENTORY", "LLEGADA_ID", "ROW_NUM")
    values
        ("PRODUCT_ID", "PRECIO", "NOMBRE_PRODUCTO", "CATEGORY_ID", "INVENTORY", "LLEGADA_ID", "ROW_NUM")

;
    commit;