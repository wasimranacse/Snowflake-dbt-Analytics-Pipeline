-- models/marts/dims/dim_coupon.sql
SELECT DISTINCT
    COUPON_DISCOUNT,
    CASE
        WHEN COUPON_DISCOUNT = 5 THEN 'acesave5'
        WHEN COUPON_DISCOUNT = 10 THEN 'promo10 / ace410'
        ELSE 'No Coupon'
    END AS COUPON_NAME
FROM {{ ref('stg_orders') }}
