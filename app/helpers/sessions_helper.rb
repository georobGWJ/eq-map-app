helpers do

   def current_user
      @current_user ||= User.find(session[:id]) if session[:id]
   end
  #  **Same as
  #  If user exists, return user, otherwise generate user and return it.**

   def logged_in?
      current_user
   end

end
