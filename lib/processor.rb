class Processor

  def self.send_shipment shipment, config
    order = DotcomOrder.new(shipment, config)
    response = order.send!

    if response['order_errors'] and response['order_errors'].key?('order_error')
      errors = response['order_errors']['order_error']
      errors = [errors] if errors.class == Hash

      raise DotcomError.new(errors)
    else
      { :notifications => success_notification }
    end
  end

  def self.track_shipments config
    DotcomShipmentTracking.new(config)
  end

  private
  def self.success_notification
    [
      {
        level: 'info',
        subject: 'Successfully sent shipment to Dotcom distribution',
        description: 'Successfully sent shipment to Dotcom distribution'
      }
    ]
  end
end
