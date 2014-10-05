// function initialize() {
//   var mapOptions = {
//     zoom: 8,
//     center: new google.maps.LatLng(-34.397, 150.644)
//   };

//   var map = new google.maps.Map(document.getElementById('center'),
//       mapOptions);
// }

// function loadScript() {
//   var script = document.createElement('script');
//   console.log("kwjehgrd");
//   script.type = 'text/javascript';
//   script.src = 'https://maps.googleapis.com/maps/api/js?key=AIzaSyAsY5oasY4CF9Oq9Eu2U2dekHXJEuLHvH4' +
//       'callback=initialize';
//   document.body.appendChild(script);
// }

// window.onload = loadScript;


var map;
var brooklyn = new google.maps.LatLng(40.6743890, -73.9455);

var MY_MAPTYPE_ID = 'style';

function initialize() {

  var featureOpts = [
    {
      stylers: [
        { hue: '#555555' },
      	{ lightness: 50},
        { visibility: 'simplified' },
        {gamma: 0.5},
        { weight: 0.5 }
      ]
    },
    {
      elementType: 'labels',
      stylers: [
        { visibility: 'on' }
      ]
    },
      ];

  var mapOptions = {
    zoom: 5,
    center: brooklyn,
    mapTypeControlOptions: {
      mapTypeIds: [google.maps.MapTypeId.ROADMAP, MY_MAPTYPE_ID]
    },
    mapTypeId: MY_MAPTYPE_ID
  };

  map = new google.maps.Map(document.getElementById('center'),
      mapOptions);

  var styledMapOptions = {
    name: 'Style'
  };

  var customMapType = new google.maps.StyledMapType(featureOpts, styledMapOptions);

  map.mapTypes.set(MY_MAPTYPE_ID, customMapType);
}

google.maps.event.addDomListener(window, 'load', initialize);