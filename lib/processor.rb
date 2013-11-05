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
    shipment_polling = DotcomShipmentTracking.new(config)
    response = shipment_polling.send!

    {
      :messages => response,
      :parameters => [{ 'name' => 'dotcom.last_polling_datetime', 'value' => shipment_polling.next_polling_datetime }],
      :notifications => [ {
        level: 'info',
        subject: 'Successfully tracked shipment(s) from Dotcom distribution',
        description: 'Successfully tracked shipment(s) from Dotcom distribution'
      }]
    }
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
