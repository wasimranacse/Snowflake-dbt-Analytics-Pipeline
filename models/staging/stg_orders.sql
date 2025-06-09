-- models/staging/stg_orders.sql
WITH raw_orders_data AS (
SELECT
    ORDER_DATE,
    ORDER_ID,
    CASE
        WHEN STATUS = 'processing' THEN 'Completed'
        ELSE 'Completed'
    END AS ORDER_STATUS,
    CUSTOMER_NAME,
    CUSTOMER_TYPE,
    CASE
        WHEN LEFT(PRODUCT_NAME::string, 4) LIKE '__× ' THEN SUBSTR(PRODUCT_NAME::string, 5)
        WHEN LEFT(PRODUCT_NAME::string, 3) LIKE '_× ' THEN SUBSTR(PRODUCT_NAME::string, 4)
        WHEN LEFT(PRODUCT_NAME::string, 5) LIKE '___× ' THEN SUBSTR(PRODUCT_NAME::string, 6)
        ELSE PRODUCT_NAME::string
    END AS CLEANED_PRODUCT_NAME,
    ITEMS_SOLD,
    CASE
        WHEN LOWER(coupon_code) = 'acesave5' THEN 5
        WHEN LOWER(coupon_code) = 'promo10' THEN 10
        WHEN LOWER(coupon_code) = 'ace410' THEN 10
    ELSE 0
    END AS coupon_discount,
    NET_SALES,
    CASE
        WHEN ATTRIBUTION = 'Referral: Bing.com' THEN 'Bing'
        WHEN ATTRIBUTION = 'Organic: Google' THEN 'Google'
        WHEN ATTRIBUTION = 'Direct' THEN 'Direct'
        WHEN ATTRIBUTION = 'Unknown' THEN 'N/A'
        ELSE 'N/A'
    END AS Referral_Medium
    FROM {{ source('public', 'raw_orders') }}
)
SELECT * FROM raw_orders_data



