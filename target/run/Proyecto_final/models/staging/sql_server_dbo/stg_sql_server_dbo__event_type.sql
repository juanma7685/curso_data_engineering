-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__event_type as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__event_type__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.event_type_id = DBT_INTERNAL_DEST.event_type_id
            )

    
    when matched then update set
        "EVENT_TYPE" = DBT_INTERNAL_SOURCE."EVENT_TYPE","EVENT_TYPE_ID" = DBT_INTERNAL_SOURCE."EVENT_TYPE_ID","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("EVENT_TYPE", "EVENT_TYPE_ID", "LLEGADA_ID")
    values
        ("EVENT_TYPE", "EVENT_TYPE_ID", "LLEGADA_ID")

;
    commit;