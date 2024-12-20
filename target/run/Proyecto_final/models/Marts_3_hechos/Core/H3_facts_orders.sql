-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_orders as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_facts_orders__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.order_id = DBT_INTERNAL_DEST.order_id
            )

    
    when matched then update set
        "ORDER_ID" = DBT_INTERNAL_SOURCE."ORDER_ID","ADDRESS_ID" = DBT_INTERNAL_SOURCE."ADDRESS_ID","USER_ID" = DBT_INTERNAL_SOURCE."USER_ID","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("ORDER_ID", "ADDRESS_ID", "USER_ID", "LLEGADA_ID")
    values
        ("ORDER_ID", "ADDRESS_ID", "USER_ID", "LLEGADA_ID")

;
    commit;