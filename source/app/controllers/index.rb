get '/' do
	#These are params if there was an error (otherwise nil)
	@login_error = params[:params_login]
	@register_error = params[:params_registration]
  erb :index
end

post '/login' do
	email = params[:email]
	password = params[:password]
	if User.authenticate(email, password)
		user = User.find_by_email(email)
		session[:user_id] = (User.find_by_email(email)).id
		redirect '/user/home'
	else
		redirect '/?params_login=There was an error with login.'
	end

end

post '/register' do
	email = params[:email]
	password = params[:password]
	if User.find_by_email(email)
		redirect to '/?params_registration=There was an error with registration'
	else
		@user = User.create(email: email)
		@user.password = password
		@user.save

		session[:user_id] = @user.id
		redirect '/user/home'
	end
end