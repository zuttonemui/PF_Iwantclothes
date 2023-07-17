/* global $*/
$(document).on('turbolinks:load', function() {
  $(document).ready(function () {
    $(function(){
      $(".navbar-nav li").hover(function() {
        $(this).stop()
        .fadeTo(200,0)
        .fadeTo(200,1)
        .fadeTo(200,0)
        .fadeTo(200,1)
        .fadeTo(200,0)
        .fadeTo(200,1)
        },
      function(){
        $(this).stop(true, false)
        .fadeTo(200,1)
      });
    });
  });
});