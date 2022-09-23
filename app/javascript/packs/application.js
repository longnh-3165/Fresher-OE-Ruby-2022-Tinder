// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";
import "jquery/dist/jquery";
import "hammerjs/hammer";
import "bootstrap/js/dist";
import "bootstrap/dist/js/bootstrap";
import "bootstrap/dist/css/bootstrap";
require("jquery")

//= require jquery3
//= require jquery_ujs
//= require hammer
//= require jquery.hammer
//= require toastr
//= require_tree .

window.$ = jQuery;
global.toastr = require("toastr")

Rails.start();
Turbolinks.start();
ActiveStorage.start();

toastr.options = {
  "closeButton": false,
  "debug": false,
  "newestOnTop": false,
  "progressBar": false,
  "positionClass": "toast-top-right",
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
}
