require 'rails_helper'

RSpec.describe Mattress, :type => :model do

	before do 
		@mattress = Mattress.new(manufacturer: "BFF", model_type: "LTC4000", size: "36x80", inventory_tag: "BFF LTC4000", serial_number: "5428154")
		@user = create(:user)
	end
  
  it "should have the right attributes" do 
  	expect(@mattress).to respond_to(:manufacturer, :model_type, :size, :inventory_tag, :serial_number)
  end

  it "is valid with a manufacturer, model, size, inventory_tag, and serial_number" do
  	expect(@mattress).to be_valid
  end

  it "is invalid without a manufacturer" do
  	@mattress.manufacturer = ""
  	expect(@mattress).to_not be_valid
  end

  it "is invalid without a model" do
  	@mattress.model_type = ""
  	expect(@mattress).to_not be_valid
  end

  it "is invalid without a size" do
  	@mattress.size = ""
  	expect(@mattress).to_not be_valid
  end

  it "is invalid without a inventory tag" do
  	@mattress.inventory_tag = ""
  	expect(@mattress).to_not be_valid
  end

  it "is invalid without a serial number" do
  	@mattress.serial_number = ""
  	expect(@mattress).to_not be_valid
  end

  it "will be bookable" do
  	@mattress.save
  	booking = @mattress.bookings.new(start_date: "2014-12-12", end_date: "2014-12-14", user_id: @user.id)
  	expect(booking).to be_valid
  end

end
