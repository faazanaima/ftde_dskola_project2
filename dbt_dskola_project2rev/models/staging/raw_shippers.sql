-- Query untuk tabel staging raw_shippers
SELECT
    "shipperID",
    "shipperName"
FROM
    "{{ source('raw', 'shippers') }}";
