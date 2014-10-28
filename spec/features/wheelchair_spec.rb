require 'rails_helper'

describe "Wheelchair:" do

	describe "filling in the new wheelchair for with invalid data" do
		before { visit new_wheelchair_path }
		it "should not add a wheelchair to the database" do
			expect{ click_button "Add Wheelchair" }.not_to change{Wheelchair.count}
		end
		it "should re-render the new wheelchair form" do
			click_button "Add Wheelchair"
			expect(page).to have_selector('h1', "This is the the new wheelchair form")
		end
	end
	
	describe "filling in the new wheelchair form with valid data" do
		before do
			visit new_wheelchair_path
			fill_in "Manufacturer", with: "Sunrise"
			fill_in "Model", with: "Quickie 2"
			fill_in "Width", with: "18"
			fill_in "Depth", with: "16"
			fill_in "Color", with: "Black"
			fill_in "Inventory tag", with: "Sun Q2"
			fill_in "Serial number", with: "Q2-125410"
		end
		it "should add a wheelchair to the database" do
			expect{ click_button "Add Wheelchair" }.to change{Wheelchair.count}.by(1)
		end
	end
end