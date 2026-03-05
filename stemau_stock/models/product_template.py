from odoo import fields, models


class ProductTemplate(models.Model):
    _inherit = 'product.template'

    x_wood_species = fields.Char(string='Wood Species')
    x_thickness_mm = fields.Float(string='Thickness (mm)', digits=(10, 2))
    x_moisture_pct = fields.Float(string='Moisture (%)', digits=(5, 2))
    x_fsc = fields.Boolean(string='FSC Certified')
