-- Core KPI calculations for SLA dashboard
WITH daily_sla AS (
  SELECT
    DATE(d.delivery_date) AS delivery_date,
    c.region,
    COUNT(*) AS total_deliveries,
    SUM(CASE WHEN d.is_on_time = 1 THEN 1 ELSE 0 END) AS on_time_deliveries,
    ROUND(SUM(CASE WHEN d.is_on_time = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS sla_percentage,
    AVG(DATEDIFF(d.delivery_date, c.expected_delivery_date)) AS avg_delay_days
  FROM deliveries d
  JOIN cases c ON d.case_id = c.case_id
  GROUP BY DATE(d.delivery_date), c.region
),
weekly_metrics AS (
  SELECT
    STRFTIME('%Y-%W', delivery_date) AS year_week,
    region,
    AVG(sla_percentage) AS avg_weekly_sla,
    SUM(total_deliveries) AS weekly_volume,
    MIN(sla_percentage) AS min_daily_sla,
    MAX(sla_percentage) AS max_daily_sla
  FROM daily_sla
  GROUP BY STRFTIME('%Y-%W', delivery_date), region
),
current_backlog AS (
  SELECT
    c.region,
    COUNT(*) AS backlog_cases
  FROM cases c
  LEFT JOIN deliveries d ON c.case_id = d.case_id
  WHERE d.delivery_id IS NULL
    AND c.expected_delivery_date < CURRENT_TIMESTAMP
  GROUP BY c.region
)
SELECT 'daily_sla' AS metric_type, delivery_date AS metric_date, region, sla_percentage AS metric_value, total_deliveries AS volume FROM daily_sla
UNION ALL
SELECT 'weekly_sla', NULL, region, avg_weekly_sla, weekly_volume FROM weekly_metrics
UNION ALL
SELECT 'backlog', CURRENT_DATE, region, backlog_cases, NULL FROM current_backlog;
