require 'rails_helper'

RSpec.describe MattressesController, :type => :controller do

  before do
    @mattress1 = Mattress.create(manufacturer: "BFF", model_type: "LTC4000", size: "36x80", inventory_tag: "BFF LTC4000", serial_number: "5428154")
    @mattress2 = Mattress.create(manufacturer: "KCI", model_type: "Visio", size: "36x80", inventory_tag: "kci visio", serial_number: "kci-251")
  end

  context "with a logged in, non-admin user" do

      before { allow(controller).to receive(:current_user) { create(:user) } }

      describe "GET #index" do
        it "will assign the @mattress variable an array of all mattresses" do
          get :index
          expect(assigns(:mattress)).to match_array([@mattress1, @mattress2]) 
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
          get :edit, id: @mattress1
          expect(response).to redirect_to root_path
        end
      end

      describe "POST #create" do
        it "will redirect to the home page" do
          hash = {manufacturer: "BFF", model_type: "LTC", size: "36x80", inventory_tag: "ppp", serial_number: "dfafd"}
          post :create, mattress: hash
          expect(response).to redirect_to root_path
        end
      end

      describe "PATCH #update" do

        it "will not update mattress attributes" do
          update = { manufacturer: "KCI", id: @mattress1.id }
          patch :update, id: @mattress1, mattress: update
          @mattress1.reload
          expect(@mattress1.manufacturer).to eq("BFF")
        end

        it "will redirect to the home page" do
          update = { manufacturer: "KCI", id: @mattress1.id }
          patch :update, id: @mattress1, mattress: update
          expect(response).to redirect_to root_path
        end
      end

      describe "DELETE #destroy" do

        it "will not delete the mattress" do
          delete :destroy, id: @mattress1
          expect(@mattress1.manufacturer).to eq("BFF")
        end

        it "will redirect to the home page" do
          delete :destroy, id: @mattress1
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
          get :edit, id: @mattress1
          expect(response).to redirect_to login_path
        end
      end

      describe "POST #create" do
        it "will redirect to the login page" do
          hash = {manufacturer: "BFF", model_type: "LTC", size: "36x80", inventory_tag: "ppp", serial_number: "dfafd"}
          post :create, mattress: hash
          expect(response).to redirect_to login_path
        end
      end

      describe "PATCH #update" do

        it "will not update mattress attributes" do
          update = { manufacturer: "KCI", id: @mattress1.id }
          patch :update, id: @mattress1, mattress: update
          @mattress1.reload
          expect(@mattress1.manufacturer).to eq("BFF")
        end

        it "will redirect to the login page" do
          update = { manufacturer: "KCI", id: @mattress1.id }
          patch :update, id: @mattress1, mattress: update
          expect(response).to redirect_to login_path
        end
      end

      describe "DELETE #destroy" do

        it "will not delete the mattress" do
          delete :destroy, id: @mattress1
          expect(@mattress1.manufacturer).to eq("BFF")
        end

        it "will redirect to the login page" do
          delete :destroy, id: @mattress1
          expect(response).to redirect_to login_path
        end
      end
    end

    context "with an admin user" do

      before { allow(controller).to receive(:current_user) { create(:admin_user) } }

      describe "GET #index" do 
        it "will assign the @mattress variable an array of all mattresses" do
          get :index
          expect(assigns(:mattress)).to match_array([@mattress1, @mattress2]) 
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
          it "saves the new mattress to the database" do
          	hash = {manufacturer: "BFF", model_type: "LTC", size: "36x80", inventory_tag: "ppp", serial_number: "dfafd"}
            expect {
            post :create, mattress: hash
            }.to change(Mattress, :count).by(1)
          end
        end

        context "with invalid attributes" do
          hash = {manufacturer: "", model_type: "", size: "36x80", inventory_tag: "ppp", serial_number: "dfafd"}

          it "doesn't save the mattress" do
            expect {
            post :create, mattress: hash
            }.to_not change(Mattress, :count)
          end

          it "renders the new page again" do
            post :create, mattress: hash
            expect(response).to render_template :new
          end
        end
      end

      describe "GET #edit" do
        it "renders the :edit template" do
          get :edit, id: @mattress1
          expect(response).to render_template :edit
        end
        it "assigns the correct mattress to the instance variable" do
          get :edit, id: @mattress1
          expect(assigns(:mattress)).to eq(@mattress1)
        end
      end

      describe "PATCH #update" do
        context "with valid attributes" do
          
          update = { manufacturer: "KCI" }

          it "locates the requested @mattress" do
            patch :update, id: @mattress1, mattress: update
            expect(assigns(:mattress)).to eq(@mattress1)
          end
          it "saves the updated info to the database" do
            patch :update, id: @mattress1, mattress: update
            @mattress1.reload
            expect(@mattress1.manufacturer).to eq("KCI")
          end
          it "redirects to the mattress index page" do
            patch :update, id: @mattress1, mattress: update
            expect(response).to render_template :index
          end
        end

        context "with invalid attributes" do
          
          update = { manufacturer: "KCI", model_type: "" }

          it "saves the updated info to the database" do
            patch :update, id: @mattress1, mattress: update
            @mattress1.reload
            expect(@mattress1.manufacturer).to_not eq("KCI")
            expect(@mattress1.model_type).to eq("LTC4000")
          end
          it "re-renders the edit mattress page" do
            patch :update, id: @mattress1, mattress: update
            expect(response).to render_template :edit
          end
        end
      end

      describe "DELETE #destroy" do
        it "locates the requested mattress" do
          delete :destroy, id: @mattress1
          expect(assigns(:mattress)).to eq(@mattress1)
        end
        it "deletes the mattress" do
          expect{ delete :destroy, id: @mattress1
          }.to change(Mattress, :count).by(-1)
        end
        it "renders the mattress index page" do
          delete :destroy, id: @mattress1
          expect(response).to render_template 'index'
        end
      end
    end
end
