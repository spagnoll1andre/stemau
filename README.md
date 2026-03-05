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

## Odoo.sh Policy

| Item | Value |
|------|-------|
| Branch principale | `main` |
| Tipo branch (Odoo.sh) | **Development** |
| Esito build | **Build Verde = Successo** |

- Il branch `main` è configurato come **Development** in Odoo.sh: ad ogni push vengono eseguiti automaticamente i test dei moduli dichiarati in `odoo.sh.yml`.
- I test devono passare integralmente prima che il build sia considerato verde. Un build rosso blocca il deploy.
- I moduli installati al momento del build sono: `stock`, `stemau_stock` (vedi `odoo.sh.yml`).

## Quick Start

```bash
cd docker && docker compose up -d
```

## Tests

```bash
./scripts/test_local.sh
```
