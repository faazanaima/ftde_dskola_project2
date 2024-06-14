-- Query untuk tabel staging raw_categories
SELECT
    "categoryID",
    "categoryName",
    "description",
    "picture"
FROM
    "{{ source('raw', 'categories') }}";
