$(document).on('turbolinks:load', function() {
  $(document).ready(function () {
    if ($(".swiper").length > 0) {
      new Swiper('.swiper', {
        loop: true,
        speed: 1500,
        autoplay: { // 自動再生
          delay: 1500, // 1.5秒後に次のスライド
          disableOnInteraction: false, // 矢印をクリックしても自動再生を止めない
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