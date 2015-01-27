namespace :db do
	desc "Fill database with sample data"

	task superuser: :environment do

		account = Account.create!(name: "Craig",
								 subdomain: "admin",
								 user_limit: 5)

		ActsAsTenant.current_tenant = account


		User.create!(name: "Craig Deboer",
								 initials: "CRD",
								 email: "craig@cdeboer.net",
								 password: "foobar",
								 password_confirmation: "foobar",
								 admin: true)
	end
end