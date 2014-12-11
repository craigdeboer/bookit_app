require 'rails_helper'

RSpec.describe Other, :type => :model do
	
  before do 
		@other = Other.new(manufacturer: "Evolution", model_type: "", inventory_tag: "", description: "Evolution xpresso walker std")
		@user = create(:user)
	end

	it "should have the right attributes" do 
  	expect(@other).to respond_to(:manufacturer, :model_type, :inventory_tag, :description)
  end

  it "is valid with a manufacturer and a description" do
  	expect(@other).to be_valid
  end

  it "is invalid without a manufacturer" do
  	@other.manufacturer = ""
  	expect(@other).to_not be_valid
  end

  it "is invalid without a description" do
  	@other.description = ""
  	expect(@other).to_not be_valid
  end

  it "will be bookable" do
  	@other.save
  	booking = @other.bookings.new(start_date: "2014-12-12", end_date: "2014-12-14", user_id: @user.id)
  	expect(booking).to be_valid
  end
end
