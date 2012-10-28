$(document).ready(function() {
  $('#navbar').scrollspy();

  $('.navbar').affix({
      offset: {
        top: 90
      , bottom: 90
      }
    })
});
