require 'uri'

class DotcomShipmentTracking < DotcomConfig
  attr_accessor :last_shipment_date, :next_shipment_date

  def initialize config
    super(config)
    @last_shipment_date = config['dotcom.last_shipment_date']

    @next_shipment_date = (Time.now - fifteen_minutes).to_s
  end

  def request_path
    "/shipment?fromShipDate=#{URI.encode(last_shipment_date)}&toShipDate=#{URI.encode(next_shipment_date)}"
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
          tracking:             '',
          tracking_url:         '',
          carrier:              '',
          shipped_date:         shipment['ship_date'],
          delivery_date:        '',
          cost:                 0.0,
          status:               '',
          stock_location:       '',
          shipping_method:      '',
        }
      }
    }
  end
end