-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__order_items as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__order_items__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.order_items_id = DBT_INTERNAL_DEST.order_items_id
            )

    
    when matched then update set
        "ORDER_ITEMS_ID" = DBT_INTERNAL_SOURCE."ORDER_ITEMS_ID","ORDER_ID" = DBT_INTERNAL_SOURCE."ORDER_ID","PRODUCT_ID" = DBT_INTERNAL_SOURCE."PRODUCT_ID","QUANTITY" = DBT_INTERNAL_SOURCE."QUANTITY","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("ORDER_ITEMS_ID", "ORDER_ID", "PRODUCT_ID", "QUANTITY", "LLEGADA_ID")
    values
        ("ORDER_ITEMS_ID", "ORDER_ID", "PRODUCT_ID", "QUANTITY", "LLEGADA_ID")

;
    commit;