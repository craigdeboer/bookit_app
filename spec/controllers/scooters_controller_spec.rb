require 'rails_helper'

RSpec.describe ScootersController, :type => :controller do

  before do
      @scooter1 = create(:scooter)
      @scooter2 = create(:scooter)
    end

	context "with a logged in, non-admin user" do

    before { allow(controller).to receive(:current_user) { create(:user) } }

    describe "GET #index" do
      it "will assign the @scooters variable an array of all scooters" do
        get :index
        expect(assigns(:scooters)).to match_array([@scooter1, @scooter2]) 
      end
    end

    describe "GET #new" do
      it "will redirect to the home page" do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #edit" do
      it "will redirect to the home page" do
        get :edit, id: @scooter1
        expect(response).to redirect_to root_path
      end
    end

    describe "POST #create" do
      it "will redirect to the home page" do
        post :create, scooter: attributes_for(:scooter)
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH #update" do

      it "will not update scooter attributes" do
        update = { manufacturer: "Pride", id: @scooter1.id }
        patch :update, id: @scooter1, scooter: update
        @scooter1.reload
        expect(@scooter1.manufacturer).to eq("Invacare")
      end

      it "will redirect to the home page" do
        update = { manufacturer: "Pride", id: @scooter1.id }
        patch :update, id: @scooter1, scooter: update
        expect(response).to redirect_to root_path
      end
    end

    describe "DELETE #destroy" do

      it "will not delete the scooter" do
        delete :destroy, id: @scooter1
        expect(@scooter1.manufacturer).to eq("Invacare")
      end

      it "will redirect to the home page" do
        delete :destroy, id: @scooter1
        expect(response).to redirect_to root_path
      end
    end
  end

  context "when not logged in" do

    describe "GET #index" do
      it "will redirect to the login page" do
        get :index
        expect(response).to redirect_to login_path 
      end
    end

    describe "GET #new" do
      it "will redirect to the login page" do
        get :new
        expect(response).to redirect_to login_path 
      end
    end

    describe "GET #edit" do
      it "will redirect to the login page" do
        get :edit, id: @scooter1
        expect(response).to redirect_to login_path
      end
    end

    describe "POST #create" do
      it "will redirect to the login page" do
        post :create, scooter: attributes_for(:scooter)
        expect(response).to redirect_to login_path
      end
    end

    describe "PATCH #update" do

      it "will not update scooter attributes" do
        update = { manufacturer: "Pride", id: @scooter1.id }
        patch :update, id: @scooter1, scooter: update
        @scooter1.reload
        expect(@scooter1.manufacturer).to eq("Invacare")
      end

      it "will redirect to the login page" do
        update = { manufacturer: "Pride", id: @scooter1.id }
        patch :update, id: @scooter1, scooter: update
        expect(response).to redirect_to login_path
      end
    end

    describe "DELETE #destroy" do

      it "will not delete the scooter" do
        delete :destroy, id: @scooter1
        expect(@scooter1.manufacturer).to eq("Invacare")
      end

      it "will redirect to the login page" do
        delete :destroy, id: @scooter1
        expect(response).to redirect_to login_path
      end
    end
  end

  context "with an admin user" do

    before { allow(controller).to receive(:current_user) { create(:admin_user) } }

    describe "GET #index" do 
      it "will assign the @scooter variable an array of all mattresses" do
        get :index
        expect(assigns(:scooters)).to match_array([@scooter1, @scooter2]) 
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    describe "GET #new" do
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do  

      context "with valid attributes" do
        it "saves the new scooter to the database" do
          expect {
          post :create, scooter: attributes_for(:scooter)
          }.to change(Scooter, :count).by(1)
        end
      end

      context "with invalid attributes" do

        it "doesn't save the scooter" do
          expect {
          post :create, scooter: attributes_for(:scooter, manufacturer: "")
          }.to_not change(Scooter, :count)
        end

        it "renders the new page again" do
          post :create, scooter: attributes_for(:scooter, manufacturer: "")
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      it "renders the :edit template" do
        get :edit, id: @scooter1
        expect(response).to render_template :edit
      end
      it "assigns the correct scooter to the instance variable" do
        get :edit, id: @scooter1
        expect(assigns(:scooter)).to eq(@scooter1)
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        
        update = { manufacturer: "Pride" }

        it "locates the requested @scooter" do
          patch :update, id: @scooter1, scooter: update
          expect(assigns(:scooter)).to eq(@scooter1)
        end
        it "saves the updated info to the database" do
          patch :update, id: @scooter1, scooter: update
          @scooter1.reload
          expect(@scooter1.manufacturer).to eq("Pride")
        end
        it "redirects to the scooter index page" do
          patch :update, id: @scooter1, scooter: update
          expect(response).to redirect_to scooters_path
        end
      end

      context "with invalid attributes" do
        
        update = { manufacturer: "Pride", model_type: "" }

        it "saves the updated info to the database" do
          patch :update, id: @scooter1, scooter: update
          @scooter1.reload
          expect(@scooter1.manufacturer).to_not eq("Pride")
          expect(@scooter1.model_type).to eq("Pegasus")
        end
        it "re-renders the edit scooter page" do
          patch :update, id: @scooter1, scooter: update
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "locates the requested scooter" do
        delete :destroy, id: @scooter1
        expect(assigns(:scooter)).to eq(@scooter1)
      end
      it "deletes the scooter" do
        expect{ delete :destroy, id: @scooter1
        }.to change(Scooter, :count).by(-1)
      end
      it "renders the scooter index page" do
        delete :destroy, id: @scooter1
        expect(response).to redirect_to scooters_path
      end
    end
  end
end
