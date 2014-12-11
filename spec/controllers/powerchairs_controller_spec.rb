require 'rails_helper'

RSpec.describe PowerchairsController, :type => :controller do

  before do
      @powerchair1 = create(:powerchair)
      @powerchair2 = create(:powerchair)
    end

    context "with a logged in, non-admin user" do

        before { allow(controller).to receive(:current_user) { create(:user) } }

        describe "GET #index" do
          it "will assign the @powerchairs variable an array of all powerchairs" do
            get :index
            expect(assigns(:powerchairs)).to match_array([@powerchair1, @powerchair2]) 
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
            get :edit, id: @powerchair1
            expect(response).to redirect_to root_path
          end
        end

        describe "POST #create" do
          it "will redirect to the home page" do
            post :create, powerchair: attributes_for(:powerchair)
            expect(response).to redirect_to root_path
          end
        end

        describe "PATCH #update" do

          it "will not update powerchair attributes" do
            update = { manufacturer: "Invacare", id: @powerchair1.id }
            patch :update, id: @powerchair1, powerchair: update
            @powerchair1.reload
            expect(@powerchair1.manufacturer).to eq("Pride")
          end

          it "will redirect to the home page" do
            update = { manufacturer: "Invacare", id: @powerchair1.id }
            patch :update, id: @powerchair1, powerchair: update
            expect(response).to redirect_to root_path
          end
        end

        describe "DELETE #destroy" do

          it "will not delete the powerchair" do
            delete :destroy, id: @powerchair1
            expect(@powerchair1.manufacturer).to eq("Pride")
          end

          it "will redirect to the home page" do
            delete :destroy, id: @powerchair1
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
            get :edit, id: @powerchair1
            expect(response).to redirect_to login_path
          end
        end

        describe "POST #create" do
          it "will redirect to the login page" do
            post :create, powerchair: attributes_for(:powerchair)
            expect(response).to redirect_to login_path
          end
        end

        describe "PATCH #update" do

          it "will not update powerchair attributes" do
            update = { manufacturer: "Invacare", id: @powerchair1.id }
            patch :update, id: @powerchair1, powerchair: update
            @powerchair1.reload
            expect(@powerchair1.manufacturer).to eq("Pride")
          end

          it "will redirect to the login page" do
            update = { manufacturer: "Invacare", id: @powerchair1.id }
            patch :update, id: @powerchair1, powerchair: update
            expect(response).to redirect_to login_path
          end
        end

        describe "DELETE #destroy" do

          it "will not delete the powerchair" do
            delete :destroy, id: @powerchair1
            expect(@powerchair1.manufacturer).to eq("Pride")
          end

          it "will redirect to the login page" do
            delete :destroy, id: @powerchair1
            expect(response).to redirect_to login_path
          end
        end
      end

      context "with an admin user" do

        before { allow(controller).to receive(:current_user) { create(:admin_user) } }

        describe "GET #index" do 
          it "will assign the @powerchair variable an array of all mattresses" do
            get :index
            expect(assigns(:powerchairs)).to match_array([@powerchair1, @powerchair2]) 
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
            it "saves the new powerchair to the database" do
              expect {
              post :create, powerchair: attributes_for(:powerchair)
              }.to change(Powerchair, :count).by(1)
            end
          end

          context "with invalid attributes" do

            it "doesn't save the powerchair" do
              expect {
              post :create, powerchair: attributes_for(:powerchair, manufacturer: "")
              }.to_not change(Powerchair, :count)
            end

            it "renders the new page again" do
              post :create, powerchair: attributes_for(:powerchair, manufacturer: "")
              expect(response).to render_template :new
            end
          end
        end

        describe "GET #edit" do
          it "renders the :edit template" do
            get :edit, id: @powerchair1
            expect(response).to render_template :edit
          end
          it "assigns the correct powerchair to the instance variable" do
            get :edit, id: @powerchair1
            expect(assigns(:powerchair)).to eq(@powerchair1)
          end
        end

        describe "PATCH #update" do
          context "with valid attributes" do
            
            update = { manufacturer: "Invacare" }

            it "locates the requested @powerchair" do
              patch :update, id: @powerchair1, powerchair: update
              expect(assigns(:powerchair)).to eq(@powerchair1)
            end
            it "saves the updated info to the database" do
              patch :update, id: @powerchair1, powerchair: update
              @powerchair1.reload
              expect(@powerchair1.manufacturer).to eq("Invacare")
            end
            it "redirects to the powerchair index page" do
              patch :update, id: @powerchair1, powerchair: update
              expect(response).to render_template :index
            end
          end

          context "with invalid attributes" do
            
            update = { manufacturer: "Invacare", model_type: "" }

            it "saves the updated info to the database" do
              patch :update, id: @powerchair1, powerchair: update
              @powerchair1.reload
              expect(@powerchair1.manufacturer).to_not eq("Invacare")
              expect(@powerchair1.model_type).to eq("Q6 Edge")
            end
            it "re-renders the edit powerchair page" do
              patch :update, id: @powerchair1, powerchair: update
              expect(response).to render_template :edit
            end
          end
        end

        describe "DELETE #destroy" do
          it "locates the requested powerchair" do
            delete :destroy, id: @powerchair1
            expect(assigns(:powerchair)).to eq(@powerchair1)
          end
          it "deletes the powerchair" do
            expect{ delete :destroy, id: @powerchair1
            }.to change(Powerchair, :count).by(-1)
          end
          it "renders the powerchair index page" do
            delete :destroy, id: @powerchair1
            expect(response).to render_template 'index'
          end
        end
      end
end