from odoo.tests.common import TransactionCase


class TestSmokeInstall(TransactionCase):
    """Verify that the stemau_stock module loads without errors."""

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
