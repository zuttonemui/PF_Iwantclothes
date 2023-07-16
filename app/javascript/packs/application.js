// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

import "./swiper"
// import "./heart"

// $(document).on('turbolinks:load', function() {
//   $(document).ready(function open_answer() {
//     let obj = "document.getElementById('commentopen_<%= want_clothes.id.to_s%>').style.display"
//     if (obj == 'none') {
//       document.getElementById('commentopen_<%= want_clothes.id.to_s%>').style.display = 'block';
//     } else {
//       document.getElementById('commentopen_<%= want_clothes.id.to_s%>').style.display = 'none';
//     }
//   });
// });