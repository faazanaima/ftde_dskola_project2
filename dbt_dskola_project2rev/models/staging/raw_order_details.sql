-- Query untuk tabel staging raw_order_details
SELECT
    "orderID",
    "productID",
    "unitPrice",
    "quantity",
    "discount"
FROM
    "{{ source('raw', 'order_details') }}";
