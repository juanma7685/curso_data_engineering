WITH source AS (
    SELECT * 
    FROM {{ source('SQL_SERVER_DBO', 'PROMOS') }}
),

renamed AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['promo_id', 'discount', 'status']) }} as promo_id,
        promo_id AS name,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced
    FROM source
)

SELECT * FROM renamed
