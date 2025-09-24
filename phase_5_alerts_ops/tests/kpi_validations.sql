-- KPI Validation Tests
-- 1) SLA denominator check
SELECT COUNT(*) AS failed
FROM deliveries d
LEFT JOIN cases c ON d.case_id = c.case_id
WHERE d.delivery_date IS NOT NULL
  AND (c.expected_delivery_date IS NULL OR d.is_on_time IS NULL);

-- 2) Referential integrity for assignments
SELECT COUNT(*) AS failed
FROM assignments a
LEFT JOIN cases c ON a.case_id = c.case_id
LEFT JOIN reporters r ON a.reporter_id = r.reporter_id
WHERE c.case_id IS NULL OR r.reporter_id IS NULL;
