module SessionsHelper

	# Logs in a given user by storing their id in a session variable
	def log_in(user)
		session[:user_id] = user.id
	end

	# Retrieves the current user if one is logged in. It returns the existing
	# value of current user if it has already been defined or it queries the database
	# if it has not yet been defined.
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	# Returns true if there is a user id stored in the session variable (current user is defined)
	def logged_in?
		!current_user.nil?
	end

	# Logs the user out and sets the value of current user to nil
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

end
