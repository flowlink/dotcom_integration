class Sender

  def self.send_shipment doc, config
    shipment = DotcomOrder.new(shipment)
    shipment.send!(config)
  end

end