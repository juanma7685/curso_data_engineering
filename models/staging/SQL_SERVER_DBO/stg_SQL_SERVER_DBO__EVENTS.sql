with 

source as (

    select * from {{ source('SQL_SERVER_DBO', 'EVENTS') }}

),

renamed as (

    select
        event_id,
        TRIM(page_url) as page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        created_at,
        order_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
