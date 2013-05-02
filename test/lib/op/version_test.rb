require_relative '../../test_helper'
 
describe Op::Foodtruck do
 
  it "must be defined" do
    Op::Foodtruck::VERSION.wont_be_nil
  end
 
end