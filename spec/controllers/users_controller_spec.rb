require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "if current_user is admin" do
  	before do
		allow(controller).to receive(:current_user) { User.create(name: "Craig Deboer", initials: "CRD", email: "craig@gim.com", password: "foobar", password_confirmation: "foobar", admin: true) } 
		end
		describe "GET index" do
    	it "returns http success" do
      	get :index
    		expect(response).to have_http_status(:success)
   		end
   	end
   	describe "GET new" do
    	it "returns http success" do
      	get :new
    		expect(response).to have_http_status(:success)
   		end
   	end
  end

  describe "if current_user is non-admin" do
  	before do
		allow(controller).to receive(:current_user) { User.create(name: "Craig Deboer", initials: "CRD", email: "craig@gim.com", password: "foobar", password_confirmation: "foobar") } 
		end
		describe "GET index" do
	    it "redirects to home page" do
	    	get :index
	    	expect(response.status).to eq(302)
	   	end
 		end
 	end



end
