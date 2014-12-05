FactoryGirl.define do

	factory :admin_user do
		name "Peter Puck"
		initials "PPP"
		email "peter@gmail.com"
		password "foobar"
		password_confirmation "foobar"
		admin true
	end

	factory :user do
		name { Faker::Name.name }
		initials { Faker::Lorem.characters(3) }
		email { Faker::Internet.email }
		password "foobar"
		password_confirmation "foobar"
	end

end
