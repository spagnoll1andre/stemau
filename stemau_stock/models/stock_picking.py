from odoo import fields, models


class StockPicking(models.Model):
    _inherit = 'stock.picking'

    x_carrier_ref = fields.Char(string='Carrier Reference')
    x_loading_notes = fields.Text(string='Loading Notes')
