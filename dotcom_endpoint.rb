# require File.expand_path(File.dirname(__FILE__) + '/lib/dotcom.rb')
Dir['./lib/**/*.rb'].each(&method(:require))

class DotcomEndpoint < EndpointBase
  set :logging, true

  post '/send_shipment' do
    begin
  	  msg = Processor.send_shipment(@message[:payload]['shipment'], @config)
  	  code = 200
    rescue DotcomError => e
      msg = e.generate_error_notifications_hash
      code = 500
    rescue => e
      msg = standard_error_notifications_hash(e)
      code = 500
    end

    process_result code, base_msg.merge(msg)
  end

  post '/tracking' do
    begin
      msg = Processor.track_shipment(@message[:payload]['shipment'], @config)
      code = 200
    rescue DotcomError => e
      msg = e.generate_error_notifications_hash
    rescue => e
      msg = standard_error_notifications_hash(e)
      code = 500
    end

    process_result code, base_msg.merge(msg)
  end

  private
  def base_msg
  	{ 'message_id' => @message[:message_id] }
  end

  def standard_error_notifications_hash(e)
    { notifications:
      [
      	{ 
          level: 'error',
          subject: e.message.strip,
          description: e.backtrace.to_a.join('\n\t')
        }
      ]
    }
  end
end
