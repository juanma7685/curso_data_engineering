with 

source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        page_url,
        -- Extraer el dominio de la URL
        regexp_substr(page_url, '^(https?://[^/]+)') as domain,
        -- Extraer el ID único de la URL
        regexp_substr(page_url, '[^/]+$', 1, 1) as page_id,
        {{ dbt_utils.generate_surrogate_key(["event_type"]) }} as event_type_id,
        {{ dbt_utils.generate_surrogate_key(["email"]) }} as user_id,
        {{ dbt_utils.generate_surrogate_key(["name", "category"]) }} as product_id,   
        session_id,
        CAST(created_at AS DATE) as created_at,
        _DLT_LOAD_ID as llegada_id

    from source

)

select * from renamed
