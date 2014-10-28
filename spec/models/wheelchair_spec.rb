require 'rails_helper'

RSpec.describe Wheelchair, :type => :model do
  
  before do
  	@wheelchair = Wheelchair.new(manufacturer: "Sunrise", model: "Quickie 2",
  															 width: 18, depth: 16, color: "Black",
  															 inventory_tag: "SUN Quickie 2",
  															 serial_number: "Q2-120524")
  end

  it "should have the right attributes" do
  	expect(@wheelchair).to respond_to(:manufacturer, :model, :width,
  																		:depth, :color, :inventory_tag,
  																		:serial_number)
  end
  it "should be valid" do
  	expect(@wheelchair).to be_valid
  end

  describe "with blank manufacturer" do
  	before { @wheelchair.manufacturer = "" }
  	it "should not be valid" do
  		expect(@wheelchair).not_to be_valid
  	end
  end

  describe "with blank model" do
  	before { @wheelchair.model = "" }
  	it "should not be valid" do
  		expect(@wheelchair).not_to be_valid
  	end
  end

  describe "with blank width" do
  	before { @wheelchair.width = "" }
  	it "should not be valid" do
  		expect(@wheelchair).not_to be_valid
  	end
  end

  describe "with blank depth" do
  	before { @wheelchair.depth = "" }
  	it "should not be valid" do
  		expect(@wheelchair).not_to be_valid
  	end
  end

  describe "with blank inventory_tag" do
  	before { @wheelchair.inventory_tag = "" }
  	it "should not be valid" do
  		expect(@wheelchair).not_to be_valid
  	end
  end

  describe "with blank serial number" do
  	before { @wheelchair.serial_number = "" }
  	it "should not be valid" do
  		expect(@wheelchair).not_to be_valid
  	end
  end
end
