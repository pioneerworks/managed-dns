
module ManagedDns
  module Helpers
    class Record
      attr_accessor :node

      def initialize(node)
        self.node = node
      end

      def info(*args)
        Chef::Log.info(*args)
      end

      def exists?
        current_resource
      end

      def changed?
        return false unless current_resource
        %i[domain value name tty ttl].any? do |field|
          new_resource.send(field) != current_resource.send(field)
        end
      end

      def existing_record
        @existing_record ||= domain_records.detect do |r|
          r['name'] == new_resource.a_record && r['type'] == new_resource.record_type
        end
      end

      def domain_records
        @records ||= api.records_for(new_resource.domain)['data']
      end

      def api
        api_credentials = new_resource.run_context.node['managed_dns']['dnsmadeeasy']['credentials']
        ::DnsMadeEasy.new(api_credentials['api_key'], api_credentials['secret_key'])
      end

    def already_defined?
      check = shell_out("dig #{fqdn} | grep #{node['privateaddress']}")
      check.status == 0
    end

    def current_fqdn
      (current_hostname + domain).uniq.join('.')
    end

    def desired_fqdn
      (current_hostname + domain).uniq.join('.')
    end

    def desired_hostname
      node['managed-dns']['hostname']
    end

    def current_hostname
      node['hostname']
    end

    def domain
      node['managed-dns']['domain']
    end

    private

    def provider_name
      @provider_name ||= node['managed-dns']['provider']['name'].to_sym
    end
  end
end
end
