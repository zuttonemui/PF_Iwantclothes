$(document).on('turbolinks:load', function() {
  $(document).ready(function () {
    if ($(".swiper").length > 0) {
      new Swiper('.swiper', {
        loop: true,
        speed: 1500,
        autoplay: {
          delay: 1500,
          disableOnInteraction: false,
        },

        pagination: {
          el: '.swiper-pagination',
        },

        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev',
        }
      });
    }
  });
});