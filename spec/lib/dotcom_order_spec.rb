require 'spec_helper'

describe DotcomOrder do
  let(:shipment) { Factories.shipment }
  let(:config)   { Factories.config }

  it 'initializes correctly' do
    instance = described_class.new(shipment, config)
    instance.shipment.should eq(shipment)
  end

  it 'raises error if order_number + number exceed 20 characters' do
    shipment['number'] = shipment['order_number'] = 'A' * 11
    expect {
      instance = described_class.new(shipment, config)
    }.to raise_error(DotcomEndpointError)
  end  
end
