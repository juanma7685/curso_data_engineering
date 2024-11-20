
WITH session_data AS (
    SELECT
        session_id,
        user_id,
        MIN(created_at) AS session_start,
        MAX(created_at) AS session_end,
        TIMESTAMPDIFF(SECOND, MIN(created_at), MAX(created_at)) AS session_duration
    FROM {{ ref('dim_events') }}
    GROUP BY session_id, user_id
),
page_views AS (
    SELECT
        session_id,
        COUNT(*) AS pages_viewed
    FROM {{ ref('dim_events') }}
    WHERE event_type = 'page_view'
    GROUP BY session_id
),
add_to_cart_events AS (
    SELECT
        session_id,
        COUNT(*) AS add_to_cart_events
    FROM {{ ref('dim_events') }}
    WHERE event_type = 'add_to_cart'
    GROUP BY session_id
),
checkout_events AS (
    SELECT
        session_id,
        COUNT(*) AS checkout_events
    FROM {{ ref('dim_events') }}
    WHERE event_type = 'checkout'
    GROUP BY session_id
),
package_shipped_events AS (
    SELECT
        session_id,
        COUNT(*) AS package_shipped_events
    FROM {{ ref('dim_events') }}
    WHERE event_type = 'package_shipped'
    GROUP BY session_id
)

SELECT
    sd.session_id,
    sd.user_id,
    sd.first_name,
    sd.last_name,
    sd.email,
    sd.phone_number,
    sd.session_start,
    sd.session_end,
    sd.session_duration,
    pv.pages_viewed,
    atc.add_to_cart_events,
    co.checkout_events,
    ps.package_shipped_events
FROM session_data sd
LEFT JOIN page_views pv ON sd.session_id = pv.session_id
LEFT JOIN add_to_cart_events atc ON sd.session_id = atc.session_id
LEFT JOIN checkout_events co ON sd.session_id = co.session_id
LEFT JOIN package_shipped_events ps ON sd.session_id = ps.session_id