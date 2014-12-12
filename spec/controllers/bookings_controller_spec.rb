require 'rails_helper'

require 'pp'

RSpec.describe BookingsController, :type => :controller do

	before do 
		@user = create(:user)
		@wheelchair = create(:wheelchair)
		@booking1 = create(:booking, start_date: "2014-12-12", end_date: "2014-12-14", user_id: @user.id, bookable_type: "wheelchair", bookable_id: @wheelchair.id)
		@booking2 = create(:booking, user: @user, bookable: @wheelchair)
		@booking3 = create(:booking, user: @user, bookable: @wheelchair, end_date: "2014-11-11")
	end

	context "with a logged in user" do

    before { allow(controller).to receive(:current_user) { @user } }

      describe "GET index" do

			it "assigns @bookings the current users bookings with an end date later than today" do
	      get :index, user_id: @user.id
	      expect(assigns(:bookings)).to match_array([@booking1, @booking2])
	    end

	    it "renders the index page" do
	    	get :index, user_id: @user.id
	    	expect(response).to render_template :index
	    end
    end

    describe "GET #new" do
      it "assigns an array of all the bookings to the instance varialbe" do
        get :new, bookable: "wheelchair", wheelchair_id: @wheelchair.id
        expect(assigns(:bookings)).to match_array([@booking1, @booking2, @booking3])
      end
      it "assigns today's date to @date if no other date has been selected" do
        get :new, bookable: "wheelchair", wheelchair_id: @wheelchair.id
        expect(assigns(:date)).to eq(Date.today)
      end
      it "assigns the date in params[:date] if it is present" do
        get :new, bookable: "wheelchair", wheelchair_id: @wheelchair.id, date: "2014-12-12"
        expect(assigns(:date)).to eq(Date.parse("2014-12-12"))
      end
      it "assigns nil to booking start and end date if those params aren't given" do
        get :new, bookable: "wheelchair", wheelchair_id: @wheelchair.id
        @booking = assigns(:booking)
        expect(@booking.start_date).to eq(nil)
        expect(@booking.end_date).to eq(nil)
      end
      it "assigns a date to start and end date if params are present" do
        get :new, bookable: "wheelchair", wheelchair_id: @wheelchair.id, start_date: "2014-12-12", end_date: "2014-12-14"
        @booking = assigns(:booking)
        expect(@booking.start_date).to eq(Date.parse("2014-12-12"))
        expect(@booking.end_date).to eq(Date.parse("2014-12-14"))
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "will save the booking to the database" do
          expect{ post :create, bookable: "wheelchair", wheelchair_id: @wheelchair.id, start_date: "2014-12-12", end_date: "2014-12-14"}.to change(Booking, :count).by(1)
        end
        it "will render the index page" do
          post :create, bookable: "wheelchair", wheelchair_id: @wheelchair.id, start_date: "2014-12-12", end_date: "2014-12-14"
          expect(response).to redirect_to user_bookings_path(@user)
        end  
      end
      context "with invalid attributes" do
        it "will not save the new booking" do
          expect{ post :create, bookable: "wheelchair", wheelchair_id: @wheelchair.id, start_date: "", end_date: "2014-12-14"}.to_not change(Booking, :count)
        end
        it "will redirect to the home page" do
          post :create, bookable: "wheelchair", wheelchair_id: @wheelchair.id, start_date: "", end_date: "2014-12-14"
          expect(response).to redirect_to root_path
        end
      end
    end

    describe "GET #edit" do
      it "assigns an array of all the bookings to the instance variable" do
        get :edit, id: @booking1.id, bookable: "wheelchair", wheelchair_id: @wheelchair.id
        expect(assigns(:bookings)).to match_array([@booking1, @booking2, @booking3])
      end
      it "assigns the booking start date to @date if no other date has been selected" do
        get :edit, id: @booking1.id, bookable: "wheelchair", wheelchair_id: @wheelchair.id
        expect(assigns(:date)).to eq(@booking1.start_date)
      end
      it "assigns the date in params[:date] if it is present" do
        get :edit, id: @booking1.id, bookable: "wheelchair", wheelchair_id: @wheelchair.id, date: "2014-12-30"
        expect(assigns(:date)).to eq(Date.parse("2014-12-30"))
      end
      it "assigns nil to proposed booking start and end date if booking params aren't present" do
        get :edit, id: @booking1.id, bookable: "wheelchair", wheelchair_id: @wheelchair.id
        @proposed = assigns(:proposed)
        expect(@proposed.start_date).to eq(nil)
        expect(@proposed.end_date).to eq(nil)
      end
      it "assigns a date to start and end date if booking params are present" do
        get :edit, id: @booking1.id, bookable: "wheelchair", wheelchair_id: @wheelchair.id, booking: {start_date: "2014-12-12", end_date: "2014-12-14"}
        @proposed = assigns(:proposed)
        expect(@proposed.start_date).to eq(Date.parse("2014-12-12"))
        expect(@proposed.end_date).to eq(Date.parse("2014-12-14"))
      end
    end
    describe "PATCH #update" do
      it "assigns the correct booking" do
        update = {end_date: "2014-12-16"}
        patch :update, id: @booking1.id, booking: update
        expect(assigns(:booking)).to eq(@booking1)
      end
      context "with valid attributes" do
        it "should save the changes to the booking" do
          update = {end_date: "2014-12-16"}
          patch :update, id: @booking1.id, booking: update
          @booking1.reload
          expect(@booking1.end_date).to eq(Date.parse("2014-12-16"))
        end
        it "should redirect to the user's current bookings" do
          update = {end_date: "2014-12-16"}
          patch :update, id: @booking1.id, booking: update
          expect(response).to redirect_to user_bookings_path(@user.id)
        end
      end
      context "with invalid attributes" do
        it "should not save the changes to the booking" do
          update = {end_date: "2014-12-16", start_date: ""}
          patch :update, id: @booking1.id, booking: update
          @booking1.reload
          expect(@booking1.end_date).to_not eq(Date.parse("2014-12-16"))
          expect(@booking1.start_date).to eq(Date.parse("2014-12-12"))
        end
      end
    end
    describe "DELETE #destroy" do
      it "should delete the booking" do
        expect{delete :destroy, id: @booking1.id
          }.to change(Booking, :count).by(-1)
      end
    end

  end

  context "when not logged in" do

    describe "Get #index" do
	    it "redirects to the login page" do
	    	get :index, user_id: @user.id
	    	expect(response).to redirect_to login_path
	    end
    end

    describe "Get #new" do
      it "redirects to the login page" do
        get :new, bookable: "wheelchair", wheelchair_id: @wheelchair.id
        expect(response).to redirect_to login_path
      end
    end
    describe "Get #edit" do
      it "redirects to the login page" do
        get :edit, id: @booking1.id, bookable: "wheelchair", wheelchair_id: @wheelchair.id
        expect(response).to redirect_to login_path
      end
    end
    describe "Patch #update" do
      it "redirects to the login page" do
        update = {end_date: "2014-12-16"}
        patch :update, id: @booking1.id, booking: update
        expect(response).to redirect_to login_path
      end
    end
  end
end
