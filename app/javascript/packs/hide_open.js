/* global $*/
$(document).on('turbolinks:load', function() {
  $(document).ready(function () {
    $('.hide').on('click', function() {
      var findElm = $(this).next(".open");
      $(findElm).slideToggle();
    });
  });
});