-- Synthetic seed data (small sample; expand as needed)
INSERT INTO clients (client_id, client_name, tier, region, contract_start_date) VALUES
('CL001','Morrison & Associates','Enterprise','Northeast','2023-01-15'),
('CL002','Bradley Law Group','Standard','Southeast','2023-03-20'),
('CL003','Whitman Legal Partners','Premium','West','2022-11-10');

INSERT INTO reporters (reporter_id, first_name, last_name, region, skill_level, hire_date, status, max_concurrent_cases) VALUES
('RPT001','Sarah','Williams','Northeast','Senior','2022-01-15','Active',4),
('RPT002','Michael','Johnson','Southeast','Standard','2023-06-01','Active',3),
('RPT003','Emily','Davis','West','Expert','2021-09-10','Active',5);

-- Minimal cases sample (extend to 60 days with a generator later)
INSERT INTO cases (case_id, client_id, case_type, region, priority_level, created_date, scheduled_date, expected_delivery_date, complexity_score) VALUES
('CSE000001','CL001','Standard Deposition','Northeast','Standard','2024-01-03 10:00','2024-01-05 09:00','2024-01-10 18:00',2),
('CSE000002','CL002','Expert Witness','Southeast','High','2024-01-04 12:00','2024-01-07 11:00','2024-01-12 18:00',3),
('CSE000003','CL003','Complex Multi-Party','West','Urgent','2024-01-05 08:00','2024-01-06 14:00','2024-01-08 18:00',5);

INSERT INTO assignments (assignment_id, case_id, reporter_id, assigned_date, assignment_method) VALUES
('ASN000001','CSE000001','RPT001','2024-01-03 14:00','Auto'),
('ASN000002','CSE000002','RPT002','2024-01-04 16:00','Manual'),
('ASN000003','CSE000003','RPT003','2024-01-05 10:00','Auto');

INSERT INTO status_events (event_id, case_id, event_type, event_timestamp, created_by, notes) VALUES
('EVT000001','CSE000002','Reschedule','2024-01-06 09:00','ops_user','Client requested new date'),
('EVT000002','CSE000003','No-Show','2024-01-06 13:00','ops_user','Reporter stuck in traffic'),
('EVT000003','CSE000003','Transcript Delay','2024-01-10 17:00','transcripts','High page count');

INSERT INTO deliveries (delivery_id, case_id, delivery_date, delivery_method, pages_count, quality_score, is_on_time) VALUES
('DLV000001','CSE000001','2024-01-10 17:00','Email',120,4.6,1),
('DLV000002','CSE000002','2024-01-13 10:00','Email',90,4.2,0),
('DLV000003','CSE000003','2024-01-09 18:30','Portal',240,4.0,1);

INSERT INTO csat_surveys (survey_id, case_id, rating, feedback, survey_date, response_method) VALUES
('CSV000001','CSE000001',5,'Great turnaround!','2024-01-11 09:00','Email'),
('CSV000002','CSE000003',4,'Good quality','2024-01-10 15:00','Portal');
