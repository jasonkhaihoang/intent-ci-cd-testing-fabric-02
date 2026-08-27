# Design: Seed a fake product catalog and build a staging model

## Architecture

- **Grain:** one row per product (`product_id`).
- **Materialization:** `stg_products` is a view — the staging layer is already
  configured as `view` in `dbt_project.yml`.
- **Approach:** seed the fake `products` dataset with `dbt seed`, then build a
  1:1 staging model that exposes the seed unchanged. The seed is referenced via
  `ref('products')`, not `source()` — consistent with the existing standalone
  `sales_data` -> `stg_sales_data` pattern, since this dataset has no external
  source system.
- **Decision:** model name `stg_products` follows the standalone-seed naming
  convention (`stg_<seed>`); the source-backed `stg_{source}__{entity}` pattern
  does not apply because the seed is not a registered source. No business logic
  in staging — joins and CASE expressions are deferred to intermediate/mart.

## Inventory

### Model Inventory

| Model | Layer | Grain | Source |
| --- | --- | --- | --- |
| `stg_products` | staging | one row per product_id | `ref('products')` |

The raw dataset is the committed seed `transformation/seeds/products.csv`
(materialized as the `products` table).

## Source Mapping / Discovery

`dbt seed` -> `products` (lakehouse `dbo`) -> `ref('products')`
-> `stg_products` (view).

## Change Impact

Fresh build: the only artifacts added are `transformation/seeds/products.csv`
and `transformation/models/staging/stg_products.{sql,yml}`. No existing models
are touched and there are no downstream consumers. The staging model adds no
new schema and changes no existing contract.

## Approvals
