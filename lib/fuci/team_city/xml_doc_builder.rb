require 'nokogiri'

module Fuci
  module TeamCity
    class XmlDocBuilder
      def self.from_resource resource
        request  = Request.new resource
        response = request.call

        Nokogiri::XML response
      end
    end
  end
end
