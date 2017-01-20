/**********/
/* Custom */
/**********/
(function ($) {
    $(function () {

        $('.button-collapse').sideNav({
            edge: 'right', // Choose the horizontal origin
            closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
            draggable: true // Choose whether you can drag to open on touch screens
        });

        $('.dropdown-button').dropdown({
            inDuration: 300,
            outDuration: 225,
            constrain_width: false, // Does not change width of dropdown to that of the activator
            hover: true, // Activate on hover
            gutter: 0, // Spacing from edge
            belowOrigin: false, // Displays dropdown below the button
            alignment: 'left' // Displays dropdown with edge aligned to the left of button
        });

        // Next slide
        $('.carousel').carousel('next');
        $('.carousel').carousel('next', 3); // Move next n times.
        // Previous slide
        $('.carousel').carousel('prev');
        $('.carousel').carousel('prev', 4); // Move prev n times.
        // Set to nth slide
        //$('.carousel').carousel('set', 4);
        //$('.carousel.carousel-slider').carousel({ full_width: true });


    }); // end of document ready
})(jQuery); // end of jQuery name space

//$(document).ready(function () {
//});
