with

    source as (
        select * from {{ source("sql_server_dbo", "promos") }}
    ),

    renamed as (
        select
            {{ dbt_utils.generate_surrogate_key(["promo_id"]) }} as promo_id,
            promo_id as name,
            discount as EUR_discount,
            status,
            _fivetran_deleted,
            _fivetran_synced
        from source
    ),

    no_promo as (
        select
            {{ dbt_utils.generate_surrogate_key(["'No Promo'"]) }} as promo_id,
            'No Promo' as name,
            0 as discount_percentage,
            'inactive' as status,
            false as _fivetran_deleted,
            current_timestamp() as _fivetran_synced
    )

select *
from renamed

union all

select *
from no_promo
