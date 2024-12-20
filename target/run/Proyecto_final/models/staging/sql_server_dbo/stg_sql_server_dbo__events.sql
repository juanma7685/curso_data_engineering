-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__events as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__events__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.event_id = DBT_INTERNAL_DEST.event_id
            )

    
    when matched then update set
        "EVENT_ID" = DBT_INTERNAL_SOURCE."EVENT_ID","PAGE_URL" = DBT_INTERNAL_SOURCE."PAGE_URL","DOMAIN" = DBT_INTERNAL_SOURCE."DOMAIN","PAGE_ID" = DBT_INTERNAL_SOURCE."PAGE_ID","EVENT_TYPE_ID" = DBT_INTERNAL_SOURCE."EVENT_TYPE_ID","USER_ID" = DBT_INTERNAL_SOURCE."USER_ID","PRODUCT_ID" = DBT_INTERNAL_SOURCE."PRODUCT_ID","SESSION_ID" = DBT_INTERNAL_SOURCE."SESSION_ID","CREATED_AT" = DBT_INTERNAL_SOURCE."CREATED_AT","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("EVENT_ID", "PAGE_URL", "DOMAIN", "PAGE_ID", "EVENT_TYPE_ID", "USER_ID", "PRODUCT_ID", "SESSION_ID", "CREATED_AT", "LLEGADA_ID")
    values
        ("EVENT_ID", "PAGE_URL", "DOMAIN", "PAGE_ID", "EVENT_TYPE_ID", "USER_ID", "PRODUCT_ID", "SESSION_ID", "CREATED_AT", "LLEGADA_ID")

;
    commit;