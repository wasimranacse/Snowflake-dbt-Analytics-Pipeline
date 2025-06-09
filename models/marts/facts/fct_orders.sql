-- models/marts/facts/fct_orders.sql

SELECT
    o.ORDER_ID,
    o.ORDER_DATE,
    d.DATE_KEY,
    o.ORDER_STATUS,
    c.CUSTOMER_ID,
    -- p.PRODUCT_ID,
    o.ITEMS_SOLD,
    o.NET_SALES,
    o.COUPON_DISCOUNT,
    o.REFERRAL_MEDIUM
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('dim_customers') }} c ON o.CUSTOMER_NAME = c.CUSTOMER_NAME
LEFT JOIN {{ ref('dim_products') }} p ON o.CLEANED_PRODUCT_NAME = p.PRODUCT_NAME
LEFT JOIN {{ ref('dim_date') }} d ON o.ORDER_DATE = d.DATE


