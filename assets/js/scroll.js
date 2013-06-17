$(document).ready(function() {

var positionElementInPage = $("#header").offset().top;

$(window).scroll(
    function() {
        if ($(window).scrollTop() >= positionElementInPage) {
            // fixed
            $('#scroll').addClass("fixed");
        } else {
            // relative
            $('#scroll').removeClass("fixed");
        }
    }
);
});
