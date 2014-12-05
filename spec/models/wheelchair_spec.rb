require 'rails_helper'

RSpec.describe Wheelchair, :type => :model do
  
  before do
  	@wheelchair = Wheelchair.new(manufacturer: "Sunrise", model_type: "Quickie 2",
  															 width: 18, depth: 16, color: "Black",
  															 inventory_tag: "SUN Quickie 2",
  															 serial_number: "Q2-120524")
  end

  it "should have the right attributes" do
  	expect(@wheelchair).to respond_to(:manufacturer, :model_type, :width,
  																		:depth, :color, :inventory_tag,
  																		:serial_number)
  end
  it "is valid with a manufacturer, model, width, depth, color, inventory tag, and serial number" do
  	expect(@wheelchair).to be_valid
  end

  it "is invalid with blank manufacturer" do
  	@wheelchair.manufacturer = ""
  	expect(@wheelchair).not_to be_valid
  end

  it "is invalid with blank model type" do
    @wheelchair.model_type = ""
    expect(@wheelchair).not_to be_valid
  end
  
  it "is invalid with blank width" do
    @wheelchair.width = ""
    expect(@wheelchair).not_to be_valid
  end

  it "is invalid with blank depth" do
    @wheelchair.depth = ""
    expect(@wheelchair).not_to be_valid
  end

  it "is invalid with blank inventory tag" do
    @wheelchair.inventory_tag = ""
    expect(@wheelchair).not_to be_valid
  end

  it "is invalid with blank serial number" do
    @wheelchair.serial_number = ""
    expect(@wheelchair).not_to be_valid
  end

  
end
