require 'spec_helper'

describe DotcomOrder do
  let(:shipment) { Factories.shipment }
  let(:config)   { Factories.config }

  it 'initializes correctly' do
    instance = described_class.new(shipment, config)
    instance.shipment.should eq(shipment)
    # TODO test the call to super
  end
end
