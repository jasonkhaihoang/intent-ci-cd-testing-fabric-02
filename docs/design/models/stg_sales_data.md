---
artifacts: [stg_sales_data]
---
# stg_sales_data

## Grain

One row per sale transaction.

## Decisions

- **D-01** Selects directly from the `sales_data` seed; no joins or aggregation.
