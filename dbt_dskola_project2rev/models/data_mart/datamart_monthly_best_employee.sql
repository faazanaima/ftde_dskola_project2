-- Query untuk menghasilkan Datamart_monthly_best_employee
WITH monthly_employee_revenue AS (
    SELECT
        e."employeeID",
        CONCAT(e."firstName", ' ', e."lastName") AS employeeName,
        DATE_TRUNC('month', fo."orderDate") AS orderMonth,
        SUM(od."grossRevenue") AS totalGrossRevenue
    FROM
        "{{ ref('raw_orders') }}" fo
    JOIN
        "{{ ref('raw_employee') }}" e ON fo."employeeID" = e."employeeID"
    JOIN
        "{{ ref('raw_order_details') }}" od ON fo."orderID" = od."orderID"
    GROUP BY
        e."employeeID",
        employeeName,
        DATE_TRUNC('month', fo."orderDate")
)

SELECT
    orderMonth,
    employeeName,
    totalGrossRevenue
FROM (
    SELECT
        *,
        RANK() OVER (PARTITION BY orderMonth ORDER BY totalGrossRevenue DESC) AS ranking
    FROM
        monthly_employee_revenue
) ranked
WHERE
    ranking = 1
ORDER BY
    orderMonth;
