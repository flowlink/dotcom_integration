require 'uri'

class DotcomShipmentTracking < DotcomConfig
  attr_accessor :last_polling_datetime, :next_polling_datetime

  def initialize config
    super(config)
    @last_polling_datetime = config['dotcom_last_polling_datetime']

    @next_polling_datetime = (Time.now - fifteen_minutes).to_s
  end

  def request_path
    "/shipment?fromShipDate=#{URI.encode(last_polling_datetime)}&toShipDate=#{URI.encode(next_polling_datetime)}"
  end

  def send!
    response = super
    messages = []

    if response['shipments'] and response['shipments'].key?('shipment')
      Array.wrap(response['shipments']['shipment']).each do |shipment|
        # For cancelled shipments Dotcom Distribution returns records with quantities set to zero.
        # Do not generate shipment:confirm messages for cancelled shipments.
        total_quantity_shipped = Array.wrap(shipment['ship_items']['ship_item']).sum {|x| x['quantity_shipped'].to_i }
        if total_quantity_shipped > 0
          messages << create_message(shipment)
        end
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
          number:               ('H' + shipment['client_order_number'].split(/[H]/i).last),
          order_number:         shipment['client_order_number'].split(/[H]/i).first,
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
