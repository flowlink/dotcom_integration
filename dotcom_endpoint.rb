require "sinatra"
require "endpoint_base"

Dir['./lib/**/*.rb'].each(&method(:require))

class DotcomEndpoint < EndpointBase::Sinatra::Base
  set :logging, true

  post '/send_shipment' do
    begin
  	  msg = Processor.send_shipment(@payload['shipment'], @config)
  	  code = 200
    rescue => e
      msg = e.message
      code = 500
    end

    result code, msg
  end

  post '/tracking' do
    begin
      msg = Processor.track_shipments(@config)
      code = 200
    rescue => e
      msg = e.message
      code = 500
    end

    result code, msg
  end
end
