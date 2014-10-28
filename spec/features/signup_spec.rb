require 'rails_helper'

describe "Signing up new user" do

	before do
		@user = User.create(name: "Champ", initials: "CSB", email: "champ@gmail.com", password: "foobar", password_confirmation: "foobar", admin: true)
		visit login_path
		fill_in "Name", with: "Champ"
		fill_in "Password", with: "foobar"
		click_button "Log In"
		visit signup_path
	end

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