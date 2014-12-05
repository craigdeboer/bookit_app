require 'rails_helper'

RSpec.describe Powerchair, :type => :model do

	before { @powerchair = Powerchair.new(manufacturer: "Pride", model_type: "Q6 Edge", drive: "Mid", inventory_tag: "Pri Q6edge", serial_number: "pri002514") }

	it "should have the right attributes" do
  	expect(@powerchair).to respond_to(:manufacturer, :model_type, :drive, :color, :inventory_tag, :serial_number)
  end
  
  it "is valid with a manufacturer, model, drive, inventory tag, and serial number" do
  	expect(@powerchair).to be_valid
  end
  it "is invalid without a manufacturer" do
  	@powerchair.manufacturer = ""
  	@powerchair.valid?
  	expect(@powerchair.errors[:manufacturer]).to include("can't be blank")
  end
  it "is invalid without a model" do
  	@powerchair.model_type = ""
  	@powerchair.valid?
  	expect(@powerchair.errors[:model_type]).to include("can't be blank")
  end
  it "is invalid without a drive" do
  	@powerchair.drive = ""
  	@powerchair.valid?
  	expect(@powerchair.errors[:drive]).to include("can't be blank")
  end
  it "is invalid without an inventory tag" do
  	@powerchair.inventory_tag = ""
  	@powerchair.valid?
  	expect(@powerchair.errors[:inventory_tag]).to include("can't be blank")
  end
  it "is invalid without a serial number" do
  	@powerchair.serial_number = ""
  	@powerchair.valid?
  	expect(@powerchair.errors[:serial_number]).to include("can't be blank")
  end

end
