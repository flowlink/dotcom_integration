require 'uri'

class DotcomShipmentTracking < DotcomConfig
  attr_accessor :last_polling_datetime, :next_polling_datetime

  def initialize config
    super(config)
    @last_polling_datetime = config['dotcom.last_polling_datetime']

    @next_polling_datetime = (Time.now - fifteen_minutes).to_s
  end

  def request_path
    "/shipment?fromShipDate=#{URI.encode(last_polling_datetime)}&toShipDate=#{URI.encode(next_polling_datetime)}"
  end

  def send!
    response = super
    messages = []
    if response['shipments'] and response['shipments'].key?('shipment')
      response['shipments']['shipment'].each do |shipment|
        messages << create_message(shipment)
      end
    end
    messages
  end

  private
  def fifteen_minutes 
    15 * 60
  end

  def create_message shipment
    {
      message: 'shipment:confirm',
      inflate: true,
      payload: {
        order: {},
        shipment: {
          number:               ('H' + shipment['dcd_order_number'].split(/[H]/i).last),
          order_number:         shipment['dcd_order_number'].split(/[H]/i).first,
          tracking:             Array.wrap(shipment['ship_items']['ship_item']).first['tracking_number'] || '',
          tracking_url:         '',
          carrier:              Array.wrap(shipment['ship_items']['ship_item']).first['carrier'] || '',
          shipped_date:         shipment['ship_date'],
          delivery_date:        '',
          cost:                 0.0,
          status:               '',
          stock_location:       '',
          shipping_method:      Array.wrap(shipment['ship_items']['ship_item']).first['service'] || ''
        }
      }
    }
  end
end