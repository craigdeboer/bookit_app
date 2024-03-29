class Mattress < ActiveRecord::Base

	acts_as_tenant(:account)

	has_many :bookings, as: :bookable

	validates :manufacturer, presence: true
	validates :model_type, presence: true
	validates :serial_number, presence: true
end
