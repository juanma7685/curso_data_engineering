-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.facts_orders as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.facts_orders__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.order_id = DBT_INTERNAL_DEST.order_id
            )

    
    when matched then update set
        "ORDER_ID" = DBT_INTERNAL_SOURCE."ORDER_ID","ADDRESS_ID" = DBT_INTERNAL_SOURCE."ADDRESS_ID","USER_ID" = DBT_INTERNAL_SOURCE."USER_ID","ORDER_ITEMS_ID" = DBT_INTERNAL_SOURCE."ORDER_ITEMS_ID","PRODUCT_ID" = DBT_INTERNAL_SOURCE."PRODUCT_ID","QUANTITY" = DBT_INTERNAL_SOURCE."QUANTITY","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("ORDER_ID", "ADDRESS_ID", "USER_ID", "ORDER_ITEMS_ID", "PRODUCT_ID", "QUANTITY", "LLEGADA_ID")
    values
        ("ORDER_ID", "ADDRESS_ID", "USER_ID", "ORDER_ITEMS_ID", "PRODUCT_ID", "QUANTITY", "LLEGADA_ID")

;
    commit;