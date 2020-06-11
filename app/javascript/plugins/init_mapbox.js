import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';
// import MapboxDirections from '@mapbox/mapbox-gl-directions';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};


const addMarkersToMap = (map, markers) => {
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

        map.addControl(directions, 'top-left');

    directions.setOrigin(markers[0]['start_address']);
    directions.setDestination(markers[1]['end_address']);

    directions.on();


  }
};

export { initMapbox };
