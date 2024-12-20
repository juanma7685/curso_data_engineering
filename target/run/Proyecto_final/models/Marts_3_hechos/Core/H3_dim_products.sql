-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_products as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_products__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.product_id = DBT_INTERNAL_DEST.product_id
            )

    
    when matched then update set
        "PRODUCT_ID" = DBT_INTERNAL_SOURCE."PRODUCT_ID","PRECIO" = DBT_INTERNAL_SOURCE."PRECIO","NOMBRE_PRODUCTO" = DBT_INTERNAL_SOURCE."NOMBRE_PRODUCTO","CATEGORY" = DBT_INTERNAL_SOURCE."CATEGORY","INVENTORY" = DBT_INTERNAL_SOURCE."INVENTORY","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("PRODUCT_ID", "PRECIO", "NOMBRE_PRODUCTO", "CATEGORY", "INVENTORY", "LLEGADA_ID")
    values
        ("PRODUCT_ID", "PRECIO", "NOMBRE_PRODUCTO", "CATEGORY", "INVENTORY", "LLEGADA_ID")

;
    commit;