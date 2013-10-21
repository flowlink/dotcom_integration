require 'spec_helper'

describe DotcomEndpoint do
  let(:message) {
    {
      'store_id' => '123229227575e4645c000001',
      'message_id' => 'abc',
      'payload' => Factories.payload({'parameters' => Factories.config})
    }
  }

  def app
    DotcomEndpoint
  end

  def auth
    {'HTTP_X_AUGURY_TOKEN' => 'x123', "CONTENT_TYPE" => "application/json"}
  end

  it 'successfully sends shipment' do
    VCR.use_cassette('dotcom_success') do
      post '/send_shipment', message.to_json, auth

      last_response.status.should eq(200)
      last_response.body.should match("message_id")
      last_response.body.should match("notifications")
      last_response.body.should match("Successfully Sent")
    end
  end

  it 'fails with non-existent products' do
    VCR.use_cassette('dotcom_fail') do
      # Replace valid items with non-existent ones
      message['payload'] = Factories.payload({'parameters' => Factories.config}, Factories.non_existent_items)

      post '/send_shipment', message.to_json, auth

      last_response.status.should eq(500)
      last_response.body.should match("message_id")
      last_response.body.should match("notifications")
      last_response.body.should match("Invalid Item.")
    end
  end
end
