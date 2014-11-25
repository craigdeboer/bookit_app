class ScootersController < ApplicationController

	def index
		@scooter = Scooter.all 
	end

	def new
		@scooter = Scooter.new
	end

	def create
		@scooter = Scooter.new(scooter_params)
		if @scooter.save
			flash[:success] = "#{@scooter.manufacturer} #{@scooter.model_type} was successfully added!"
			redirect_to new_scooter_path
		else 
			render 'new'
		end
	end

	def edit
		@scooter = Scooter.find(params[:id])
	end

	def update
		@scooter = Scooter.find(params[:scooter][:id])
		if @scooter.update_attributes(scooter_params)
			flash[:success] = "#{@scooter.manufacturer} #{@scooter.model_type} was updated successfully."
			redirect_to scooters_path
		else
			render 'edit'
		end
	end

	def destroy
		scooter = Scooter.find(params[:id])
		flash[:success] = "#{scooter.manufacturer} #{scooter.model_type} has been deleted."
		scooter.destroy
		redirect_to scooters_path
	end

	private

		def scooter_params
			params.require(:scooter).permit(:manufacturer, :model_type, :wheels, :color, :inventory_tag, :serial_number)
		end

end
