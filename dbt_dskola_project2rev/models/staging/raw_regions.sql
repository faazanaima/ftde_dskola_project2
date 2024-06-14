-- Query untuk tabel staging raw_regions
SELECT
    "regionID",
    "regionDescription"
FROM
    "{{ source('raw', 'regions') }}";
