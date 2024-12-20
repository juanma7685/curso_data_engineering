-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__returns as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__returns__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.return_id = DBT_INTERNAL_DEST.return_id
            )

    
    when matched then update set
        "RETURN_ID" = DBT_INTERNAL_SOURCE."RETURN_ID","ORDER_ID" = DBT_INTERNAL_SOURCE."ORDER_ID","USER_ID" = DBT_INTERNAL_SOURCE."USER_ID","RETURN_DATE" = DBT_INTERNAL_SOURCE."RETURN_DATE","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("RETURN_ID", "ORDER_ID", "USER_ID", "RETURN_DATE", "LLEGADA_ID")
    values
        ("RETURN_ID", "ORDER_ID", "USER_ID", "RETURN_DATE", "LLEGADA_ID")

;
    commit;