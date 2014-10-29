class Wheelchair < ActiveRecord::Base

	has_many :bookings, as: :bookable

	validates :manufacturer, presence: true
	validates :model_type, presence: true
	validates :width, presence: true
	validates :depth, presence: true
	validates :inventory_tag, presence: true
	validates :serial_number, presence: true





end
