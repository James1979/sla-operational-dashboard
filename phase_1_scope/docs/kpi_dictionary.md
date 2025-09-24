# KPI Dictionary (I wrote these to align stakeholders on exact math)

## Primary SLA
- **SLA %** = On-time deliveries / Total deliveries (target **≥ 95%**)
- **On-time** if `delivery_date <= expected_delivery_date`

## Timeliness & Workload
- **Avg Lead Time (days)** = AVG(delivery_date - scheduled_date)
- **Backlog** = Open cases past expected_delivery_date without delivery

## Root Causes
- **Late Assignment Rate** = Assigned >24h after case creation
- **Client Reschedule Rate** = Cases with `Reschedule` event
- **Reporter No-Show Rate** = Cases with `No-Show` event
- **Transcript Delay Rate** = Late due to `Transcript Delay`

## Satisfaction
- **CSAT** = AVG(survey rating), target **≥ 4.2**
- **First Contact Resolution (FCR)** *(my addition)* = Cases resolved without follow-up / Total cases, target **≥ 85%**
