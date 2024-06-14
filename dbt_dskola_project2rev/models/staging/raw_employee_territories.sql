-- Query untuk tabel staging raw_employee_territories
SELECT
    "employeeID",
    "territoryID"
FROM
    "{{ source('raw', 'employee_territories') }}";
