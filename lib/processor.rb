class Processor

  def self.send_shipment doc, config
    shipment = DotcomOrder.new(doc, config)
    response = shipment.send!

    if response['order_errors'] and response['order_errors'].key?('order_error')
      errors = response['order_errors']['order_error']
      errors = [errors] if errors.class == Hash

      raise DotcomError.new(errors)
    else
      { :notifications => success_notification }
    end
  end

  private 
  def self.success_notification
    [
      {
        level: 'info',
        subject: 'Successfully Sent Shipment to Dotcom Distribuition',
        description: 'Successfully Sent Shipment to Dotcom Distribuition'
      }
    ]
  end
end