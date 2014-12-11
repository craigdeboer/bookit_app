FactoryGirl.define do

	factory :booking do
		association :user
		association :bookable

		start_date Date.today
		end_date Date.today + 3
		user_id "1"
	end
end
