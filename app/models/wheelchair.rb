class Wheelchair < ActiveRecord::Base

	acts_as_tenant(:account)

	has_many :bookings, as: :bookable

	validates :manufacturer, presence: true
	validates :model_type, presence: true
	validates :width, presence: true
	validates :depth, presence: true
	validates :serial_number, presence: true

	def self.search(params_hash)
		key_array = []
		conditions_array = []
		count = 0
		params_hash.each do |key, array|
			key_array << (key + " in (?)")
			conditions_array << array
			count += 1
		end
		case count
		when 1
			@wheelchair = Wheelchair.where(key_array.join(" AND "), conditions_array[0])
		when 2
			@wheelchair = Wheelchair.where(key_array.join(" AND "), conditions_array[0], conditions_array[1])
		when 3
			@wheelchair = Wheelchair.where(key_array.join(" AND "), conditions_array[0], conditions_array[1], conditions_array[2])
		end
		@wheelchair
	end

end
