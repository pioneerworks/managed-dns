require 'dnsmadeeasy/rest/api/client'
require_relative '../libraries/helpers_record'

module ManagedDns
  module Helpers
    module Registrar

      def record(node)
        Record.new(node)
      end

      def dnsmadeeasy(api_key, api_secret, *_args)
        @client ||= ::DnsMadeEasy::Rest::Api::Client.new(api_key, api_secret)
      end

      def registrar(resource, *_args)
        if resource.dns_registrar_name && respond_to?(resource.dns_registrar_name)
          send(resource.dns_registrar_name,
               resource.dns_registrar_api_key,
               resource.dns_registrar_api_secret)
        end
      end


    end
  end
end
