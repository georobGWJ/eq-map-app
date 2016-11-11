get '/users' do
  erb :"/users/index"
end

#NEW (GET)

get '/users/new' do
   erb :'/partials/_new.html', layout: !request.xhr?
end

#SHOW (GET)

get '/users/:id' do

   @user = User.find(params[:id])

   if current_user == @user
      redirect "/users/#{@user.id}"
   else
      redirect "/"
   end

end

#CREATE (POST)

post '/users' do

   if params[:password_confirmation] == params[:password]
      @user = User.create({first_name: params[:first_name],
                        last_name: params[:last_name],
                        email: params[:email],
                        password: params[:password]})
   else
      @errors = "Passwords do not match!"
      erb :'/partials/_new.html'
   end
end
