require 'rails_helper'

	feature 'Static Pages' do
		scenario "visit home page when not logged in" do
			visit root_path
			expect(page).to have_content 'Please Log In'
		end
		scenario "visit home page as non admin user" do
			user = create(:user)
			sign_in user
			visit root_path
			expect(page).to have_link "Book Equipment"
			expect(page).to_not have_link "Manage Users"
		end
		scenario "visit home page as admin user" do
			user = create(:admin_user)
			sign_in user
			visit root_path
			expect(page).to have_link "Book Equipment"
			expect(page).to have_link "Manage Users"
		end	
	end

	

