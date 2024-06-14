-- Query untuk tabel staging raw_territories
SELECT
    "territoryID",
    "territoryDescription",
    "regionID"
FROM
    "{{ source('raw', 'territories') }}";
