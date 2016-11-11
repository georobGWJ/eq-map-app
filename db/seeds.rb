
require 'uri'
require 'net/http'
require 'csv'

lat = 37.784
long = -122.395
radius = 50
form = 'csv'
starttime = '1900-01-01'
endtime = '2016-11-09'
minmag = 3

url = URI("http://earthquake.usgs.gov/fdsnws/event/1/query?format=#{form}&starttime=#{starttime}&endtime=#{endtime}&minmagnitude=#{minmag}&latitude=#{lat}&longitude=#{long}&maxradiuskm=#{radius}")

http = Net::HTTP.new(url.host, url.port)

request = Net::HTTP::Get.new(url)
request["cache-control"] = 'no-cache'

response = http.request(request)
eq_data = response.read_body

p eq_data.class

File.open('./tempdata.txt', 'w') { |file| file.write(eq_data) }

eqs = CSV.read('./tempdata.txt', headers:false)

idx = 1
while idx < eqs.length
  Event.create({usgs_id:eqs[idx][11], northing:eqs[idx][1], easting:eqs[idx][2],
                depth:eqs[idx][3], magnitude:eqs[idx][4], date_time:eqs[idx][0]})
  idx += 1
end
