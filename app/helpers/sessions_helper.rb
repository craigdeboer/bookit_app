module SessionsHelper

	# Logs in a given user by storing their id in a session variable
	def log_in(user)
		session[:user_id] = user.id
	end
  
	# The remember method sets the browser cookies and sets the remember_token digest
	# in the user's database. First it calls the remember method in the User class.
	# This method sets the user's temporary remember_token attribute so it can
	# be assigned to the browser coookie in the last line of this method. The
	# User class remember method also calls a couple of other class methods
	# to generate a token and create a hash digest of the token, and store it
	# in the database as the user's remember_token digest. The second line
	# of the remember method defined below stores an encrypted version of the
	# users id (this is what .signed does), and the last line stores the 
	# remember_token attribute (which is temporary and is set in the User class 
	# remember method) in a browser cookie.

	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	# The current_user method looks to see if a session has been created (using the log_in method).
	# If session[:user_id] has been defined, it will return the user corresponding
	# to the value of @current_user if it has previously been defined or if it hasn't,
	# the method will hit the database to find the logged in user.
	# If session[:user_id] is nil, the method will see if there is a signed cookie[:user_id]
	# in the browser. If so (and there should be if there is no session variable and this
	# method is being called), a variable is assigned the instance of the user found by the 
	# signed cookie containing the user_id. Provided that a user is found with that user_id
	# from the cookie, the [:remember_token] cookie is sent to the authenticated method to 
	# verify that it matches the remember_token digest corresponding to the user that is stored
	# in their database. If it does, then we log_in the user so we don't have to 
	# authenticate them again in this browser session and finally an instance of the 
	# authenticated user is returned to the caller. 
 
	def current_user
		if session[:user_id]
			@current_user ||= User.find_by(id: session[:user_id])
	  elsif cookies.signed[:user_id]
	  	user = User.find_by(id: cookies.signed[:user_id])
	  	if user
	  		if user.remember_digest
	  		  if user.authenticated?(cookies[:remember_token])
		  			log_in user
		  			@current_user = user
		  		else
		  			@current_user = nil
	  			end
	  		else
	  			@current_user = nil
	  		end
	  	end		
	  end
	end

	# Returns true if there is a user id stored in the session variable (current user is defined)
	def logged_in?
		!current_user.nil?
	end

	# Checks if current user has admin priviledges.
	def admin?
		current_user.admin == true
	end

	def super_admin?
		current_user.account_id == 1 && current_user.name == "Craig Deboer"
	end

	# Logs the user out and sets the value of current user to nil
	def log_out
		forget(current_user)
		session.delete(:user_id)
		@current_user = nil
	end

	# Logs user out of a persistent session.
	def forget(user)
		user.forget 		#sets remember_digest to nil
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

end
