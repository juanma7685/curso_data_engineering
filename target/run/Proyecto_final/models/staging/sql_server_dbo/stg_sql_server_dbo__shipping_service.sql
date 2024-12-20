-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__shipping_service as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__shipping_service__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.shipping_service_id = DBT_INTERNAL_DEST.shipping_service_id
            )

    
    when matched then update set
        "SHIPPING_SERVICE_ID" = DBT_INTERNAL_SOURCE."SHIPPING_SERVICE_ID","SHIPPING_SERVICE" = DBT_INTERNAL_SOURCE."SHIPPING_SERVICE","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("SHIPPING_SERVICE_ID", "SHIPPING_SERVICE", "LLEGADA_ID")
    values
        ("SHIPPING_SERVICE_ID", "SHIPPING_SERVICE", "LLEGADA_ID")

;
    commit;