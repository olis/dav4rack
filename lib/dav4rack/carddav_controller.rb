require 'dav4rack/controller'

module DAV4Rack
  class CarddavController < Controller
    
    def options
      response["Allow"] = 'OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, COPY, MOVE, MKCOL, PROPFIND, PROPPATCH, LOCK, UNLOCK, REPORT, ACL'
      response["Dav"] = '1, 2, 3, access-control, addressbook, extended-mkcol'
      #response["Ms-Author-Via"] = "DAV"
      OK
    end
    
    def render_xml(root_type)
      raise ArgumentError.new 'Expecting block' unless block_given?
      doc = Nokogiri::XML::Builder.new do |xml_base|
        xml_base.send(root_type.to_s, 'xmlns:D' => 'DAV:', 'xmlns:C' => 'urn:ietf:params:xml:ns:carddav') do
          xml_base.parent.namespace = xml_base.parent.namespace_definitions.first
          xml = xml_base['D']
          yield xml
        end
      end
      
      response.body = doc.to_xml
      response["Content-Type"] = 'text/xml; charset="utf-8"'
      response["Content-Length"] = response.body.size.to_s
    end
    
  end
end