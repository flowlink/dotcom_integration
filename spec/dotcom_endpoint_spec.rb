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
    {'HTTP_X_AUGURY_TOKEN' => 'x123'}
  end

  it 'successfully sends shipment' do
    VCR.use_cassette('dotcom_success') do
      # Processor.should_receive(:send_shipment)
      #   .with( Factories.api_key, Factories.passwor, Factories.order['email'], anything )
      #   .and_return( Processor.info_notification(Processor.success_msg(Factories.order['email'])) )

      post '/send_shipment', message.to_json, auth

      last_response.status.should eq(200)
      # last_response.body.should match("message_id")
      # last_response.body.should match("email")
      # last_response.body.should match("list_id")
      # last_response.body.should match("notifications")
      # last_response.body.should match("Successfully subscribed")
    end
  end

  # it 'succeeds if email is already subscribed' do
  #   VCR.use_cassette('processor_subscribe_invalid_already_subscribed') do
  #     Processor.should_receive(:subscribe_to_list)
  #       .with( Factories.api_key, Factories.list_id, Factories.order['email'], anything )
  #       .and_return( Processor.info_notification(Processor.already_subscribed_msg(Factories.order['email'])) )

  #     post '/send_shipment', message.to_json, auth

  #     last_response.status.should eq(200)

  #     last_response.body.should match("message_id")
  #     last_response.body.should match("email")
  #     last_response.body.should match("list_id")
  #     last_response.body.should match("notifications")
  #     last_response.body.should match("is already subscribed")
  #   end
  # end

  # it 'fails if MailChimp returns an error' do
  #   VCR.use_cassette('processor_subscribe_invalid_email') do
  #     post '/send_shipment', message.to_json, auth

  #     last_response.status.should eq(500)

  #     last_response.body.should match("message_id")
  #     last_response.body.should match("email")
  #     last_response.body.should match("list_id")
  #     last_response.body.should match("notifications")
  #     last_response.body.should match("Invalid Email Address")
  #   end
  # end
end
