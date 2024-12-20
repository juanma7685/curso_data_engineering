-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__users as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__users__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.user_id = DBT_INTERNAL_DEST.user_id
            )

    
    when matched then update set
        "USER_ID" = DBT_INTERNAL_SOURCE."USER_ID","UPDATED_AT" = DBT_INTERNAL_SOURCE."UPDATED_AT","ADDRESS_ID" = DBT_INTERNAL_SOURCE."ADDRESS_ID","LAST_NAME" = DBT_INTERNAL_SOURCE."LAST_NAME","CREATED_AT" = DBT_INTERNAL_SOURCE."CREATED_AT","PHONE_NUMBER" = DBT_INTERNAL_SOURCE."PHONE_NUMBER","FIRST_NAME" = DBT_INTERNAL_SOURCE."FIRST_NAME","EMAIL" = DBT_INTERNAL_SOURCE."EMAIL","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("USER_ID", "UPDATED_AT", "ADDRESS_ID", "LAST_NAME", "CREATED_AT", "PHONE_NUMBER", "FIRST_NAME", "EMAIL", "LLEGADA_ID")
    values
        ("USER_ID", "UPDATED_AT", "ADDRESS_ID", "LAST_NAME", "CREATED_AT", "PHONE_NUMBER", "FIRST_NAME", "EMAIL", "LLEGADA_ID")

;
    commit;