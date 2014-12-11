require 'rails_helper'

describe "Logging In" do

	before do
		@user = create(:user)
		visit login_path
	end

	context "with invalid information" do

		before { click_button "Log In" }

		it "should re-render the Log In page" do
			expect(current_path).to eq login_path
		end

		it "should contain an error message" do
			expect(page).to have_selector('div.alert.alert-danger')
		end
	end

	describe "with valid information" do
		before do
			fill_in 'Name', with: @user.name
			fill_in 'Password', with: "foobar"
			click_button "Log In"
		end

		it "should redirect to the users index of bookings" do
			expect(page).to have_content("Current Bookings")
		end
		
	end
 
end

