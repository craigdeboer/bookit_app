require 'rails_helper'

feature 'User management' do
	scenario "adds a new user" do
		admin = create(:admin_user)
		sign_in(admin)

		expect(page).to have_content 'Current Bookings'

		click_link 'Home'
		click_link 'Manage Users'
		click_link 'Add New User'

		fill_in 'Name', with: "Reg Arnold"
		fill_in 'Initials', with: "RAP"
		fill_in 'Email', with: "Reg@gmail.com"
		fill_in 'Password', with: "foobar"
		fill_in 'Confirmation', with: "foobar"
		
		expect{ click_button 'Add User' }.to change(User, :count).by(1)
	end
	scenario "edits an existing user" do
		admin = create(:admin_user)
		user = create(:user)
		sign_in(admin)

		click_link 'Home'
		click_link 'Manage Users'

		within('tr', text: user.name) do
			click_link 'edit'
		end
		fill_in 'Email', with: "jimmy@gmail.com"
		fill_in 'Password', with: "foobar"
		fill_in 'Confirmation', with: "foobar"
		click_button 'Save Changes'

		expect(current_path).to eq users_path
		expect(page).to have_content 'jimmy@gmail.com'
	end
	scenario "deletes an existing user" do
		admin = create(:admin_user)
		user = create(:user)
		sign_in(admin)

		click_link 'Home'
		click_link 'Manage Users'
		expect{ 
			within('tr', text: user.name) do
				click_link 'delete'
			end}.to change(User, :count).by(-1)

		expect(current_path).to eq users_path
	end
	scenario "admin unsuccessfully attempts to delete itself" do
		admin = create(:admin_user)
		sign_in(admin)

		click_link 'Home'
		click_link 'Manage Users'
		expect{ 
			within('tr', text: admin.name) do
				click_link 'delete'
			end}.to_not change(User, :count)

		expect(current_path).to eq users_path
	end
end
