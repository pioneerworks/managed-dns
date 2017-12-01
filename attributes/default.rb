node.default['managed-dns']['provider']['api-key']    = 'your-api-key-here'
node.default['managed-dns']['provider']['api-secret'] = 'your-secret-key-here'
node.default['managed-dns']['provider']['name']       = 'dnsmadeeasy'

# This should be set to the to level domain you
node.default['managed-dns']['domain']   = nil
node.default['managed-dns']['hostname'] = node.name


