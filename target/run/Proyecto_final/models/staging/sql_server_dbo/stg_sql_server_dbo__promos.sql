-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__promos as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__promos__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.promo_id = DBT_INTERNAL_DEST.promo_id
            )

    
    when matched then update set
        "PROMO_ID" = DBT_INTERNAL_SOURCE."PROMO_ID","NAME" = DBT_INTERNAL_SOURCE."NAME","EUR_DISCOUNT" = DBT_INTERNAL_SOURCE."EUR_DISCOUNT","STATUS" = DBT_INTERNAL_SOURCE."STATUS","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID","ROW_NUM" = DBT_INTERNAL_SOURCE."ROW_NUM"
    

    when not matched then insert
        ("PROMO_ID", "NAME", "EUR_DISCOUNT", "STATUS", "LLEGADA_ID", "ROW_NUM")
    values
        ("PROMO_ID", "NAME", "EUR_DISCOUNT", "STATUS", "LLEGADA_ID", "ROW_NUM")

;
    commit;