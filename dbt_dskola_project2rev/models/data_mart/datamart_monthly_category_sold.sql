-- Query untuk menghasilkan Datamart_monthly_category_sold
SELECT
    DATE_TRUNC('month', fo."orderDate") AS orderMonth,
    c."categoryName",
    SUM(od."quantity") AS totalQuantitySold
FROM
    "{{ ref('raw_orders') }}" fo
JOIN
    "{{ ref('raw_order_details') }}" od ON fo."orderID" = od."orderID"
JOIN
    "{{ ref('raw_products') }}" p ON od."productID" = p."productID"
JOIN
    "{{ ref('raw_categories') }}" c ON p."categoryID" = c."categoryID"
GROUP BY
    DATE_TRUNC('month', fo."orderDate"),
    c."categoryName"
ORDER BY
    orderMonth,
    totalQuantitySold DESC;
