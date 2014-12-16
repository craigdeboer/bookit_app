require 'rails_helper'

feature "Wheelchair management" do
	scenario "adds a new wheelchair" do
		admin = create(:admin_user)
		sign_in(admin)
		visit root_path
		click_link "Manage Equipment"
		click_link "Manage Manual Wheelchairs"
		expect(current_path).to eq wheelchairs_path

		click_link "Add New Wheelchair"
		fill_in 'Manufacturer', with: "Invacare"
		fill_in 'Model', with: "Myon"
		fill_in 'Width', with: "18"
		fill_in 'Depth', with: "16"
		fill_in 'Color', with: "Blue"
		fill_in 'Inventory tag', with: "Inv myon"
		fill_in 'Serial number', with: "Inv-25142"
		expect{ click_button "Add Wheelchair"}.to change(Wheelchair, :count).by(1)
	end
	scenario "edits an existing wheelchair" do
		3.times {create(:wheelchair)}
		admin = create(:admin_user)
		sign_in(admin)
		visit root_path
		click_link "Manage Equipment"
		click_link "Manage Manual Wheelchairs"
		expect(current_path).to eq wheelchairs_path
		within("tr", text: "Pri-2") do
			click_link "edit"
		end
		fill_in "Manufacturer", with: "Ranger"
		click_button "Save Changes"
		expect(page).to have_content "Ranger"
	end
	scenario "deletes an existing wheelchair" do
		3.times {create(:wheelchair)}
		admin = create(:admin_user)
		sign_in(admin)
		visit root_path
		click_link "Manage Equipment"
		click_link "Manage Manual Wheelchairs"
		expect(current_path).to eq wheelchairs_path

		expect{within("tr", text: "Pri-4") do
			click_link "delete"
		end}.to change(Wheelchair, :count).by(-1)
		expect(page).to_not have_content "Pri-4"
		
	end
end
