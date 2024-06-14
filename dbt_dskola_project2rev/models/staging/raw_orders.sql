-- Query untuk tabel staging raw_orders
SELECT
    "orderID",
    "customerID",
    "employeeID",
    "orderDate",
    "requiredDate",
    "shippedDate",
    "shipVia",
    "freight",
    "shipName",
    "shipAddress",
    "shipCity",
    "shipRegion",
    "shipPostalCode",
    "shipCountry"
FROM
    "{{ source('raw', 'orders') }}";
