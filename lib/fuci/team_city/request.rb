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
        @request_obj ||=
          begin
            Net::HTTP::Get.new uri
          rescue NoMethodError
            # account for Ruby versions that that have request
            # object initializers that take only strings
            Net::HTTP::Get.new full_url
          end
      end

      def full_url
        base_url + resource
      end

      def username
        Fuci::TeamCity.username
      end

      def password
        Fuci::TeamCity.password
      end

      def uri
        @uri ||= URI full_url
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
        Net::HTTP.start uri.host, uri.port  do |http|
          http.request request_obj
        end
      end
    end
  end
end
