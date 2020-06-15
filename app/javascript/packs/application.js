// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import AOS from 'aos';
import { initMapbox } from '../plugins/init_mapbox';
import { initSweetalert } from '../plugins/init_sweetalert';
import { FlipDown } from '../plugins/init_flipdown';


// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  initMapbox();
  AOS.init();

  initSweetalert('#sweet-alert-join', {
    title: "Race Joinned",
    text: "You can check it out on your profile",
    icon: "success"
  });




  // Start Of FlipDown Logic

  // Unix timestamp (in seconds) to count down to
  var trackData = document.querySelector('#trackdata');
  var datestring = trackData.dataset.date;


  var trackDate = (new Date(datestring)/1000);

  // Set up FlipDown
  var flipdown = new FlipDown(trackDate)

    // Start the countdown
    .start()

    // Do something when the countdown ends
    .ifEnded(() => {
      console.log('The countdown has ended!');
    });


  // Show version number
  var ver = document.getElementById('ver');
  ver.innerHTML = flipdown.version;

  // End of FlipDown Logic

});


