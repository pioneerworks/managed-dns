require 'chef/mixin/shell_out'
require_relative 'proxy'

module ManagedDNS
  class Helper
    include Chef::Mixin::ShellOut
    include ManagedDNS::Proxy

    attr_reader :node

    def initialize(node)
      @node = node
    end

    def provider
      @provider ||= if respond_to?(provider_name)
                      send(provider_name,
                           node['managed-dns']['provider']['api-key'],
                           node['managed-dns']['provider']['api-secret'])
                    end
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
