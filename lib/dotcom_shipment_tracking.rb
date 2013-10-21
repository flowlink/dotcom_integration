class DotcomShipmentTracking < DotcomConfig
  def request_path
    '/shipment/9004859200'
  end

  def generate_xml
    Nokogiri::XML::Builder.new do |xml|
      xml.shipments {
        xml.fromShipDate  '2010-10-01'
        xml.toShipDate    '2013-10-01'
      }
    end.to_xml
  end
end