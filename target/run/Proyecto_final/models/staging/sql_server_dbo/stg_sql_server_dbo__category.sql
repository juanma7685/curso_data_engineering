-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__category as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__category__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.category_id = DBT_INTERNAL_DEST.category_id
            )

    
    when matched then update set
        "CATEGORY_ID" = DBT_INTERNAL_SOURCE."CATEGORY_ID","CATEGORY" = DBT_INTERNAL_SOURCE."CATEGORY","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("CATEGORY_ID", "CATEGORY", "LLEGADA_ID")
    values
        ("CATEGORY_ID", "CATEGORY", "LLEGADA_ID")

;
    commit;