namespace :db do
	desc "Populate database with accounts and admin user for each account"

	task accounts: :environment do

		100.times do |n|
			account = Account.create!(name: "Placeholder",
								 subdomain: "Placeholder",
								 user_limit: 5)

			ActsAsTenant.current_tenant = account
			
			User.create!(name: "Gerald Scott",
									 initials: "GSS",
									 email: "gerald@gmail.com",
									 password: "ducky1",
									 password_confirmation: "ducky1",
									 admin: true)
		end
	end
end