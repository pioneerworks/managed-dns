
managed_dns_record (node['managed-dns']['hostname'] || node['name']) do
  dns_registrar_name node['managed-dns']['provider']['name'].to_sym
  dns_registrar_api_key node['managed-dns']['provider']['api-key']
  dns_registrar_api_secret node['managed-dns']['provider']['api-secret']
  domain node['managed-dns']['domain']
  name (node['managed-dns']['hostname'] || node['name'])
  type 'A'
  value node['privateaddress']
  ttl 60
  action :update
  not_if { ManagedDNS::Helper::Record.new(node).already_defined? }
end
