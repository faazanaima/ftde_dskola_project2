-- CTE untuk tabel dimensi
WITH dim_customers AS (
    SELECT
        "customerID",
        "companyName",
        "contactName",
        "contactTitle",
        "address",
        "city",
        "region",
        "postalCode",
        "country",
        "phone",
        "fax"
    FROM {{ ref('raw_customers') }}
),
dim_employee AS (
    SELECT
        "employeeID",
        "lastName",
        "firstName",
        "title",
        "titleOfCourtesy",
        "birthDate",
        "hireDate",
        "address",
        "city",
        "region",
        "postalCode",
        "country",
        "homePhone",
        "extension",
        "photo",
        "notes",
        "reportsTo",
        "photoPath"
    FROM {{ ref('raw_employee') }}
),
dim_products AS (
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
    FROM {{ ref('raw_products') }}
),
dim_suppliers AS (
    SELECT
        "supplierID",
        "companyName",
        "contactName",
        "contactTitle",
        "address",
        "city",
        "region",
        "postalCode",
        "country",
        "phone",
        "fax",
        "homePage"
    FROM {{ ref('raw_suppliers') }}
),
dim_categories AS (
    SELECT
        "categoryID",
        "categoryName",
        "description",
        "picture"
    FROM {{ ref('raw_categories') }}
),
dim_shippers AS (
    SELECT
        "shipperID",
        "companyName",
        "phone"
    FROM {{ ref('raw_shippers') }}
),
dim_regions AS (
    SELECT
        "regionID",
        "regionDescription"
    FROM {{ ref('raw_regions') }}
),
dim_territories AS (
    SELECT
        "territoryID",
        "territoryDescription",
        "regionID"
    FROM {{ ref('raw_territories') }}
),
dim_employees_territories AS (
    SELECT
        "employeeID",
        "territoryID"
    FROM {{ ref('raw_employee_territories') }}
),

-- CTE untuk tabel fakta
fact_orders AS (
    SELECT
        o."orderID",
        o."customerID",
        o."employeeID",
        o."orderDate",
        o."requiredDate",
        o."shippedDate",
        o."shipVia" AS "shipperID",
        o."freight",
        o."shipName",
        o."shipAddress" AS "shipAddressID",
        o."shipCity",
        o."shipRegion",
        o."shipPostalCode",
        o."shipCountry",
        -- Kolom tambahan untuk waktu order
        DATE_TRUNC('month', o."orderDate") AS "orderMonth"
    FROM {{ ref('raw_orders') }} o
),

fact_order_details AS (
    SELECT
        od."orderID",
        od."productID",
        od."unitPrice",
        od."quantity",
        od."discount",
        -- Kolom tambahan untuk gross revenue
        (od."unitPrice" - (od."unitPrice" * od."discount")) * od."quantity" AS "grossRevenue",
        od."quantity" AS "quantitySold"
    FROM {{ ref('raw_order_details') }} od
)

-- Query untuk menghasilkan data akhir dari tabel fakta dan dimensi
SELECT
    fo."orderID",
    fo."orderDate",
    c."companyName" AS "customerName",
    CONCAT(e."firstName", ' ', e."lastName") AS "employeeName",
    p."productName",
    p."unitPrice",
    p."quantityPerUnit",
    s."companyName" AS "supplierName"
FROM
    fact_orders fo
JOIN
    dim_customers c ON fo."customerID" = c."customerID"
JOIN
    dim_employee e ON fo."employeeID" = e."employeeID"
JOIN
    fact_order_details od ON fo."orderID" = od."orderID"
JOIN
    dim_products p ON od."productID" = p."productID"
JOIN
    dim_suppliers s ON p."supplierID" = s."supplierID";
