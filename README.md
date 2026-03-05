# stemau_odoo_stock

Stemau Inventory (Odoo 19 Community)

## Structure

```
.
├── addons/          # Custom Odoo modules
├── docker/          # Docker configuration
│   ├── docker-compose.yml
│   └── odoo.conf
└── scripts/         # Utility scripts
    ├── sanity_checks.sh
    └── test_local.sh
```

## Quick Start

```bash
cd docker && docker compose up -d
```

## Tests

```bash
./scripts/test_local.sh
```
