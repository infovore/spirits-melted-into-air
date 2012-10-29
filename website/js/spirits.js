$(document).ready(function() {
  $('.fancybox').fancybox({
    helpers: {
      title: {
        type: 'over'
      }
    }
  });
  $('#navbar').scrollspy();

  $('.navbar').affix({
      offset: {
        top: 90
      , bottom: 90
      }
    })
});
