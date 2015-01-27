class AccountsController < ApplicationController

	before_action :require_superadmin

	def index
		@accounts = Account.all
	end

	def new
		@account = Account.new
	end

	def create
		@account = Account.new(account_params)
		if @account.save
			flash[:success] = "New account, #{@account.name}, was successfully created."
      redirect_to accounts_path
    else 
      render 'new'
    end
	end

	def edit
		@account = Account.find(params[:id])
	end	

	def update
		@account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = "#{@account.name} has been edited."
      redirect_to accounts_path
    else
      render 'edit'
    end
	end

	def destroy
		@account = Account.find(params[:id])
    @account.destroy
    flash[:success] = "Account has been deleted."
    redirect_to accounts_path
	end

	private

		def account_params
      params.require(:account).permit(:name, :subdomain, :user_limit)
    end

end