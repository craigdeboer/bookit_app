module LoginMacros
	def sign_in(user)
		visit root_path
		within(".jumbotron") do
			click_link 'Log In'
		end
		fill_in 'Name', with: user.name
		fill_in 'Password', with: user.password
		click_button 'Log In' 
	end
end