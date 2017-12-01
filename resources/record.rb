actions :create, :update, :get, :delete

# this is the name mapped to the value, eg hostname
property :name, String, required: true, name_property: true

property :dns_provider_name, String
property :dns_provider_api_key, String
property :dns_provider_api_secret, String
# Domain to add/remove hosts to
property :domain, String, required: true

# this is the record type 'A', 'TXT', etc
property :type, String, required: true
# This is eg, ipaddress, or url, etc.
property :value, String, required: true
property :ttl, Integer, required: true

action :create do
  unless exists?
    Chef::Log.info('Creating a record')
    provider.create_record(new_resource.domain, new_resource.name, new_resource.type, new_resource.value, { 'ttl' => new_resource.ttl })
    new_resource.updated_by_last_action(true)
  end
end

action_class do
  def helper
    @helper ||= ManagedDNS::Helper.new(node)
  end

  def provider
    @provider ||= helper.provider
  end
end
