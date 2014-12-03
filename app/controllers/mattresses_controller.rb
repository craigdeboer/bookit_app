class MattressesController < ApplicationController

	before_action :require_login
  before_action :require_admin, only: [:new, :create, :edit, :destroy]

	def index
		@mattress = Mattress.all 
	end

	def new
		@mattress = Mattress.new
	end

	def create
		@mattress = Mattress.new(mattress_params)
		if @mattress.save
			flash[:success] = "#{@mattress.manufacturer} #{@mattress.model_type} was successfully added!"
			redirect_to mattresses_path
		else 
			render 'new'
		end
	end

	def edit
		@mattress = Mattress.find(params[:id])
	end

	def update
		@mattress = Mattress.find(params[:mattress][:id])
		if @mattress.update_attributes(mattress_params)
			flash[:success] = "#{@mattress.manufacturer} #{@mattress.model_type} was updated successfully."
			redirect_to mattress_path
		else
			render 'edit'
		end
	end

	def destroy
		mattress = Mattress.find(params[:id])
		flash[:success] = "#{mattress.manufacturer} #{mattress.model_type} has been deleted."
		mattress.destroy
		redirect_to mattress_path
	end

	private

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

		def mattress_params
			params.require(:mattress).permit(:manufacturer, :model_type, :size, :inventory_tag, :serial_number)
		end

end
