require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  describe "GET #index" do

    before do
      @smith = create(:user, name: "Sam Smith")
      @jones = create(:user, name: "Jake Jones")
      @admin = create(:admin_user)
    end

    context "with logged in admin user" do

      # You can either use the allow statement or create the user and then assign the session variable manually to simulate a logged in user.
      before do 
        # session[:user_id] = @admin.id
        allow(controller).to receive(:current_user) { @admin }
      end

      it "populates an array of all users" do      
        get :index
        expect(assigns(:user)).to match_array([@smith, @jones, @admin])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end

    context "with logged in non-admin user" do

      before { allow(controller).to receive(:current_user) { @smith } }

      it "redirects to the home page (static_pages#home)" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context "when not logged in" do

      it "redirects to the log in page (sessions#new)" do
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET #new" do

    before do
      @admin = create(:admin_user)
    end

    context "with logged in admin user" do
      before { allow(controller).to receive(:current_user) { @admin } }

      it "assigns a new user to @user" do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    context "with logged in non-admin user" do
      before do
        @admin.admin = false
        allow(controller).to receive(:current_user) { @admin }
      end

      it "redirects to the home page (static_pages#home)" do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    context "when not logged in" do
      it "redirects to the log in page (sessions#new)" do
        get :new
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST #create" do  

    before do
      admin = create(:admin_user)
      allow(controller).to receive(:current_user) { admin }
    end  

    context "with valid attributes" do

      it "saves the new user to the database" do
        expect {
        post :create, user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to users#index" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to users_path
      end
    end

    context "with invalid attributes" do

      it "saves the new user to the database" do
        expect {
        post :create, user: attributes_for(:invalid)
        }.to_not change(User, :count)
      end

      it "redirects to users#index" do
        post :create, user: attributes_for(:invalid)
        expect(response).to render_template :new
      end
    end


  end

end
