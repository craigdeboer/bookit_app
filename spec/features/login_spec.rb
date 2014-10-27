require 'rails_helper'

describe "Logging In" do

	before do
		@user = User.create(name: "Champ", initials: "CSB", email: "champ@gmail.com", password: "foobar", password_confirmation: "foobar")
		visit login_path
	end

	describe "with invalid information" do

		before { click_button "Log In" }

		it "should re-render the Log In page" do
			expect(page).to have_selector('h1', text: "Log In")
		end

		it "should contain an error message" do
			expect(page).to have_selector('div.alert.alert-danger')
		end
	end

	describe "with valid information" do
		before do
			fill_in 'Name', with: "Champ"
			fill_in 'Password', with: "foobar"
			click_button "Log In"
		end

		it "should redirect to the user's show page" do
			expect(page).to have_selector('h1', text: "This is the user's show page")
		end
		
	end
 
end

