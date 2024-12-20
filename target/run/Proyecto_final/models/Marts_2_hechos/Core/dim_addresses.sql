-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_addresses as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_addresses__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.address_id = DBT_INTERNAL_DEST.address_id
            )

    
    when matched then update set
        "ADDRESS_ID" = DBT_INTERNAL_SOURCE."ADDRESS_ID","ZIPCODE" = DBT_INTERNAL_SOURCE."ZIPCODE","COUNTRY" = DBT_INTERNAL_SOURCE."COUNTRY","ADDRESS" = DBT_INTERNAL_SOURCE."ADDRESS","STREET" = DBT_INTERNAL_SOURCE."STREET","ADDRESS_NUMBER" = DBT_INTERNAL_SOURCE."ADDRESS_NUMBER","STATE" = DBT_INTERNAL_SOURCE."STATE","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("ADDRESS_ID", "ZIPCODE", "COUNTRY", "ADDRESS", "STREET", "ADDRESS_NUMBER", "STATE", "LLEGADA_ID")
    values
        ("ADDRESS_ID", "ZIPCODE", "COUNTRY", "ADDRESS", "STREET", "ADDRESS_NUMBER", "STATE", "LLEGADA_ID")

;
    commit;