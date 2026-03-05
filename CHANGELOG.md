# Changelog

All notable changes to `stemau_odoo_stock` will be documented in this file.
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [19.0.1.0.0] - 2026-03-06

### Added
- Initial module scaffold: `addons/stemau_stock` (depends: `stock`, license: LGPL-3)
- Custom fields on `product.template`: `x_wood_species`, `x_thickness_mm`, `x_moisture_pct`, `x_fsc`
- Custom fields on `stock.picking`: `x_carrier_ref`, `x_loading_notes`
- Inherited form views for both models with dedicated "Stemau" tab
- Default data: product category **Legname**, stock location **Area Carico Stemau**
- Smoke/unit tests in `tests/test_smoke_install.py` (TransactionCase)
- Docker stack: Odoo 19.0 + Postgres 15 (`docker/docker-compose.yml`, `docker/odoo.conf`)
- CI helper scripts: `scripts/sanity_checks.sh`, `scripts/test_local.sh`
- Odoo.sh deployment config: `odoo.sh.yml`
