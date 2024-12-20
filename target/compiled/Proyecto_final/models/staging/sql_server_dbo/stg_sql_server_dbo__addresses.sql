

with 

-- 1. Fuente de datos
source as (
    select distinct *
    from ALUMNO11_PRO_BRONZE_DB.sql_server_dbo.addresses
),

-- 2. Datos renombrados
renamed as (
    select
        md5(cast(coalesce(cast(address as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(zipcode as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(country as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(state as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as address_id,
        zipcode,
        country,
        address,
        split_part(address, ' ', 1) as address_number,
        regexp_substr(address, ' (.*)', 1, 1, 'e', 1) as street,
        state,
        _DLT_LOAD_ID as llegada_id
    from source
),

-- 3. Dirección predeterminada
no_addresses as (
    select distinct
        md5(cast(coalesce(cast('no address' as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast('no address' as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast('no address' as TEXT), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast('no address' as TEXT), '_dbt_utils_surrogate_key_null_') as TEXT)) as address_id,
        null as zipcode,
        'no address' as country,
        'no address' as address,
        null as address_number,
        null as street,
        null as state,
        '0' as llegada_id
),

-- 4. Deduplicación y manejo de conflictos
deduplicated as (
    select *, 
           row_number() over (partition by address_id order by llegada_id desc) as row_num
    from (
        select * from renamed
        union all
        select * from no_addresses
    )
)

-- 5. Selección final
select *
from deduplicated
where row_num = 1


and llegada_id > (select max(llegada_id) from ALUMNO11_PRO_SILVER_DB.ALUMNO11_staging.stg_sql_server_dbo__addresses)
