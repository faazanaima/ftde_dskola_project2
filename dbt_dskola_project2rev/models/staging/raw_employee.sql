-- Query untuk tabel staging raw_employee
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
FROM
    "{{ source('raw', 'employees') }}";
