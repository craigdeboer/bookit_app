require 'rails_helper'

RSpec.describe Booking, :type => :model do

	before { @booking = Booking.new(start_date: "2014-10-28", end_date: "2014-10-30",) }
  
  it "should have the right attributes" do
  	expect(@booking).to respond_to(:start_date, :end_date, :user_id, :bookable_id, :bookable_type)
  end

  describe "with blank start date" do
  	before { @booking.start_date = "" }
  	it "should not be valid" do
  		expect(@booking).not_to be_valid
  	end
  end

  describe "with blank end date" do
  	before { @booking.end_date = "" }
  	it "should not be valid" do
  		expect(@booking).not_to be_valid
  	end
  end
end
