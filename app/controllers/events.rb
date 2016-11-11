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
  @events = Event.all
  erb :"/partials/_data_viz"
end

# GET Route | RETURN an HTML/erb FORM for CREATING a new AR Object
get '/events/new' do
  erb :'/events/new'
end

# POST Route | CREATE a new AR Object (using params returned from form)
post '/events' do
  require 'uri'
  require 'net/http'
  require 'csv'

  name = params[:data][:name]
  lat = params[:data][:latitude]
  long = params[:data][:longitude]
  radius = params[:data][:radius]
  form = 'csv'
  starttime = params[:data][:starttime]
  endtime = params[:data][:endtime]
  minmag = params[:data][:minmag]

  url = URI("http://earthquake.usgs.gov/fdsnws/event/1/query?format=#{form}&starttime=#{starttime}&endtime=#{endtime}&minmagnitude=#{minmag}&latitude=#{lat}&longitude=#{long}&maxradiuskm=#{radius}")

  http = Net::HTTP.new(url.host, url.port)

  request = Net::HTTP::Get.new(url)
  request["cache-control"] = 'no-cache'

  response = http.request(request)
  eq_data = response.read_body

  File.open('./tempdata.txt', 'w') { |file| file.write(eq_data) }

  eqs = CSV.read('./tempdata.txt', headers:false)

  idx = 1
  while idx < eqs.length
    eq = Event.create({usgs_id:eqs[idx][11], northing:eqs[idx][1], easting:eqs[idx][2],
                  depth:eqs[idx][3], magnitude:eqs[idx][4], date_time:eqs[idx][0]})
    idx += 1
    if session[:id]
      @user = User.find(session[:id])
      UserEvent.create({user_id:session[:id], event_id:eq.id,
                        location_name:name,
                        location_id:@user.user_events.last.location_id+1})
    end
  end

  erb :'/events'
end
