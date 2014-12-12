require 'rails_helper'

RSpec.describe WheelchairsController, :type => :controller do

  before do
      @wheelchair1 = create(:wheelchair)
      @wheelchair2 = create(:wheelchair, manufacturer: "Invacare", width: 18)
      @wheelchair3 = create(:wheelchair, manufacturer: "Motion Composites", depth: 16)
    end

  context "with a logged in, non-admin user" do

    before { allow(controller).to receive(:current_user) { create(:user) } }

    describe "GET #index" do

      context "without search parameters" do
        it "will assign the @wheelchairs variable an array of all wheelchairs" do
          get :index
          expect(assigns(:wheelchairs)).to match_array([@wheelchair1, @wheelchair2, @wheelchair3]) 
        end
      end

      context "with search parameters" do
        it "will assign the @wheelchairs variable an array of chairs that meets the search criteria" do
          get :index, wheelchair_search: {manufacturer: ["Invacare", "Motion Composites"], width: ["16"], depth: ["16", "18"]}
          expect(assigns(:wheelchairs)).to match_array([@wheelchair3])
        end
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
        get :edit, id: @wheelchair1
        expect(response).to redirect_to root_path
      end
    end

    describe "POST #create" do
      it "will redirect to the home page" do
        post :create, wheelchair: attributes_for(:wheelchair)
        expect(response).to redirect_to root_path
      end
    end

    describe "PATCH #update" do

      it "will not update wheelchair attributes" do
        update = { manufacturer: "Invacare", id: @wheelchair1.id }
        patch :update, id: @wheelchair1, wheelchair: update
        @wheelchair1.reload
        expect(@wheelchair1.manufacturer).to eq("Pride")
      end

      it "will redirect to the home page" do
        update = { manufacturer: "Invacare", id: @wheelchair1.id }
        patch :update, id: @wheelchair1, wheelchair: update
        expect(response).to redirect_to root_path
      end
    end

    describe "DELETE #destroy" do

      it "will not delete the wheelchair" do
        delete :destroy, id: @wheelchair1
        expect(@wheelchair1.manufacturer).to eq("Pride")
      end

      it "will redirect to the home page" do
        delete :destroy, id: @wheelchair1
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
        get :edit, id: @wheelchair1
        expect(response).to redirect_to login_path
      end
    end

    describe "POST #create" do
      it "will redirect to the login page" do
        post :create, wheelchair: attributes_for(:wheelchair)
        expect(response).to redirect_to login_path
      end
    end

    describe "PATCH #update" do

      it "will not update wheelchair attributes" do
        update = { manufacturer: "Invacare", id: @wheelchair1.id }
        patch :update, id: @wheelchair1, wheelchair: update
        @wheelchair1.reload
        expect(@wheelchair1.manufacturer).to eq("Pride")
      end

      it "will redirect to the login page" do
        update = { manufacturer: "Invacare", id: @wheelchair1.id }
        patch :update, id: @wheelchair1, wheelchair: update
        expect(response).to redirect_to login_path
      end
    end

    describe "DELETE #destroy" do

      it "will not delete the wheelchair" do
        delete :destroy, id: @wheelchair1
        expect(@wheelchair1.manufacturer).to eq("Pride")
      end

      it "will redirect to the login page" do
        delete :destroy, id: @wheelchair1
        expect(response).to redirect_to login_path
      end
    end
  end

  context "with an admin user" do

    before { allow(controller).to receive(:current_user) { create(:admin_user) } }

    describe "GET #index" do

      context "without search parameters" do
        it "will assign the @wheelchairs variable an array of all wheelchairs" do
          get :index
          expect(assigns(:wheelchairs)).to match_array([@wheelchair1, @wheelchair2, @wheelchair3]) 
        end
      end

      context "with search parameters" do
        it "will assign the @wheelchairs variable an array of chairs that meets the search criteria" do
          get :index, wheelchair_search: {manufacturer: ["Invacare", "Motion Composites"], width: ["16"], depth: ["16", "18"]}
          expect(assigns(:wheelchairs)).to match_array([@wheelchair3])
        end
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
        it "saves the new wheelchair to the database" do
          expect {
          post :create, wheelchair: attributes_for(:wheelchair)
          }.to change(Wheelchair, :count).by(1)
        end
      end

      context "with invalid attributes" do

        it "doesn't save the wheelchair" do
          expect {
          post :create, wheelchair: attributes_for(:wheelchair, manufacturer: "")
          }.to_not change(Wheelchair, :count)
        end

        it "renders the new page again" do
          post :create, wheelchair: attributes_for(:wheelchair, manufacturer: "")
          expect(response).to render_template :new
        end
      end
    end

    describe "GET #edit" do
      it "renders the :edit template" do
        get :edit, id: @wheelchair1
        expect(response).to render_template :edit
      end
      it "assigns the correct wheelchair to the instance variable" do
        get :edit, id: @wheelchair1
        expect(assigns(:wheelchair)).to eq(@wheelchair1)
      end
    end

    describe "PATCH #update" do
      context "with valid attributes" do
        
        update = { manufacturer: "Invacare" }

        it "locates the requested @wheelchair" do
          patch :update, id: @wheelchair1, wheelchair: update
          expect(assigns(:wheelchair)).to eq(@wheelchair1)
        end
        it "saves the updated info to the database" do
          patch :update, id: @wheelchair1, wheelchair: update
          @wheelchair1.reload
          expect(@wheelchair1.manufacturer).to eq("Invacare")
        end
        it "redirects to the wheelchair index page" do
          patch :update, id: @wheelchair1, wheelchair: update
          expect(response).to redirect_to wheelchairs_path
        end
      end

      context "with invalid attributes" do
        
        update = { manufacturer: "Invacare", model_type: "" }

        it "saves the updated info to the database" do
          patch :update, id: @wheelchair1, wheelchair: update
          @wheelchair1.reload
          expect(@wheelchair1.manufacturer).to_not eq("Invacare")
          expect(@wheelchair1.model_type).to eq("Stylus")
        end
        it "re-renders the edit wheelchair page" do
          patch :update, id: @wheelchair1, wheelchair: update
          expect(response).to render_template :edit
        end
      end
    end

    describe "DELETE #destroy" do
      it "locates the requested wheelchair" do
        delete :destroy, id: @wheelchair1
        expect(assigns(:wheelchair)).to eq(@wheelchair1)
      end
      it "deletes the wheelchair" do
        expect{ delete :destroy, id: @wheelchair1
        }.to change(Wheelchair, :count).by(-1)
      end
      it "renders the wheelchair index page" do
        delete :destroy, id: @wheelchair1
        expect(response).to redirect_to wheelchairs_path
      end
    end
  end
end