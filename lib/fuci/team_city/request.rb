require 'net/http'

module Fuci
  module TeamCity
    class Request < Struct.new :resource
      SCHEME = 'http'

      def call
        request_obj.basic_auth username, password
        start.body
      end

      private

      def request_obj
        @request_obj ||= Net::HTTP::Get.new uri
      end

      def username
        Fuci::TeamCity.username
      end

      def password
        Fuci::TeamCity.password
      end

      def uri
        @uri ||= URI base_url + resource
      end

      def base_url
        "#{scheme}://#{host}"
      end

      def scheme
        SCHEME
      end

      def host
        Fuci::TeamCity.host
      end

      def start
        Net::HTTP.start uri.hostname, uri.port  do |http|
          http.request request_obj
        end
      end
    end
  end
end
