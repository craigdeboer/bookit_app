class PowerchairsController < ApplicationController

require 'roo'

before_action :require_login
before_action :require_admin, only: [:new, :create, :edit, :destroy]

def index
	@powerchair = Powerchair.all 
end

def new
		@powerchair = Powerchair.new
	end

def create
	@powerchair = Powerchair.new(powerchair_params)
	if @powerchair.save
		flash[:success] = "#{@powerchair.manufacturer} #{@powerchair.model_type} was successfully added!"
		redirect_to powerchairs_path
	else 
		render 'new'
	end
end

def edit
		@powerchair = Powerchair.find(params[:id])
	end

	def update
		@powerchair = Powerchair.find(params[:powerchair][:id])
		if @powerchair.update_attributes(powerchair_params)
			flash[:success] = "#{@powerchair.manufacturer} #{@powerchair.model_type} was updated successfully."
			redirect_to powerchairs_path
		else
			render 'edit'
		end
	end

def destroy
		powerchair = Powerchair.find(params[:id])
		flash[:success] = "#{powerchair.manufacturer} #{powerchair.model_type} has been deleted."
		powerchair.destroy
		redirect_to powerchairs_path
	end

def import
	Powerchair.import(params[:file])
	flash[:success] = "Products imported."
  redirect_to powerchairs_path 
end

private

	def powerchair_params
		params.require(:powerchair).permit(:manufacturer, :model_type, :drive, :color, :inventory_tag, :serial_number)
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