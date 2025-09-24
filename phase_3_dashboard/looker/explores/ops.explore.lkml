explore: operations {
  label: "SLA & Operations Analysis"
  from: cases
  join: deliveries { type: left_outer sql_on: ${cases.case_id} = ${deliveries.case_id} ;; relationship: one_to_one }
}
