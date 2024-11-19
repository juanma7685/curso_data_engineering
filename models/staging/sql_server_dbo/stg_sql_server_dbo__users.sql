with 

source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        user_id,
        {{ dbt_utils.generate_surrogate_key(['updated_at']) }} as id_updated_at,
        address_id,
        last_name,
        {{ dbt_utils.generate_surrogate_key(['created_at']) }} as id_created_at,
        phone_number,
        first_name,
        email,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
