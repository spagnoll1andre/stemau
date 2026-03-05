from odoo.tests import tagged
from odoo.tests.common import TransactionCase


@tagged('post_install', '-at_install')
class TestSmokeInstall(TransactionCase):
    """Verify that stemau_stock installs correctly and custom fields work."""

    def test_module_is_installed(self):
        module = self.env['ir.module.module'].search(
            [('name', '=', 'stemau_stock')], limit=1
        )
        self.assertTrue(module, "Module 'stemau_stock' not found in ir.module.module")
        self.assertEqual(
            module.state,
            'installed',
            f"Expected state 'installed', got '{module.state}'",
        )

    def test_product_template_stemau_fields(self):
        """Custom wood fields must be writable and readable on product.template."""
        product = self.env['product.template'].create({
            'name': 'Test Plank',
            'type': 'consu',
            'x_wood_species': 'Oak',
            'x_thickness_mm': 18.5,
            'x_moisture_pct': 12.0,
            'x_fsc': True,
        })
        self.assertEqual(product.x_wood_species, 'Oak')
        self.assertAlmostEqual(product.x_thickness_mm, 18.5)
        self.assertAlmostEqual(product.x_moisture_pct, 12.0)
        self.assertTrue(product.x_fsc)

    def test_stock_picking_stemau_fields(self):
        """Custom shipment fields must be writable and readable on stock.picking."""
        picking_type = self.env['stock.picking.type'].search(
            [('code', '=', 'outgoing')], limit=1
        )
        self.assertTrue(picking_type, "No outgoing picking type found")
        self.assertTrue(
            picking_type.default_location_src_id,
            "Outgoing picking type has no default source location",
        )
        self.assertTrue(
            picking_type.default_location_dest_id,
            "Outgoing picking type has no default destination location",
        )

        picking = self.env['stock.picking'].create({
            'picking_type_id': picking_type.id,
            'location_id': picking_type.default_location_src_id.id,
            'location_dest_id': picking_type.default_location_dest_id.id,
            'x_carrier_ref': 'TRACK-001',
            'x_loading_notes': 'Handle with care.',
        })
        self.assertEqual(picking.x_carrier_ref, 'TRACK-001')
        self.assertEqual(picking.x_loading_notes, 'Handle with care.')
