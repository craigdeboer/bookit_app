class UsersController < ApplicationController

  before_action :require_login
  before_action :require_admin, only: [:index, :new, :create, :edit, :destroy]

  def index
    @user = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "New user, #{@user.name}, was successfully created."
      redirect_to users_path
    else 
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.name} has been edited."
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    name = @user.name
    if @user == current_user
      flash[:notice] = "You can't delete yourself."
    else 
      @user.destroy
      flash[:success] = "#{name} has been deleted."
    end
    redirect_to users_path
  end

  private

    def user_params
      params[:user].delete :admin unless current_user.try(:admin?)
      params.require(:user).permit(:name, :initials, :email, :password, :password_confirmation, :admin)
    end
end

