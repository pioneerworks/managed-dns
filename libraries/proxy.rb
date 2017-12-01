require 'dnsmadeeasy-rest-api'

module ManagedDNS
  module Proxy
    class UnsupportedDNSProvider < StandardError
    end

    def dnsmadeeasy(*args)
      ::DnsMadeEasy::Rest::Api::Client.new(*args)
    end

    def cloudflare(*args)
      raise ManagedDNS::UnsupportedDNSProvider, args.join('')
    end
  end
end
