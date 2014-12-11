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

  describe "associations" do
    before do
      @user = create(:user)
      @powerchair = create(:powerchair)
      @wheelchair = create(:wheelchair)
      @new_booking1 = @powerchair.bookings.build(start_date: "2014-12-12", end_date: "2014-12-14", user_id: @user.id)
      @new_booking2 = @wheelchair.bookings.create(start_date: "2014-12-12", end_date: "2014-12-14", user_id: @user.id)
      @bookings = @user.bookings.all
    end

    context "with the bookable item models" do

      it "will be valid with a bookable item" do
        @new_booking1.valid?
        expect(@new_booking1).to be_valid
      end
      it "will have the right bookable type" do
        expect(@new_booking1.bookable_type).to eq("Powerchair")
      end
      it "will have the right bookable_id" do
        expect(@new_booking1.bookable_id).to eq(@powerchair.id)
      end
      it "will be invalid without a bookable type" do
        @new_booking1.bookable_type = nil
        @new_booking1.valid?
        expect(@new_booking1).to_not be_valid
      end
      it "will be invalid without a bookable id" do
        @new_booking1.bookable_id = nil
        @new_booking1.valid?
        expect(@new_booking1).to_not be_valid
      end
      it "will be invalid without an associated user" do
        @new_booking1.user_id = nil
        @new_booking1.valid?
        expect(@new_booking1).to_not be_valid
      end
    end

    context "with the user model" do
      describe "the @bookings array" do
        it "will contain both of the new bookings" do
          @new_booking1.save
          expect(@bookings).to match_array([@new_booking1, @new_booking2])
        end
      end
    end
  end  
end
