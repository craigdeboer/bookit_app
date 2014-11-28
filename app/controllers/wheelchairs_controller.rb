class WheelchairsController < ApplicationController

	def index
		if params[:wheelchair_search]
		# @wheelchair = Wheelchair.where("model_type in (?) AND width in (?) AND depth in (?)", ["Breezy 600", "Myon"], [16, 18])

			@wheelchair = search_prep(params[:wheelchair_search], "wheelchair")		
			# render 'index'
		else
			@wheelchair = Wheelchair.all #if there are no search params then show all wheelchairs
		end
	end

	def show
		@wheelchair = Wheelchair.find(params[:id])
	end

	def new
		@wheelchair = Wheelchair.new
	end

	def create
		@wheelchair = Wheelchair.new(wheelchair_params)
		if @wheelchair.save
			flash[:success] = "#{@wheelchair.manufacturer} #{@wheelchair.model_type} was successfully added!"
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
			flash[:success] = "#{@wheelchair.manufacturer} #{@wheelchair.model_type} was updated successfully."
			redirect_to wheelchairs_path
		else
			render 'edit'
		end
	end

	def destroy
		wheelchair = Wheelchair.find(params[:id])
		flash[:success] = "#{wheelchair.manufacturer} #{wheelchair.model_type} has been deleted."
		wheelchair.destroy
		redirect_to wheelchairs_path
	end

	def search
	end

	private

		def wheelchair_params
			params.require(:wheelchair).permit(:manufacturer, :model_type, :width, :depth, :color, :inventory_tag, :serial_number)
		end


end