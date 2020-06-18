import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

// Solving the problem of importing the right function from mapbox-gl-direction
import Directions from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions';
import '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions.css';
// import MapboxDirections from '@mapbox/mapbox-gl-directions';

const fitMapToMarkers = (map, markers) => {
  if(markers){
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 100, maxZoom: 15, duration: 0 });
  };
};


const addMarkersToMap = (map, markers) => {
  if (markers) {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup) // add this
        .addTo(map);
    });
  };
};


// add event listener submit to the form

// event.preventDefault() to prevent submit the form

// click on origin input

//  click on destination input

// click again on origin input

// submit the form



const fillingform = () => {
 if (document.querySelector("#track_start_address")) {

  document.querySelector("#mapbox-directions-origin-input > div > input[type=text]").addEventListener('mouseover', fill => {
    var start_adress =  event.currentTarget.value;
    document.querySelector("#track_start_address").value = start_adress;


  });

  document.querySelector("#mapbox-directions-destination-input > div > input[type=text]").addEventListener('mouseover', fill => {
    var end_adress = event.currentTarget.value;
    document.querySelector("#track_end_address").value = end_adress;

  });
 }

if (document.querySelector("#new_track > input.btn.btn-primary")){
  document.querySelector("#new_track > input.btn.btn-primary").addEventListener('click', prevent => {
    event.preventDefault();

    document.querySelector("#mapbox-directions-origin-input > div > input[type=text]").click();
    document.querySelector("#mapbox-directions-destination-input > div > input[type=text]").click();
    document.querySelector("#mapbox-directions-origin-input > div > input[type=text]").click();

    console.log(event);

    document.querySelector("#new_track").submit();

});
};

}






const initMapbox = () => {
  const mapElement = document.getElementById('map');



  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    // creating the map
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers);

    // logic to setup the search bar in the map
    // map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
    //                                       mapboxgl: mapboxgl }));

    addMarkersToMap(map, markers);

    fitMapToMarkers(map, markers);

    var directions = new MapboxDirections({
          geocoder: {
            proximity: [0, 0],
          }, accessToken: mapboxgl.accessToken,
             unit: 'metric',
             profile: 'mapbox/walking'
        });

        map.addControl(directions, 'top-left')





















    if (markers) {


      directions.setOrigin(markers[0]['start_address']);
      directions.setDestination(markers[1]['end_address']);

      directions.on();
    };

    // console.log(map.loaded())

    // if (map.loaded()){
    //   console.log('beep')
    //   document.getElementById('mapbox-directions-profile-cycling').click();
    //   document.getElementById('mapbox-directions-profile-walking').click();
    // };

  // Creating a logic to check if the map is loaded

  function checkifmapisloaded() {
      if(map.loaded() == false) {
         window.setTimeout(checkifmapisloaded, 100); /* this checks if is map is loaded every 100 milliseconds*/
      } else {
       document.getElementById('mapbox-directions-profile-cycling').click();
       document.getElementById('mapbox-directions-profile-walking').click();
      }
  }




  checkifmapisloaded();
  fillingform();
  }
};

export { initMapbox };
