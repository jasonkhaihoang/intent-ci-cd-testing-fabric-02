# Getting Started with fabric-domain-01

This document provides an overview of the data engineering domain and how to navigate the repository.

## Repository Structure

- **`ingestion/`** — dlt pipeline definitions for loading source data into the bronze layer
- **`transformation/`** — dbt models for transforming data across bronze, silver, and gold layers
- **`orchestration/`** — pipeline orchestration definitions
- **`intent/`** — intent capture and design records for data product changes
- **`docs/`** — domain documentation
- **`project/`** — project-level configuration

## Data Platform

This domain runs on **Microsoft Fabric**. All development and testing occurs against the ephemeral Fabric lakehouse workspace provisioned for each intent.

## Workflow

1. Changes are made on intent-specific branches (`intent/new-intent-*`)
2. Each change follows the capture → design → plan → execute → verify → ship workflow
3. Pull requests are raised from intent branches and merged to `main` after verification

## Key Tools

- **dlt** — ingestion pipeline framework
- **dbt** — transformation modelling framework
- **Fabric** — data platform (lakehouse, notebooks, pipelines)