
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
