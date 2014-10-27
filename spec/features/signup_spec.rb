require 'rails_helper'

describe "Signing up new user" do

	before { visit signup_path}

	describe "with invalid information" do
		it "should not create a new user" do	
			expect{ click_button "Create User" }.not_to change{User.count}
		end
	end

	describe "with valid information" do
		it "should create a new user" do	
			fill_in "Name", with: "Foo Bar"
			fill_in "Initials", with: "FRB"
			fill_in "Email", with: "Foo@gmail.com"
			fill_in "Password", with: "buzzle"
			fill_in "Confirmation", with: "buzzle"
			expect { click_button "Create User"	}.to change{User.count}.by(1)
		end
	end
end