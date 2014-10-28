require 'rails_helper'

describe "Authorization:" do

before { @user = User.create(name: "Champ", initials: "CSB", email: "champ@gmail.com", password: "foobar", password_confirmation: "foobar") }

	describe "Visiting a user's show page" do

		describe "when not logged in" do
			before { visit user_path(@user) }
			it "should redirect to login page" do
				expect(page).to have_selector('h1', text: "Please Log In")
			end
		end

		describe "when logged in" do
			before do
				visit login_path
				fill_in 'Name', with: "Champ"
				fill_in 'Password', with: "foobar"
				click_button "Log In"
				visit user_path(@user)
			end
			it "should render the user's show page" do
				expect(page).to have_content("Hi Champ")
			end
		end
	end

	describe "Visiting the signup path" do

		describe "when logged in as non-admin" do
			before do
				visit login_path
				fill_in 'Name', with: "Champ"
				fill_in 'Password', with: "foobar"
				click_button "Log In"
				visit signup_path
			end
			it "should redirect to the user's show page" do
				expect(page).to have_selector('h1', "This is the user's show page")
			end
		end

		describe "when logged in as admin" do
			before do
				visit login_path
				@user.admin = true
				fill_in 'Name', with: "Champ"
				fill_in 'Password', with: "foobar"
				click_button "Log In"
				visit signup_path
			end
			it "should render the signup page" do
				expect(page).to have_selector('h1', "Sign up a new User")
			end
		end
	end

end