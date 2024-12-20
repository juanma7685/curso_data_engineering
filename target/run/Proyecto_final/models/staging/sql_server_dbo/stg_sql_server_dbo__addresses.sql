-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__addresses as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__addresses__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.address_id = DBT_INTERNAL_DEST.address_id
            )

    
    when matched then update set
        "ADDRESS_ID" = DBT_INTERNAL_SOURCE."ADDRESS_ID","ZIPCODE" = DBT_INTERNAL_SOURCE."ZIPCODE","COUNTRY" = DBT_INTERNAL_SOURCE."COUNTRY","ADDRESS" = DBT_INTERNAL_SOURCE."ADDRESS","ADDRESS_NUMBER" = DBT_INTERNAL_SOURCE."ADDRESS_NUMBER","STREET" = DBT_INTERNAL_SOURCE."STREET","STATE" = DBT_INTERNAL_SOURCE."STATE","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID","ROW_NUM" = DBT_INTERNAL_SOURCE."ROW_NUM"
    

    when not matched then insert
        ("ADDRESS_ID", "ZIPCODE", "COUNTRY", "ADDRESS", "ADDRESS_NUMBER", "STREET", "STATE", "LLEGADA_ID", "ROW_NUM")
    values
        ("ADDRESS_ID", "ZIPCODE", "COUNTRY", "ADDRESS", "ADDRESS_NUMBER", "STREET", "STATE", "LLEGADA_ID", "ROW_NUM")

;
    commit;