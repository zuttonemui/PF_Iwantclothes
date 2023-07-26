/* global $*/
$(document).on('turbolinks:load', function() {
  $(document).ready(function () {
    function TextTypingAnime() {
      $('.TextTyping').each(function () {
        var elemPos = $(this).offset().top - 50;
        var scroll = $(window).scrollTop();
        var windowHeight = $(window).height();
        var thisChild = "";
        if (scroll >= elemPos - windowHeight) {
          thisChild = $(this).children();
          thisChild.each(function (i) {
            var time = 100;
            $(this).delay(time * i).fadeIn(time);
          });
        } else {
          thisChild = $(this).children();
          thisChild.each(function () {
            $(this).stop();
            $(this).css("display", "none");
          });
        }
      });
    }

    $(window).on('load', function () {
      var element = $(".TextTyping");
      element.each(function () {
        var text = $(this).html();
        var textbox = "";
        text.split('').forEach(function (t) {
          if (t !== " ") {
            textbox += '<span>' + t + '</span>';
          } else {
            textbox += t;
          }
        });
        $(this).html(textbox);

      });

      TextTypingAnime();
    });
  });
});