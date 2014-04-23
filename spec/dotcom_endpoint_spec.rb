require 'spec_helper'

describe DotcomEndpoint do
  let(:message) {
    Factories.payload({'parameters' => Factories.config})
  }

  it '/send_shipment succeeds with existing products' do
    VCR.use_cassette('dotcom_order_success') do
      post '/send_shipment', message.to_json, auth

      last_response.status.should eq(200)
      last_response.body.should match("Successfully sent")
    end
  end

  it '/send_shipment fails with non-existing products' do
    VCR.use_cassette('dotcom_order_fail') do
      # Replacing valid items with non-existent ones
      message = Factories.payload({'parameters' => Factories.config}, Factories.non_existent_items)
      post '/send_shipment', message.to_json, auth

      last_response.status.should eq(500)
      last_response.body.should match("Invalid Item.")
    end
  end

  it '/send_shipment fails with non-existing products' do
    VCR.use_cassette('dotcom_shipment_success') do
      Time.stub(:now => (Time.new 2013,10,24,18,29,05,'-04:00'))
      # Replacing valid items with non-existent ones
      post '/tracking', message.to_json, auth
      last_response.status.should eq(200)
    end
  end
end
