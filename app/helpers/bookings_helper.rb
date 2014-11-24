module BookingsHelper
	def calendar(date)
		weeks(date)
	end

	def weeks(date)
		first_day = date.beginning_of_month.beginning_of_week(:sunday)
		last_day = date.end_of_month.end_of_week(:sunday)
		(first_day..last_day).to_a.in_groups_of(7)
	end

	def find_bookings(bookings)
		
		dates_array = []
		users_array = []
		bookings.each do |booking|
			temp = booking[:start_date]
			temp1 = booking[:end_date]
			dates_array << (temp..temp1).to_a
			users_array << User.find(booking[:user_id]).initials
		end
		hash_maker(dates_array, users_array)
	end

	def hash_maker(dates, users)
		a = {}
		count = 0
		dates.each do |dates_array|
			dates_array.each do |date|
				a.store(date, users[count])
			end
			count += 1
		end
		a
	end

	def remove_proposed(bookings_hash, array)
		bookings_hash.delete_if { |key, value| array.include?(key) }
	end

	def booked_array(bookings_hash)
		new_array = []
		bookings_hash.each do |key, value|
			new_array << key
		end
		new_array
	end


	def valid_end_date?(date, start_date, bookings)
		array_of_valid_end_dates(start_date, bookings).include?(date)
	end

	def array_of_valid_end_dates(start_date, bookings)
		start_dates = []
		valid_end_date_array = []
		last_valid_end_date = nil
		bookings.each { |booking| start_dates << booking[:start_date] }
		start_dates.sort!
		start_dates.each do |date|
			if last_valid_end_date == nil && date > start_date
				last_valid_end_date = date.prev_day
			end
		end
		if last_valid_end_date == nil
			last_valid_end_date = start_date.next_month
		end
		valid_end_date_array = (start_date..last_valid_end_date).to_a
	end

	def day_classes(day, date, booked_dates, proposed_dates)
		classes = []
		if proposed_dates != nil
			classes << "proposed" if proposed_dates.include?(day)
		end
		classes << "booked" if booked_dates.include?(day)
 	  classes << "today" if day == Date.today
	  classes << "notmonth" if day.month != date.month
	  classes << "available" if day > Date.today
	  classes.empty? ? nil : classes.join(" ")
	end

	
	
		




	# def day_classes(day, date)
	# 	classes = []
 # 	  classes << "today" if day == Date.today
	#   classes << "notmonth" if day.month != date.month
	#   classes.empty? ? nil : classes.join(" ")
	#  end

end
