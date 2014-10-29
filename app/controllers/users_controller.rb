class UsersController < ApplicationController

  before_action :require_login
  before_action :require_admin, only: [:index, :create, :edit, :destroy]

  def index
    
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New user, #{@user.name}, was successfully created."
      redirect_to "/"
    else 
      render 'new'
    end
  end

  def edit
  end

  def destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :initials, :email, :password, :password_confirmation)
    end

    def require_login
      unless logged_in?
        flash[:info] = "You must be logged in to visit this page. Please log in."
        redirect_to login_path
      end
    end

    def require_admin
      unless admin?
        flash[:info] = "You must have administration priviledges to access the page you requested"
        if logged_in?
          redirect_to current_user
        else
          redirect_to login_path
        end
      end
    end

end

