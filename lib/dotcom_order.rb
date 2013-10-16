class DotcomOrder < DotcomConfig
  attr_reader :shipment

  def initialize shipment, config
    @shipment = shipment

    super(config)
  end

  def request_path 
    '/order'
  end

  def generate_xml
    Nokogiri::XML::Builder.new do |xml|
      xml.orders {
        xml.order {
          xml.__send__('order-number', number)
          xml.__send__('ship-date', shipped_at)
          xml.__send__('ship-method', shipping_method)
          xml.__send__('invoice-number', order_number)

          xml.__send__('shipping-information') {
            xml.name        shipping_full_name
            xml.address1    shipping_address1
            xml.address2    shipping_address2
            xml.city        shipping_city
            xml.state       shipping_state
            xml.country     shipping_country
            xml.zip         shipping_zipcode
            xml.phone       shipping_phone
            xml.email       email
          }

          xml.__send__('line_items') {
            shipment_items.each_with_index do |item, index|
              xml.__send__('line_item') {
                xml.__send__('client-item', item['name'])
                xml.sku                     item['sku']
                xml.quantity                item['quantity']
                xml.price                   item['price']
              }
            end
          }
        }
      }
    end.to_xml
  end

  private

  # TODO Re-factor, generate these dynamically with define_method
  def number
    shipment['number']
  end

  def order_number
    shipment['order_number']
  end

  def shipped_at
    shipment['shipped_at']
  end

  def shipping_method
    shipment['shipping_method']
  end

  def email
    shipment['email']
  end

  def shipping_address
    shipment['shipping_address']
  end

  def shipping_address1
    shipping_address['address1']
  end

  def shipping_address2
    shipping_address['address2']
  end

  def shipping_city
    shipping_address['city']
  end

  def shipping_state
    shipping_address['state']
  end

  def shipping_country
    shipping_address['country']
  end

  def shipping_zipcode
    shipping_address['zipcode']
  end

  def shipping_phone
    shipping_address['phone']
  end

  def shipping_full_name
    "#{shipping_address['firstname']} #{shipping_address['lastname']}"
  end

  def shipment_items
    shipment['items']
  end
end