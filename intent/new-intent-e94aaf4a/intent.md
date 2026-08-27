---
kinds: [transformation]
---

# Intent: Seed a fake product catalog and build a staging model

## Goal
Establish a minimal dbt seed -> staging path for a standalone fake `products`
dataset: land the fake data as a committed dbt seed, and produce a 1:1 staging
model that exposes it for downstream marts. Proves the seed -> staging boundary
works before any business logic is added.

## Source system
None — a self-contained fake `products` dataset committed as a dbt seed
(`transformation/seeds/products.csv`). No external source connection.

## Target
Microsoft Fabric ephemeral lakehouse (`dbo` schema), dbt `fabric_domain` project.

## Objects in scope
- `products` fake dataset (seed).

## Deliverables inventory

| # | Deliverable | Kind | Notes |
| --- | --- | --- | --- |
| 1 | `products` fake dataset committed as a dbt seed | seed | `transformation/seeds/products.csv`. |
| 2 | `stg_products` staging model | model | 1:1 view over the seed; no business logic. |

## Success criteria
- `dbt seed` materializes the `products` table.
- `dbt build` builds `stg_products` as a view.
- `product_id` is not-null and unique in `stg_products`.

## Acceptance units

| ID | Requirement | Source | Resolution | Evidence needed |
| --- | --- | --- | --- | --- |
| A-01 | A committed seed `transformation/seeds/products.csv` exists and `dbt seed` materializes it as the `products` relation. | user request | supplied decision | `dbt seed --select products` exit 0 and the `products` relation present. |
| A-02 | A staging model `transformation/models/staging/stg_products.sql` builds `stg_products` as a view from `ref('products')`. | user request + `dbt_project.yml` staging materialization | derived fact | `dbt build --select stg_products` exit 0. |
| A-03 | `stg_products` is 1:1 with the seed — all seed columns, no added filters or business logic. | `AGENTS.md` staging convention | derived fact | model SQL is a plain `SELECT` of `ref('products')`. |
| A-04 | `product_id` is not-null and unique in `stg_products`. | `AGENTS.md` validation standards | derived fact | `dbt test --select stg_products` exit 0. |

## Out of scope
- No intermediate or mart models.
- No business logic (CASE, joins, aggregations).
- No source registration in `sources.yml` — the seed is referenced via `ref()`, not `source()`.
- No ingestion via dlt, no orchestration, no semantic-model artifacts.

## Open questions
- None.

## Approvals
