class Other < ActiveRecord::Base

	has_many :bookings, as: :bookable

	validates :manufacturer, presence: true
	validates :description, presence: true
end
