class MattressesController < ApplicationController

	before_action :require_login
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

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
		@mattress = Mattress.find(params[:id])
		if @mattress.update_attributes(mattress_params)
			flash[:success] = "#{@mattress.manufacturer} #{@mattress.model_type} was updated successfully."
			render 'index'
		else
			render 'edit'
		end
	end

	def destroy
		@mattress = Mattress.find(params[:id])
		flash[:success] = "#{@mattress.manufacturer} #{@mattress.model_type} has been deleted."
		@mattress.destroy
		render 'index'
	end

	private

		def mattress_params
			params.require(:mattress).permit(:manufacturer, :model_type, :size, :inventory_tag, :serial_number)
		end

end
