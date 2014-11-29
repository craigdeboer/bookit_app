class Mattress < ActiveRecord::Base

	has_many :bookings, as: :bookable

	validates :manufacturer, presence: true
	validates :model_type, presence: true
	validates :size, presence: true
	validates :inventory_tag, presence: true
	validates :serial_number, presence: true
end