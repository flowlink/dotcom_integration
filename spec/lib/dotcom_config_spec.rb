require 'spec_helper'

describe DotcomConfig do
  let(:config) { Factories.config }

  it 'creates valid object' do
    expect {
      instance = described_class.new(config)
      instance.api_key.should eq(config['dotcom.api_key'])
      instance.password.should eq(config['dotcom.password'])
    }.to_not raise_error
  end

  it 'raises error without API key' do
    expect {
      instance = described_class.new('')
    }.to raise_error AuthenticationError
  end
end
