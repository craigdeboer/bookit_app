class Powerchair < ActiveRecord::Base

	acts_as_tenant(:account)

	has_many :bookings, as: :bookable

	validates :manufacturer, presence: true
	validates :model_type, presence: true
	validates :drive, presence: true
	validates :inventory_tag, presence: true
	validates :serial_number, presence: true

	def self.import(file)
		spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
		(1..spreadsheet.last_row).each do |row|
			manufacturer = spreadsheet.cell(row,1)
			model = spreadsheet.cell(row,2)
			drive = spreadsheet.cell(row,3)
			color = spreadsheet.cell(row,4)
			inventory_tag = spreadsheet.cell(row,5)
			serial_number = spreadsheet.cell(row,6)
			powerchair = Powerchair.new(manufacturer: manufacturer, model_type: model, drive: drive, color: color, inventory_tag: inventory_tag, serial_number: serial_number)
			powerchair.save!
		end
	end




end
