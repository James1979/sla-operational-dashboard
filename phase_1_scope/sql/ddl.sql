-- SLA & Operational Performance Dashboard - DDL
-- Author: James Lim — Analytics Engineer

CREATE TABLE cases (
  case_id VARCHAR(20) PRIMARY KEY,
  client_id VARCHAR(10) NOT NULL,
  case_type VARCHAR(50) NOT NULL,
  region VARCHAR(20) NOT NULL,
  priority_level VARCHAR(10) DEFAULT 'Standard',
  created_date TIMESTAMP NOT NULL,
  scheduled_date TIMESTAMP,
  expected_delivery_date TIMESTAMP,
  complexity_score INTEGER DEFAULT 1
);

CREATE TABLE reporters (
  reporter_id VARCHAR(10) PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  region VARCHAR(20) NOT NULL,
  skill_level VARCHAR(20) DEFAULT 'Standard',
  hire_date DATE NOT NULL,
  status VARCHAR(20) DEFAULT 'Active',
  max_concurrent_cases INTEGER DEFAULT 3
);

CREATE TABLE assignments (
  assignment_id VARCHAR(20) PRIMARY KEY,
  case_id VARCHAR(20) NOT NULL,
  reporter_id VARCHAR(10) NOT NULL,
  assigned_date TIMESTAMP NOT NULL,
  assignment_method VARCHAR(30) DEFAULT 'Auto'
);

CREATE TABLE status_events (
  event_id VARCHAR(30) PRIMARY KEY,
  case_id VARCHAR(20) NOT NULL,
  event_type VARCHAR(30) NOT NULL,
  event_timestamp TIMESTAMP NOT NULL,
  created_by VARCHAR(50),
  notes TEXT
);

CREATE TABLE deliveries (
  delivery_id VARCHAR(20) PRIMARY KEY,
  case_id VARCHAR(20) NOT NULL,
  delivery_date TIMESTAMP NOT NULL,
  delivery_method VARCHAR(20) DEFAULT 'Email',
  pages_count INTEGER,
  quality_score DECIMAL(3,2),
  is_on_time BOOLEAN
);

CREATE TABLE clients (
  client_id VARCHAR(10) PRIMARY KEY,
  client_name VARCHAR(100) NOT NULL,
  tier VARCHAR(20) DEFAULT 'Standard',
  region VARCHAR(20) NOT NULL,
  contract_start_date DATE
);

CREATE TABLE csat_surveys (
  survey_id VARCHAR(20) PRIMARY KEY,
  case_id VARCHAR(20) NOT NULL,
  rating INTEGER CHECK (rating BETWEEN 1 AND 5),
  feedback TEXT,
  survey_date TIMESTAMP NOT NULL,
  response_method VARCHAR(20) DEFAULT 'Email'
);
