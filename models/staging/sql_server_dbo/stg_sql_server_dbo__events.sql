with 

source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        {{ dbt_utils.generate_surrogate_key(['created_at']) }} as id_created_at,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
