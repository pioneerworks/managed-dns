include_recipe 'managed-dns::default'

managed_dns_record node['hostname'] do
  dns_provider_name node['managed-dns']['dns-provider']
  dns_provider_api_key node['managed-dns']['api-key']
  dns_provider_api_secret node['managed-dns']['api-secret']
  domain node['managed-dns']['domain'] # 'homebase.systems'
  name node['managed-dns']['hostname']
  type 'A'
  value node['privateaddress']
  ttl 60
  action :update
  not_if { ManagedDNS::Helper.new(node).already_defined? }
end
