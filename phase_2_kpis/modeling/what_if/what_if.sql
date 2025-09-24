-- What-If: Reporter availability impact
WITH capacity AS (
  SELECT r.region,
         COUNT(*) AS active_reporters,
         SUM(r.max_concurrent_cases) AS total_capacity
  FROM reporters r
  WHERE r.status = 'Active'
  GROUP BY r.region
),
util AS (
  SELECT r.region,
         COUNT(a.assignment_id) AS current_assignments
  FROM reporters r
  LEFT JOIN assignments a ON r.reporter_id = a.reporter_id
  GROUP BY r.region
),
base AS (
  SELECT c.region,
         total_capacity,
         current_assignments,
         ROUND(current_assignments * 100.0 / NULLIF(total_capacity,0), 1) AS current_utilization
  FROM capacity c
  JOIN util u USING (region)
),
scenarios AS (
  SELECT region, current_utilization,
         'Current' AS scenario, 0 AS cap_delta, current_utilization AS proj_util
  FROM base
  UNION ALL
  SELECT region, current_utilization, '-20% Capacity', -20, ROUND(current_utilization/0.8,1) FROM base
  UNION ALL
  SELECT region, current_utilization, '-10% Capacity', -10, ROUND(current_utilization/0.9,1) FROM base
  UNION ALL
  SELECT region, current_utilization, '+10% Capacity', 10, ROUND(current_utilization/1.1,1) FROM base
  UNION ALL
  SELECT region, current_utilization, '+20% Capacity', 20, ROUND(current_utilization/1.2,1) FROM base
)
SELECT
  region,
  scenario,
  proj_util AS projected_utilization_pct,
  /* Simple elasticity: SLA decreases 0.5pp for every 5pp util above 85 */
  CASE WHEN proj_util > 85 THEN 95 - ((proj_util - 85) * 0.1) ELSE 95 END AS projected_sla_pct
FROM scenarios
ORDER BY region, cap_delta;
