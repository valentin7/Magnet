var map;
var brownUniversity = new google.maps.LatLng(41.8262, -71.4032);
var markers = [];
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
    zoom: 14,
    center: brownUniversity,
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
  google.maps.event.addListener(map, 'click', function(event) {
    addMarker(event.latLng);
  });
}

// Add a marker to the map and push to the array.
function addMarker(location) {
  var marker = new google.maps.Marker({
    position: location,
    map: map
  });
  markers.push(marker);
}

// Sets the map on all markers in the array.
function setAllMap(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setAllMap(null);
}

// Shows any markers currently in the array.
function showMarkers() {
  setAllMap(map);
}

// Deletes all markers in the array by removing references to them.
function deleteMarkers() {
  clearMarkers();
  markers = [];
}

google.maps.event.addDomListener(window, 'load', initialize);




////////////////////////////////////////////////////////////////////////////////////////////////////


// var map;

// var MY_MAPTYPE_ID = 'style';
// var brownUniversity = new google.maps.LatLng(41.8262, -71.4032);

// function initialize() {
// 	var featureOpts = [
// 	  {
// 	    stylers: [
// 	      { hue: '#555555' },
// 	    	{ lightness: 50},
// 	      { visibility: 'simplified' },
// 	      {gamma: 0.5},
// 	      { weight: 0.5 }
// 	    ]
// 	  },
// 	  {
// 	    elementType: 'labels',
// 	    stylers: [
// 	      { visibility: 'on' }
// 	    ]
// 	  },
// 	    ];

//   var mapOptions = {
//     zoom: 12,
//     center: brownUniversity,
//     mapTypeIds: [google.maps.MapTypeId.ROADMAP, MY_MAPTYPE_ID]
//   };
//     mapTypeId: MY_MAPTYPE_ID
//   	map = new google.maps.Map(document.getElementById('center'),
//       mapOptions);


//   var customMapType = new google.maps.StyledMapType(featureOpts, styledMapOptions);

//   map.mapTypes.set(MY_MAPTYPE_ID, customMapType);


//   var styledMapOptions = {
//     name: 'style'
//   };

//   // This event listener will call addMarker() when the map is clicked.
//   google.maps.event.addListener(map, 'click', function(event) {
//     addMarker(event.latLng);
//   });
// }


// google.maps.event.addDomListener(window, 'load', initialize);