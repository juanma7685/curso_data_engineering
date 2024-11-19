with 

source as (
    select * from {{ source('sql_server_dbo', 'orders') }}
),

renamed as (
    select
        order_id,
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(shipping_service, ''), 'Waiting')"]) }} as shipping_service_id,
        address_id,
        {{ dbt_utils.generate_surrogate_key(['created_at']) }} as id_created_at,
        {{ dbt_utils.generate_surrogate_key(["COALESCE(NULLIF(promo_id, ''), 'No Promo')"]) }} as promo_id,
        {{ dbt_utils.generate_surrogate_key(['estimated_delivery_at']) }} as id_estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        {{ dbt_utils.generate_surrogate_key(['delivered_at']) }} as id_delivered_at_UTC,
        tracking_id,
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
        _fivetran_deleted,
        _fivetran_synced
    from source 
)

select * from renamed
