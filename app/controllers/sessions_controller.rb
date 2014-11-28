class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_name(session_params[:name])
  	if user && user.authenticate(session_params[:password])
  		log_in user
      remember user
  		redirect_to user_bookings_path(current_user.id)
  	else
  		flash.now[:danger] = "Invalid Name/Password combination"
  		render 'new'
  	end
  end

  def destroy
    log_out
  	redirect_to '/'
  end


  private

  	def session_params
  		params.require(:session).permit(:name, :password)
  	end
    
end
