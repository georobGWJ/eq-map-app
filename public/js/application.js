$(document).ready(function () {
  tabActivator();
  getCircle(magnitude);
});

var tabActivator = function() {
  // Get tab id that is clicked on and make that <li> active
  $( ".tabs" ).click(function( event ) {
    // event.preventDefault();
    $(event.target).parent().addClass("active").siblings().removeClass("active");
  })
}

var map;
var eqArray = [];

var earthquakes

var getEarthquakes =   $.ajax({
        url: "/events",
        method: "GET",
        dataType: "json",
        context: document.body,
        success: function(){
           alert("done");
        }
      }).done(function(response) {
        earthquakes = response;
        eqfeed_callback(earthquakes);
      });


function initMap() {
  centerCoords = new google.maps.LatLng(37.784,-122.395)

  map = new google.maps.Map(document.getElementById('map'), {
    center: centerCoords,
    zoom: 10,
    mapTypeId: 'terrain'
  });
}



var getCircle = function(magnitude) {
  return {
    path: google.maps.SymbolPath.CIRCLE,
    fillColor: 'red',
    fillOpacity: 0.4,
    scale: Math.pow(2, magnitude) / 2,
    strokeColor: 'white',
    strokeWeight: 0.5
  };
}

// Loop through the results array and place a marker for each
// set of coordinates.
eqfeed_callback = function(eqs) {
  for (var idx = 0; idx < eqs.length; idx++) {
    var an_event = eqs[idx];
    var latLng = new google.maps.LatLng(an_event.northing,an_event.easting);
    // console.log(getCircle(an_event.magnitude));
    var marker = new google.maps.Marker({
      position: latLng,
      icon: (getCircle(an_event.magnitude)),
      map: map
    });

    var infowindow = new google.maps.InfoWindow({
        content: an_event.magnitude
    });
      google.maps.event.addListener(marker, 'click', function() {
      infowindow.open(map,marker);
    });
  }
}

// eqArray.push(marker);
// var infowindow = new google.maps.InfoWindow({
//     content: an_event.magnitude;
// });
//   google.maps.event.addListener(marker, 'click', function() {
//   infowindow.open(map,marker);
// });

// function plotPoint(Lat,Long,title,mag)
// function plotPoint(args)
// {
//     var myLatlng = new google.maps.LatLng(args.Lat, args.Long);
//     var marker = new google.maps.Marker({
//           position: myLatlng,
//           map: map,
//           title: args.title
//       });
    // eqArray.push(marker);
    // var infowindow = new google.maps.InfoWindow({
    //     content: args.title
    // });
    //   google.maps.event.addListener(marker, 'click', function() {
    //   infowindow.open(map,marker);
    // });
// }
