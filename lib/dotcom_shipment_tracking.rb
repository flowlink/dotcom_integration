class DotcomShipmentTracking < DotcomConfig
  attr_accessor :last_shipment_date

  def initialize config
    super(config)
    @last_shipment_date = Date.strptime(config['dotcom.last_shipment_date'])
  end

  def request_path
    "/shipment?fromShipDate=#{last_shipment_date.to_s}&toShipDate=#{Date.today.next.to_s}"
  end

  def poll!
    response = super
    messages = []
    if response['shipments'] and response['shipments'].key?('shipment')
      response['shipments']['shipment'].each do |shipment|

        find_latest_ship_date(shipment)
        messages << create_message(shipment)
      end
    end
    messages
  end

  private
  def create_message shipment
    {
      message: 'shipment:confirm',
      inflate: true,
      payload: {
        order: {},
        shipment: {
          number:               shipment['dcd_order_number'].split(/-/).last,
          order_number:         shipment['dcd_order_number'].split(/-/).first,
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

  def find_latest_ship_date shipment
    if shipment['ship_date']
      ship_date = Date.strptime(shipment['ship_date'], "%m/%d/%Y")

      self.last_shipment_date = ship_date if ship_date and (ship_date > last_shipment_date)
    end
  end
end