module ManagedDns
  class Record < Chef::Resource
    actions :create, :update, :get, :delete
    default_action :update

    property :dns_registrar_name, Symbol, required: true, default: :dnsmadeeasy
    property :dns_registrar_api_key, String, required: true
    property :dns_registrar_api_secret, String, required: true

    property :dns_registrar, Object

    # name of the DNS record, eg hostname
    property :name, String, required: true, name_property: true

    # Domain to add/remove hosts to
    property :domain, String, required: true

    # this is the record type 'A', 'TXT', etc
    property :type, String, required: true

    # This is eg, ipaddress, or url, etc.
    property :value, String, required: true

    # TTL
    property :ttl, Integer, required: true, default: 60

    action :create do
      nr = new_resource
      info("creating DNS entry type #{nr.type}, name: #{nr.name}, value: #{nr.value}, ttl: #{nr.ttl}")
      api.create_record(nr.domain, nr.name, nr.type, nr.value, { 'ttl' => nr.ttl })
      nr.updated_by_last_action(true)
    end

    declare_action_class.class_eval do
      include Helpers::Registrar

    end

  end
end
