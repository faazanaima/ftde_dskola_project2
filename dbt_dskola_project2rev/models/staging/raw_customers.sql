-- Query untuk tabel staging raw_customers
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
FROM
    "{{ source('raw', 'customers') }}";
