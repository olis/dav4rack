require 'dav4rack/controller'

module DAV4Rack
  class CarddavController < Controller
    
    def options
      response["Allow"] = 'OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, COPY, MOVE, MKCOL, PROPFIND, PROPPATCH, LOCK, UNLOCK, REPORT, ACL'
      response["Dav"] = '1, 2, 3, access-control, addressbook, extended-mkcol'
      #response["Ms-Author-Via"] = "DAV"
      OK
    end
    
  end
end