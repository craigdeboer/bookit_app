require 'rails_helper'

RSpec.describe OthersController, :type => :controller do

	before do
      @other1 = Other.create(manufacturer: "Evolution", model_type: "Xpresso", inventory_tag: "Evo Xpresso", description: "Evo Xpresso walker std")
      @other2 = Other.create(manufacturer: "Dana Douglas", model_type: "Nexus", inventory_tag: "DDM 4000512", description: "Nexus III walker low")
  end

context "with a logged in, non-admin user" do

    before { allow(controller).to receive(:current_user) { create(:user) } }

    describe "GET #index" do
      it "will assign the @others variable an array of all others" do
        get :index
        expect(assigns(:others)).to match_array([@other1, @other2]) 
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
        get :edit, id: @other1
        expect(response).to redirect_to root_path
      end
    end

    describe "POST #create" do
      it "will redirect to the home page" do
        post :create, other: {manufacturer: "Dana Douglas", model_type: "Nexus", inventory_tag: "DDM 4000512", description: "Nexus III walker low"}
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH #update" do

      it "will not update other attributes" do
        update = { manufacturer: "Invacare", id: @other1.id }
        patch :update, id: @other1, other: update
        @other1.reload
        expect(@other1.manufacturer).to eq("Evolution")
      end

      it "will redirect to the home page" do
        update = { manufacturer: "Invacare", id: @other1.id }
        patch :update, id: @other1, other: update
        expect(response).to redirect_to root_path
      end
    end

    describe "DELETE #destroy" do

      it "will not delete the other" do
        delete :destroy, id: @other1
        expect(@other1.manufacturer).to eq("Evolution")
      end

      it "will redirect to the home page" do
        delete :destroy, id: @other1
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
        get :edit, id: @other1
        expect(response).to redirect_to login_path
      end
    end

    describe "POST #create" do
      it "will redirect to the login page" do
        post :create, other: {manufacturer: "Dana Douglas", model_type: "Nexus", inventory_tag: "DDM 4000512", description: "Nexus III walker low"}
        expect(response).to redirect_to login_path
      end
    end

    describe "PATCH #update" do

      it "will not update other attributes" do
        update = { manufacturer: "Invacare", id: @other1.id }
        patch :update, id: @other1, other: update
        @other1.reload
        expect(@other1.manufacturer).to eq("Evolution")
      end

      it "will redirect to the login page" do
        update = { manufacturer: "Invacare", id: @other1.id }
        patch :update, id: @other1, other: update
        expect(response).to redirect_to login_path
      end
    end

    describe "DELETE #destroy" do

      it "will not delete the other" do
        delete :destroy, id: @other1
        expect(@other1.manufacturer).to eq("Evolution")
      end

      it "will redirect to the login page" do
        delete :destroy, id: @other1
        expect(response).to redirect_to login_path
      end
    end
  end

  context "with an admin user" do

    before { allow(controller).to receive(:current_user) { create(:admin_user) } }

    describe "GET #index" do 
      it "will assign the @other variable an array of all mattresses" do
        get :index
        expect(assigns(:others)).to match_array([@other1, @other2]) 
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
        it "saves the new other to the database" do
          expect {
          post :create, other: {manufacturer: "Dana Douglas", model_type: "Nexus", inventory_tag: "DDM 4000512", description: "Nexus III walker low"}
          }.to change(Other, :count).by(1)
        end
      end

      context "with invalid attributes" do

        it "doesn't save the other" do
          expect {
          post :create, other: {manufacturer: "", model_type: "Nexus", inventory_tag: "DDM 4000512", description: "Nexus III walker low"}
          }.to_not change(Other, :count)
        end

        it "renders the new page again" do
          post :create, other: {manufacturer: "", model_type: "Nexus", inventory_tag: "DDM 4000512", description: "Nexus III walker low"}
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      it "renders the :edit template" do
        get :edit, id: @other1
        expect(response).to render_template :edit
      end
      it "assigns the correct other to the instance variable" do
        get :edit, id: @other1
        expect(assigns(:other)).to eq(@other1)
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        
        update = { manufacturer: "Invacare" }

        it "locates the requested @other" do
          patch :update, id: @other1, other: update
          expect(assigns(:other)).to eq(@other1)
        end
        it "saves the updated info to the database" do
          patch :update, id: @other1, other: update
          @other1.reload
          expect(@other1.manufacturer).to eq("Invacare")
        end
        it "redirects to the other index page" do
          patch :update, id: @other1, other: update
          expect(response).to redirect_to others_path
        end
      end

      context "with invalid attributes" do
        
        update = { manufacturer: "Invacare", description: "" }

        it "saves the updated info to the database" do
          patch :update, id: @other1, other: update
          @other1.reload
          expect(@other1.manufacturer).to_not eq("Invacare")
          expect(@other1.description).to eq("Evo Xpresso walker std")
        end
        it "re-renders the edit other page" do
          patch :update, id: @other1, other: update
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "locates the requested other" do
        delete :destroy, id: @other1
        expect(assigns(:other)).to eq(@other1)
      end
      it "deletes the other" do
        expect{ delete :destroy, id: @other1
        }.to change(Other, :count).by(-1)
      end
      it "renders the other index page" do
        delete :destroy, id: @other1
        expect(response).to redirect_to others_path
      end
    end
  end

end
