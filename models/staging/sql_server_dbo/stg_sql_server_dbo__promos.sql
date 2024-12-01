{{
  config(
    materialized='incremental',
    unique_key='promo_id'
  )
}}

with 

-- 1. Fuente de datos
source as (
    select distinct *
    from {{ source("sql_server_dbo", "promos") }}
),

-- 2. Datos renombrados
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(["promo_id"]) }} as promo_id,
        promo_id as name,
        discount as EUR_discount,
        status,
        _DLT_LOAD_ID as llegada_id
    from source
),

-- 3. Promos predeterminadas
no_promos as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(["null"]) }} as promo_id,
        'no promo' as name,
        null as EUR_discount,
        null as status,
        '0' as llegada_id
),

-- 4. Deduplicación y manejo de conflictos
deduplicated as (
    select *, 
           row_number() over (partition by promo_id order by llegada_id desc) as row_num
    from (
        select * from renamed
        union all
        select * from no_promos
    )
)

-- 5. Selección final
select *
from deduplicated
where row_num = 1

{% if is_incremental() %}
and llegada_id > (select max(llegada_id) from {{ this }})
{% endif %}
