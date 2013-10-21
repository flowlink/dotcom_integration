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
    subject.generate_error_notifications_hash.should have_key(:notifications)
    subject.generate_error_notifications_hash[:notifications].should be_kind_of(Array)
    subject.generate_error_notifications_hash[:notifications].first[:level].should eq("error")
    subject.generate_error_notifications_hash[:notifications].first[:subject].should eq("Invalid Item. Item SPR-00001 does not exist in the item master.")
    subject.generate_error_notifications_hash[:notifications].first[:description].should eq("Invalid Item. Item SPR-00001 does not exist in the item master.")
  end
end
