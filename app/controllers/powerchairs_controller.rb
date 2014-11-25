class PowerchairsController < ApplicationController

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
		redirect_to new_powerchair_path
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

private

	def powerchair_params
		params.require(:powerchair).permit(:manufacturer, :model_type, :drive, :color, :inventory_tag, :serial_number)
	end

end