var main = function() {
  /* Push the body and the nav over by 285px over */
  $('.icon-menu').mouseover(function() {
    $('.menu').animate({
      left: "0px"
    }, 200);

    $('body').animate({
      left: "285px"
    }, 200);
  });

  /* Then push them back */
  $('.icon_close').click(function() {
    $('.menu').animate({
      left: "-285px"
    }, 400);

    $('body').animate({
      left: "0px"
    }, 400);
  });
};


$(document).ready(main);