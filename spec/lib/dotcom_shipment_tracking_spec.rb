require 'spec_helper'

describe DotcomShipmentTracking do
  let(:config)   { Factories.processed_config }

  it 'initializes correctly' do
    instance = described_class.new(config)
    instance.last_shipment_date.should be_kind_of(String)
  end

  it '#request_path includes last_shipment_date' do
    instance = described_class.new(config)
    instance.request_path.should match("fromShipDate=#{config['dotcom.last_shipment_date']}")
  end

  it '#send! returns array of shipment:confirm messages' do
    VCR.use_cassette('dotcom_shipment_success') do
      Time.stub(:now => (Time.new 2013,10,24,18,29,05,'-04:00'))
      instance = described_class.new(config)
      response = instance.send!
      response.should be_kind_of(Array)
    end
  end

  it '#send! returns empty array' do
    config['dotcom.last_shipment_date'] = '2013-10-23'

    VCR.use_cassette('dotcom_shipment_empty') do
      Time.stub(:now => (Time.new 2013,10,24,18,29,05,'-04:00'))
      instance = described_class.new(config)
      response = instance.send!
      response.count.should eq(0)
      instance.last_shipment_date.to_s.should eq(config['dotcom.last_shipment_date']) # Should not change last_shipment_date
    end
  end
end
