-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_budget as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_2_hechos.dim_budget__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.budget_id = DBT_INTERNAL_DEST.budget_id
            )

    
    when matched then update set
        "BUDGET_ID" = DBT_INTERNAL_SOURCE."BUDGET_ID","PRODUCT_ID" = DBT_INTERNAL_SOURCE."PRODUCT_ID","QUANTITY" = DBT_INTERNAL_SOURCE."QUANTITY","MES" = DBT_INTERNAL_SOURCE."MES","ANYO" = DBT_INTERNAL_SOURCE."ANYO","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("BUDGET_ID", "PRODUCT_ID", "QUANTITY", "MES", "ANYO", "LLEGADA_ID")
    values
        ("BUDGET_ID", "PRODUCT_ID", "QUANTITY", "MES", "ANYO", "LLEGADA_ID")

;
    commit;