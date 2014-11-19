namespace :db do
	desc "Fill database with sample data"

	task populate: :environment do
		User.create!(name: "Craig Deboer",
								 initials: "CRD",
								 email: "craig@cdeboer.net",
								 password: "foobar",
								 password_confirmation: "foobar",
								 admin: true)

		100.times do |n|
			manufacturer_select = ["Pride", "Sunrise", "Motion Composites", "PDG", "Invacare", "Ottobock"]
			pride_model = ["Litestream", "Stylus"]
			sunrise_model = ["Breezy 600", "Quickie 2", "Iris"]
			motion_model = ["Helio"]
			pdg_model = ["T-20", "T-50", "Stellar"]
			ottobock_model = ["M2 Effect", "Obus"]
			invacare_model = ["Myon", "Prospin", "Solara"]
			width_select = [16, 18, 20]
			depth_select = [16, 18]
			color_select = ["black", "blue", "red"]
			manufacturer = manufacturer_select.sample
			case manufacturer
			when "Pride"
				model_type = pride_model.sample
			when "Sunrise"
				model_type = sunrise_model.sample
			when "Motion Composites"
				model_type = motion_model.sample
			when "PDG"
				model_type = pdg_model.sample
			when "Invacare"
				model_type = invacare_model.sample
			when "Ottobock"
				model_type = ottobock_model.sample
			end
			width = width_select.sample
			depth = depth_select.sample
			color = color_select.sample
			inventory_tag = "#{manufacturer} #{model_type} #{n}"
			serial_number = "ms-0000#{n}"
			Wheelchair.create!(manufacturer: manufacturer,
												 model_type: model_type,
												 width: width,
												 depth: depth,
												 color: color,
												 inventory_tag: inventory_tag,
												 serial_number: serial_number)
		end
	end
end