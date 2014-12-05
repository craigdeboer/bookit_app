require 'rails_helper'

RSpec.describe Scooter, :type => :model do
  
	before do
  	@scooter = Scooter.new(manufacturer: "Invacare", model_type: "Pegasus",
  												 wheels: "4 wheel", color: "Black",
  												 inventory_tag: "inv peg4wh",
  												 serial_number: "inv-4125")
  end

  it "should have the right attributes" do
  	expect(@scooter).to respond_to(:manufacturer, :model_type, :wheels, :color, 
  																 :inventory_tag, :serial_number)
  end
  it "is valid with a manufacturer, model, wheels, inventory tag, and serial number" do
  	expect(@scooter).to be_valid
  end

  it "is invalid with blank manufacturer" do
  	@scooter.manufacturer = ""
  	expect(@scooter).not_to be_valid
  end

  it "is invalid with blank model type" do
    @scooter.model_type = ""
    expect(@scooter).not_to be_valid
  end
  
  it "is invalid with blank wheels" do
    @scooter.wheels = ""
    expect(@scooter).not_to be_valid
  end

  it "is invalid with blank inventory tag" do
    @scooter.inventory_tag = ""
    expect(@scooter).not_to be_valid
  end

  it "is invalid with blank serial number" do
    @scooter.serial_number = ""
    expect(@scooter).not_to be_valid
  end


end
