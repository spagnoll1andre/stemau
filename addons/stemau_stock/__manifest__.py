{
    'name': 'Stemau Stock',
    'version': '19.0.1.0.0',
    'summary': 'Stemau Inventory customizations',
    'author': 'Stemau',
    'license': 'LGPL-3',
    'category': 'Inventory/Inventory',
    'depends': ['stock'],
    'data': [
        'security/ir.model.access.csv',
        'views/product_views.xml',
        'views/stock_picking_views.xml',
        'data/stock_defaults.xml',
    ],
    'installable': True,
    'application': False,
    'auto_install': False,
}
