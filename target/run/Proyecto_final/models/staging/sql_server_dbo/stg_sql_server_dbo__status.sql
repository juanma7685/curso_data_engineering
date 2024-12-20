-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__status as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__status__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.status_id = DBT_INTERNAL_DEST.status_id
            )

    
    when matched then update set
        "STATUS_ID" = DBT_INTERNAL_SOURCE."STATUS_ID","STATUS" = DBT_INTERNAL_SOURCE."STATUS","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("STATUS_ID", "STATUS", "LLEGADA_ID")
    values
        ("STATUS_ID", "STATUS", "LLEGADA_ID")

;
    commit;