class DotcomShipmentTracking < DotcomConfig
  attr_reader :last_shipment_date

  def initialize config
    super(config)
    @last_shipment_date = Date.strptime(config['dotcom.last_shipment_date'])
  end

  def request_path
    "/shipment?fromShipDate=#{last_shipment_date}&toShipDate=#{Date.today.next.to_s}"
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

      @last_shipment_date = ship_date if ship_date and (ship_date > last_shipment_date)
    end
  end
end

# => {"client_order_number"=>"21404",
#  "customer_number"=>"wang91011",
#  "dcd_order_number"=>"0202103776",
#  "dcd_order_release_number"=>"01",
#  "order_date"=>"10/25/2012 12:00:00 AM",
#  "order_shipping_handling"=>"9.24",
#  "order_status"=>"Shipped",
#  "order_subtotal"=>"47.4000",
#  "order_tax"=>"4.63",
#  "order_total"=>"71.1900",
#  "ship_date"=>"10/25/2012",
#  "ship_items"=>
#   {"ship_item"=>
#     {"carrier"=>"UPS",
#      "carton_id"=>"c007525989",
#      "client_line_number"=>"1",
#      "item_description"=>"Non stock",
#      "item_unit_price"=>"47.40",
#      "order_line_number"=>"1",
#      "quantity_shipped"=>"2.00",
#      "serial_lot_number"=>nil,
#      "service"=>"UPS Ground",
#      "service_code"=>"03",
#      "sku"=>"9999",
#      "tracking_number"=>"1ZV2X5140300001986",
#      "upc"=>nil}},
#  "ship_weight"=>"1.00",
#  "shipto_addr1"=>"600 Hillcrest Ave",
#  "shipto_addr2"=>nil,
#  "shipto_city"=>"La Canada",
#  "shipto_email_address"=>"ehwang827@gmail.com",
#  "shipto_name"=>"Esther Hwang",
#  "shipto_state"=>"CA",
#  "shipto_zip"=>"91011"}