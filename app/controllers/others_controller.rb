class OthersController < ApplicationController

	before_action :require_login
  before_action :require_admin, only: [:new, :create, :update, :edit, :destroy]

	def index
		@others = Other.all 
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
		@other = Other.find(params[:id])
		if @other.update_attributes(other_params)
			flash[:success] = "#{@other.manufacturer} #{@other.model_type} was updated successfully."
			render 'index'
		else
			render 'edit'
		end
	end

	def destroy
		@other = Other.find(params[:id])
		flash[:success] = "#{@other.manufacturer} #{@other.model_type} has been deleted."
		@other.destroy
		render 'index'
	end

	private

		def other_params
			params.require(:other).permit(:manufacturer, :model_type, :inventory_tag, :description)
		end

end
