module ApplicationHelper

	# The search prep method takes the params from the search method in 
	# each of the equipment models and removes any empty strings in the 
	# array and also removes any key/value pairs where the array is empty 
	# (no selection was made by the user). It basically sanitizes the raw
	# data coming from the search query and presents it in a suitable form
	# for the class method.

	def search_prep(params, equipment)
		params_hash = {}
		params.each do |key, array|
			array.reject!{ |item| item == "" }
			if ["width", "depth"].include?(key)
				temp_array = []
				array.each do |item|
					temp_array << item.to_i
				end
				array = temp_array
			end
			params_hash.merge!({key => array}) unless array.empty?
		end
		case equipment
		when "wheelchair"
			@equipment = Wheelchair.search(params_hash)
		end
		@equipment
	end
end
