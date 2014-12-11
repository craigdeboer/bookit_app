require 'rails_helper'

describe "Signing up new user" do

	before do
		@user = create(:admin_user)
		visit login_path
		fill_in "Name", with: @user.name
		fill_in "Password", with: "foobar"
		click_button "Log In"
		click_link "Home"
		click_link "Manage Users"
		click_link "Add New User"

	end

	context "with invalid information" do
		it "does not add a new user to the database" do	
			expect{ click_button "Add User" }.to_not change{User.count}
		end
	end

	context "with valid information" do
		it "adds a new user to the database" do	
			fill_in "Name", with: "Foo Bar"
			fill_in "Initials", with: "FRB"
			fill_in "Email", with: "Foo@gmail.com"
			fill_in "Password", with: "buzzle"
			fill_in "Confirmation", with: "buzzle"
			expect { click_button "Add User"	}.to change{User.count}.by(1)
		end
	end

	

end