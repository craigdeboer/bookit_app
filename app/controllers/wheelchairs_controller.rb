class WheelchairsController < ApplicationController

	def index
		@wheelchair = Wheelchair.all
	end

	def new
		@wheelchair = Wheelchair.new
	end

	def create
		@wheelchair = Wheelchair.new(wheelchair_params)
		if @wheelchair.save
			flash[:success] = "#{@wheelchair.manufacturer} #{@wheelchair.model} was successfully added!"
			redirect_to new_wheelchair_path
		else 
			render 'new'
		end
	end

	def edit
		@wheelchair = Wheelchair.find(params[:id])
	end

	def update
		@wheelchair = Wheelchair.find(params[:wheelchair][:id])
		if @wheelchair.update_attributes(wheelchair_params)
			flash[:success] = "#{@wheelchair.manufacturer} #{@wheelchair.model} was updated successfully."
			redirect_to wheelchairs_path
		else
			render 'edit'
		end
	end

	def destroy
		wheelchair = Wheelchair.find(params[:id])
		flash[:success] = "#{wheelchair.manufacturer} #{wheelchair.model} has been deleted."
		wheelchair.destroy
		redirect_to wheelchairs_path
	end

	private

		def wheelchair_params
			params.require(:wheelchair).permit(:manufacturer, :model_type, :width, :depth, :color, :inventory_tag, :serial_number)
		end


end