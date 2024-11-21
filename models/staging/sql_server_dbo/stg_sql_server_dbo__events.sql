with 

source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        page_url,
        {{ dbt_utils.generate_surrogate_key(['event_type']) }} as event_type_id,
        user_id,
        product_id,
        session_id,
        CAST(created_at AS DATE) as created_at,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
