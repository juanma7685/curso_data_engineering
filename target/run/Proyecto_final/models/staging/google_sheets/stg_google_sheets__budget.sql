-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__budget as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_google_sheets__budget__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.budget_id = DBT_INTERNAL_DEST.budget_id
            )

    
    when matched then update set
        "BUDGET_ID" = DBT_INTERNAL_SOURCE."BUDGET_ID","PRODUCT_ID" = DBT_INTERNAL_SOURCE."PRODUCT_ID","QUANTITY" = DBT_INTERNAL_SOURCE."QUANTITY","MES" = DBT_INTERNAL_SOURCE."MES","ANYO" = DBT_INTERNAL_SOURCE."ANYO","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID","ROW_NUM" = DBT_INTERNAL_SOURCE."ROW_NUM"
    

    when not matched then insert
        ("BUDGET_ID", "PRODUCT_ID", "QUANTITY", "MES", "ANYO", "LLEGADA_ID", "ROW_NUM")
    values
        ("BUDGET_ID", "PRODUCT_ID", "QUANTITY", "MES", "ANYO", "LLEGADA_ID", "ROW_NUM")

;
    commit;