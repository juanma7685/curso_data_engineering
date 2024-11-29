with

source as (
    select * 
    from {{ source("sql_server_dbo", "promos") }}
),

renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(["promo_id"]) }} as promo_id,
        promo_id as name,
        discount as EUR_discount,
        status,
        _DLT_LOAD_ID as llegada_id
    from source
),

no_promos as (
    select
        {{ dbt_utils.generate_surrogate_key(["null"]) }} as promo_id,
        'no promo' as name,
        null as EUR_discount,
        null as status,
        null as llegada_id
)

select * from renamed

union all

select * from no_promos
