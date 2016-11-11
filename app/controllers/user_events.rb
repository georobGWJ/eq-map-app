# GET Route | DISPLAY a list of ALL AR Objects
get '/user_events' do
  # your code here ...
  erb :'/user_events/index'
end

# GET Route | RETURN an HTML/erb FORM for CREATING a new AR Object
get '/user_events/new' do
  # your code here
  # erb :'/user_events/new'
end

# POST Route | CREATE a new AR Object (using params returned from form)
post '/user_events' do
  # your code here
end

# GET Route | DISPLAY a SINGLE AR Object
get '/user_events/:id' do
  # your code here
  # erb :'/user_events/show'
end

# GET Route | RETURN an HTML/erb FORM for EDITING an AR Object
get '/user_events/:id/edit' do
  # your code here
  # erb :'/user_events/edit'
end

# PUT Route | UPDATE a specific AR Object (using params returned from form)
put '/user_events/:id' do
  # your code here
end

# DELETE Route | DELETE a specific AR Object
delete '/user_events/:id' do
  # your code here
end
