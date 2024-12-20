-- back compat for old kwarg name
  
  begin;
    
        
            
            
        
    

    

    merge into ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_reviews as DBT_INTERNAL_DEST
        using ALUMNO11_PRO_GOLD_DB.ALUMNO11_Marts_3_hechos.H3_dim_reviews__dbt_tmp as DBT_INTERNAL_SOURCE
        on (
                DBT_INTERNAL_SOURCE.review_id = DBT_INTERNAL_DEST.review_id
            )

    
    when matched then update set
        "REVIEW_ID" = DBT_INTERNAL_SOURCE."REVIEW_ID","USER_ID" = DBT_INTERNAL_SOURCE."USER_ID","PRODUCT_ID" = DBT_INTERNAL_SOURCE."PRODUCT_ID","RATING" = DBT_INTERNAL_SOURCE."RATING","COMMENTS" = DBT_INTERNAL_SOURCE."COMMENTS","CREATED_AT" = DBT_INTERNAL_SOURCE."CREATED_AT","LLEGADA_ID" = DBT_INTERNAL_SOURCE."LLEGADA_ID"
    

    when not matched then insert
        ("REVIEW_ID", "USER_ID", "PRODUCT_ID", "RATING", "COMMENTS", "CREATED_AT", "LLEGADA_ID")
    values
        ("REVIEW_ID", "USER_ID", "PRODUCT_ID", "RATING", "COMMENTS", "CREATED_AT", "LLEGADA_ID")

;
    commit;