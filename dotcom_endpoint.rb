# require File.expand_path(File.dirname(__FILE__) + '/lib/dotcom.rb')
Dir['./lib/**/*.rb'].each { |f| require f }

class DotcomEndpoint < EndpointBase
  set :logging, true

  post '/send_shipment' do
    begin
  	  msg = Processor.send_shipment(@message[:payload]['shipment'], @config)
  	  code = 200
    rescue => e
      msg = error_notification(e)
      code = 500
    end

    process_result 200, base_msg.merge(msg)
  end

  # post '/tracking' do
    # begin
    #   shipment_tracking = ShipmentTracking.new(@message[:payload], @message[:message_id], @config)
    #   msg = shipment_tracking.consume

    #   code = 200
    # rescue => e
    #   msg = error_notification(e)
    #   code = 500
    # end

    # process_result code, base_msg.merge(msg)
  # end

  private
  def base_msg
  	{ 'message_id' => @message[:message_id] }
  end

  # def success_notification(response)
  #   { notifications:
  #     [
  #     	{ level: 'info',
  #         subject: 'Successfully Sent Shipment to Shipwire',
  #         description: 'Successfully Sent Shipment to Shipwire' }
  #     ]
  #   }.merge(response)
  # end

  def error_notification(e)
    { notifications:
      [
      	{ level: 'error',
          subject: e.message.strip,
          description: e.backtrace.to_a.join('\n\t') }
      ]
    }
  end
end