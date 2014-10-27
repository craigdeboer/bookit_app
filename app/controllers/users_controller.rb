class UsersController < ApplicationController
  def index
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



end

