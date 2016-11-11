require 'json'

# GET Route | DISPLAY a list of ALL AR Objects
get '/events' do
  if request.xhr?
    @events = Event.all
    (@events.to_json)
  else
    erb :"/events/index"
  end
end

get '/data_viz' do
  erb :"/partials/_data_viz"
end

# GET Route | RETURN an HTML/erb FORM for CREATING a new AR Object
get '/events/new' do
  # your code here
  # erb :'/events/new'
end

# POST Route | CREATE a new AR Object (using params returned from form)
post '/events' do
  # your code here
end

# GET Route | DISPLAY a SINGLE AR Object
get '/events/:id' do
  # your code here
  # erb :'/events/show'
end
