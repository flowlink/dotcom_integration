require 'spec_helper'

describe DotcomError do
  let(:error) {
    [{"error_description"=>
      "Invalid Item. Item SPR-00001 does not exist in the item master.",
      "order_number"=>"H215918586"}]
  }

  subject { described_class.new(error) }

  it 'creates valid object' do
    subject.errors_array.should eq(error)
    subject.should be_kind_of(StandardError)
  end

  it '#generate_error_notifications_hash returns correct hash/structure' do
    expect(subject.message).to match "Invalid Item. Item SPR-00001 does not exist in the item master."
  end
end
