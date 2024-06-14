-- Query untuk menghasilkan Datamart_monthly_supplier_gross_revenue
WITH fact_orders AS (
    SELECT
        o."orderID",
        o."customerID",
        o."employeeID",
        o."orderDate",
        o."requiredDate",
        o."shippedDate",
        o."shipVia" AS shipperID,
        o."freight",
        o."shipName",
        o."shipAddress" AS shipAddressID,
        o."shipCity",
        o."shipRegion",
        o."shipPostalCode",
        o."shipCountry",
        DATE_TRUNC('month', o."orderDate") AS orderMonth
    FROM "{{ ref('raw_orders') }}" o
),

fact_order_details AS (
    SELECT
        od."orderID",
        od."productID",
        od."unitPrice",
        od."quantity",
        od."discount",
        (od."unitPrice" - (od."unitPrice" * od."discount")) * od."quantity" AS grossRevenue,
        od."quantity" AS quantitySold
    FROM "{{ ref('raw_order_details') }}" od
)

SELECT
    DATE_TRUNC('month', fo."orderDate") AS orderMonth,
    s."companyName" AS supplierName,
    SUM((od."unitPrice" - (od."unitPrice" * od."discount")) * od."quantity") AS grossRevenue
FROM
    fact_orders fo
JOIN
    fact_order_details od ON fo."orderID" = od."orderID"
JOIN
    "{{ ref('raw_products') }}" p ON od."productID" = p."productID"
JOIN
    "{{ ref('raw_suppliers') }}" s ON p."supplierID" = s."supplierID"
GROUP BY
    DATE_TRUNC('month', fo."orderDate"),
    s."companyName";
