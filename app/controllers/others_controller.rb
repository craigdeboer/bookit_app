class OthersController < ApplicationController

	before_action :require_login
  before_action :require_admin, only: [:new, :create, :edit, :destroy]

	def index
		@other = Other.all 
	end

	def new
		@other = Other.new
	end

	def create
		@other = Other.new(other_params)
		if @other.save
			flash[:success] = "#{@other.manufacturer} #{@other.model_type} was successfully added!"
			redirect_to others_path
		else 
			render 'new'
		end
	end

	def edit
		@other = Other.find(params[:id])
	end

	def update
		@other = Other.find(params[:other][:id])
		if @other.update_attributes(other_params)
			flash[:success] = "#{@other.manufacturer} #{@other.model_type} was updated successfully."
			redirect_to others_path
		else
			render 'edit'
		end
	end

	def destroy
		other = Other.find(params[:id])
		flash[:success] = "#{other.manufacturer} #{other.model_type} has been deleted."
		other.destroy
		redirect_to others_path
	end

	private

		def other_params
			params.require(:other).permit(:manufacturer, :model_type, :inventory_tag, :description)
		end

		def require_login
      unless logged_in?
        flash[:info] = "You must be logged in to visit this page. Please log in."
        redirect_to login_path
      end
    end

    def require_admin
      unless admin?
        flash[:info] = "You must have administration privileges to access the page you requested"
        if logged_in?
          redirect_to root_path
        else
          redirect_to login_path
        end
      end
    end
end
