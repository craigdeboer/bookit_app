require 'rails_helper'

RSpec.describe Booking, :type => :model do

	before { @booking = Booking.new(start_date: "2014-10-28", end_date: "2014-10-30", bookable_type: "Powerchair", bookable_id: "1", user_id: "4") }
  
  it "should have the right attributes" do
  	expect(@booking).to respond_to(:start_date, :end_date, :user_id, :bookable_id, :bookable_type)
  end

  it "is valid with a user_id, bookable type, bookable id, start_date and end_date" do
    expect(@booking).to be_valid
  end

  it "is invalid with blank user id" do
    @booking.user_id = "" 
    @booking.valid?
    expect(@booking.errors[:user_id]).to include("can't be blank")
  end

  it "is invalid with blank bookable type" do
    @booking.bookable_type = "" 
    @booking.valid?
    expect(@booking.errors[:bookable_type]).to include("can't be blank")
  end

  it "is invalid with blank bookable id" do
    @booking.bookable_id = "" 
    @booking.valid?
    expect(@booking.errors[:bookable_id]).to include("can't be blank")
  end

  it "is invalid with blank start date" do
  	@booking.start_date = "" 
  	@booking.valid?
    expect(@booking.errors[:start_date]).to include("can't be blank")
  end

  it "is invalid with blank end date" do
    @booking.end_date = "" 
    @booking.valid?
    expect(@booking.errors[:end_date]).to include("can't be blank")
  end

  describe "polymorphic association with bookable items" do
    before do
      @user = User.create(name: "Peter Puck", initials: "PPP", email: "ppuck@gmail.com", password: "foobar", password_confirmation: "foobar")
      @powerchair = Powerchair.create(manufacturer: "Pride", model_type: "Q6 Edge", drive: "Mid", inventory_tag: "Pri Q6edge", serial_number: "pri002514")
      @new_booking = @powerchair.bookings.build(start_date: "2014-12-04", end_date: "2014-12-06", user_id: @user.id)
    end

    it "will be valid with a bookable item" do
      @new_booking.valid?
      expect(@new_booking).to be_valid
    end

    it "will have the right bookable type" do
      expect(@new_booking.bookable_type).to eq("Powerchair")
    end

    it "will have the right bookable_id" do
      expect(@new_booking.bookable_id).to eq(@powerchair.id)
    end
  end



end
