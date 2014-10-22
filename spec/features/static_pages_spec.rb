require 'rails_helper'

	describe "Home page" do

		it "should have correct title" do
		  visit "/"

		  expect(page).to have_text("Welcome to the Bookit App")
		end
	end

