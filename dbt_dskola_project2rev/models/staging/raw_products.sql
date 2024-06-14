-- Query untuk tabel staging raw_products
SELECT
    "productID",
    "productName",
    "supplierID",
    "categoryID",
    "quantityPerUnit",
    "unitPrice",
    "unitsInStock",
    "unitsOnOrder",
    "reorderLevel",
    "discontinued"
FROM
    "{{ source('raw', 'products') }}";
