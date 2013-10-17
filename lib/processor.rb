class Processor

  def self.send_shipment doc, config
    shipment = DotcomOrder.new(doc, config)
    response = shipment.send!

    notifications = []
    if response.key?('order_errors')
      response['order_errors']['order_error'].each do |error|
        notifications << error_notification(error)
      end
    else
      success_notification
    end

    { :notifications => notifications }
  end

  private 
  def self.success_notification
    {
      level: 'info',
      subject: 'Successfully Sent Shipment to Dotcom Distribuition',
      description: 'Successfully Sent Shipment to Dotcom Distribuition'
    }
  end

  def self.error_notification(error)
    {
      level: 'error',
      subject: error['error_description'],
      description: error['error_description']
    }
  end

end