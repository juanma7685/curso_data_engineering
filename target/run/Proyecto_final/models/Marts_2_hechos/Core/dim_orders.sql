-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_orders as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_orders__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.order_id = DBT_INTERNAL_DEST.order_id
            )

    
    when matched then update set
        "ORDER_ID" = DBT_INTERNAL_SOURCE."ORDER_ID","SHIPPING_SERVICE" = DBT_INTERNAL_SOURCE."SHIPPING_SERVICE","SHIPPING_COST" = DBT_INTERNAL_SOURCE."SHIPPING_COST","CREATED_AT" = DBT_INTERNAL_SOURCE."CREATED_AT","ESTIMATED_DELIVERY_AT" = DBT_INTERNAL_SOURCE."ESTIMATED_DELIVERY_AT","NOMBRE_PROMOCION" = DBT_INTERNAL_SOURCE."NOMBRE_PROMOCION","EUR_DISCOUNT" = DBT_INTERNAL_SOURCE."EUR_DISCOUNT","PROMO_ESTADO" = DBT_INTERNAL_SOURCE."PROMO_ESTADO","ORDER_STATUS" = DBT_INTERNAL_SOURCE."ORDER_STATUS","ORDER_COST" = DBT_INTERNAL_SOURCE."ORDER_COST","ORDER_TOTAL" = DBT_INTERNAL_SOURCE."ORDER_TOTAL","DELIVERED_AT" = DBT_INTERNAL_SOURCE."DELIVERED_AT","TRACKING_ID" = DBT_INTERNAL_SOURCE."TRACKING_ID","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("ORDER_ID", "SHIPPING_SERVICE", "SHIPPING_COST", "CREATED_AT", "ESTIMATED_DELIVERY_AT", "NOMBRE_PROMOCION", "EUR_DISCOUNT", "PROMO_ESTADO", "ORDER_STATUS", "ORDER_COST", "ORDER_TOTAL", "DELIVERED_AT", "TRACKING_ID", "LLEGADA_ID")
    values
        ("ORDER_ID", "SHIPPING_SERVICE", "SHIPPING_COST", "CREATED_AT", "ESTIMATED_DELIVERY_AT", "NOMBRE_PROMOCION", "EUR_DISCOUNT", "PROMO_ESTADO", "ORDER_STATUS", "ORDER_COST", "ORDER_TOTAL", "DELIVERED_AT", "TRACKING_ID", "LLEGADA_ID")

;
    commit;