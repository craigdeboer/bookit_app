FactoryGirl.define do

	factory :user do
		name { Faker::Name.name }
		initials { Faker::Lorem.characters(3) }
		email { Faker::Internet.email }
		password "foobar"
		password_confirmation "foobar"

		factory :admin_user do
			admin true
		end

		factory :invalid do
			name nil
		end
	end
end
