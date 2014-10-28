class Wheelchair < ActiveRecord::Base
	validates :manufacturer, presence: true
	validates :model, presence: true
	validates :width, presence: true
	validates :depth, presence: true
	validates :inventory_tag, presence: true
	validates :serial_number, presence: true



end
