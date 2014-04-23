require "sinatra"
require "endpoint_base"

Dir['./lib/**/*.rb'].each(&method(:require))

class DotcomEndpoint < EndpointBase::Sinatra::Base
  set :logging, true

  post '/add_shipment' do
    begin
  	  msg = Processor.send_shipment(@payload['shipment'], @config)
  	  code = 200
    rescue => e
      msg = e.message
      code = 500
    end

    result code, msg
  end

  post '/get_shipments' do
    begin
      tracker = Processor.track_shipments(@config)
      messages = tracker.send!

      messages.each { |m| add_object :shipment, m }
      add_parameter 'dotcom.last_polling_datetime', tracker.next_polling_datetime

      msg = 'Successfully tracked shipment(s) from Dotcom distribution'
      code = 200
    rescue => e
      msg = e.message
      code = 500
    end

    result code, msg
  end
end
