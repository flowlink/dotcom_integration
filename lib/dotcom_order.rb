require './lib/helpers'

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
          xml.send 'order-number',                 "#{order_number}-#{number}"
          xml.send 'ship_date',                    shipped_at
          xml.send 'ship-method',                  shipping_method
          xml.send 'invoice-number',               0
          xml.send 'order-date',                   Date.today.to_s
          xml.send 'ship_via',                     ''
          xml.send 'special-instructions',         ''
          xml.send 'special-messaging',            ''
          xml.send 'drop-ship',                    ''
          xml.send 'ok-partial-ship',              ''
          xml.send 'declared-value',               0
          xml.send 'cancel-date',                  Date.today.to_s
          xml.send 'total-tax',                    0
          xml.send 'total-shipping-handling',      0
          xml.send 'total-discount',               0
          xml.send 'total-order-amount',           0
          xml.send 'po-number',                    ''
          xml.send 'salesman',                     ''
          xml.send 'credit-card-number',           ''
          xml.send 'credit-card-expiration',       ''
          xml.send 'ad-code',                      ''
          xml.send 'continuity-flag',              ''
          xml.send 'freight-terms',                ''
          xml.send 'department',                   ''
          xml.send 'pay-terms',                    ''
          xml.send 'tax-percent',                  0
          xml.send 'asn-qualifier',                ''
          xml.send 'gift-order-indicator',         ''
          xml.send 'order-source',                 ''
          xml.send 'promise-date',                 Date.today.to_s
          xml.send 'third-party-account',          ''
          xml.send 'priority',                     ''
          xml.send 'retail-department',            ''
          xml.send 'retail-store',                 ''
          xml.send 'retail-vendor',                ''
          xml.send 'pool',                         ''

          xml.send('billing-information') {
            xml.send 'billing-customer-number',    ''
            xml.send 'billing-name',               'A'
            xml.send 'billing-company',            ''
            xml.send 'billing-address1',           'A'
            xml.send 'billing-address2',           'A'
            xml.send 'billing-address3',           'A'
            xml.send 'billing-city',               'A'
            xml.send 'billing-state',              ''
            xml.send 'billing-zip',                20814
            xml.send 'billing-country',            ''
            xml.send 'billing-phone',              ''
            xml.send 'billing-email',              ''
          }

          xml.send('custom-fields') {
            xml.send 'custom-field-1',             ''
            xml.send 'custom-field-2',             ''
            xml.send 'custom-field-3',             ''
            xml.send 'custom-field-4',             ''
            xml.send 'custom-field-5',             ''
          }

          xml.send('shipping-information') {
            xml.send 'shipping-customer-number',   ''
            xml.send 'shipping-name',              shipping_full_name
            xml.send 'shipping-address1',          shipping_address1
            xml.send 'shipping-address2',          shipping_address2
            xml.send 'shipping-address3',          ''
            xml.send 'shipping-city',              shipping_city
            xml.send 'shipping-state',             states_hash[shipping_state]
            xml.send 'shipping-country',           shipping_country
            xml.send 'shipping-iso-country-code',  ''
            xml.send 'shipping-zip',               shipping_zipcode
            xml.send 'shipping-phone',             shipping_phone
            xml.send 'shipping-email',             email
            xml.send 'shipping-company',           ''
          }

          xml.send('store-information') {
            xml.send 'store-name',                 shipping_full_name
            xml.send 'store-address1',             shipping_address1
            xml.send 'store-address2',             shipping_address2
            xml.send 'store-city',                 shipping_city
            xml.send 'store-state',                'MD' # shipping_state convert to 2 chars
            xml.send 'store-country',              shipping_country
            xml.send 'store-zip',                  shipping_zipcode
            xml.send 'store-phone',                shipping_phone
          }          

          xml.send('line-items') {
            shipment_items.each_with_index do |item, index|
              xml.send('line-item') {
                xml.send 'client-item',            item['variant_id']
                xml.sku                            item['sku']
                xml.quantity                       item['quantity']
                xml.price                          item['price']
                xml.tax                            0
                xml.send 'shipping-handling',      0
                xml.send 'line-number',            ''
                xml.send 'gift-box-wrap-quantity', 0
                xml.send 'gift-box-wrap-type',     ''

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
    shipment['shipped_at'][0..-11]
  end

  def shipping_method
    shipment['shipping_method'][0..2]
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