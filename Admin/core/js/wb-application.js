
/* ========================================================
*
* Londinium - premium responsive admin template
*
* ========================================================
*
* File: wb-application.js;
* Description: Minimum of necessary js code for blank page.
* Version: 1.0
*
* ======================================================== */


$(function () {


    /* # Bootstrap Plugins
    ================================================== */


    //===== Tooltip =====//

    $('.tip').tooltip();


    //===== Popover =====//

    $("[data-toggle=popover]").popover().click(function (e) {
        e.preventDefault()
    });


    //===== Loading button =====//

    $('.btn-loading').click(function () {
        var btn = $(this)
        btn.button('loading')
        setTimeout(function () {
            btn.button('reset')
        }, 3000)
    });


    //===== Add fadeIn animation to dropdown =====//

    $('.dropdown, .btn-group').on('show.bs.dropdown', function (e) {
        $(this).find('.dropdown-menu').first().stop(true, true).fadeIn(100);
    });


    //===== Add fadeOut animation to dropdown =====//

    $('.dropdown, .btn-group').on('hide.bs.dropdown', function (e) {
        $(this).find('.dropdown-menu').first().stop(true, true).fadeOut(100);
    });


    //===== Prevent dropdown from closing on click =====//

    $('.popup').click(function (e) {
        e.stopPropagation();
    });

    //===== TRACE legibility fixes =====//
    if ($('#__asptrace').length > 0) {
        $('body').addClass('wb-trace-enabled');
    }


    /* # Select2 Dropdowns 
    ================================================== */


    //===== Datatable select =====//

    //    $(".dataTables_length select").select2({
    //        minimumResultsForSearch: "-1"
    //    });




    /* # Interface Related Plugins
    ================================================== */


    //===== jGrowl notifications defaults =====//

    //$.jGrowl.defaults.closer = false;
    //$.jGrowl.defaults.easing = 'easeInOutCirc';


    //===== Collapsible navigation =====//

    $('.sidebar-wide li:not(.disabled) .expand, .sidebar-narrow .navigation > li ul .expand').collapsible({
        defaultOpen: 'second-level,third-level',
        cssOpen: 'level-opened',
        cssClose: 'level-closed',
        speed: 150
    });

    // find items marked active and set them open at start!
    $('.sidebar .navigation ul li.active').each(function () {
        var submenu = $(this).parent('ul');
        var parentlink = submenu.prev('.expand');

        submenu.show();
        parentlink.removeClass('level-closed').addClass('level-opened');
    });

    // configure the pop-open search filters!
    var wbGlobalSearch = $('.wb-globalsearch');
    $('input', wbGlobalSearch).on('focus', function (evt) {
        var gsPopup = $('.wb-globalsearch-popup');
        if (gsPopup.hasClass('in')) {
            // already visible, we're great
        }
        else {
            // popup needs to be shown first...
            gsPopup.addClass('in');
            // ...then we bind a document-wide click handler to hide it again
            $(document).on('click.wbglobalsearch', function (evt) {
                if (!$.contains(wbGlobalSearch.get(0), evt.target)) {
                    // click was OUTSIDE our popup ... trash all of this!
                    gsPopup.removeClass('in');
                    $(document).off('click.wbglobalsearch');
                }
                else {
                    // click was INSIDE the search, leave alone
                }
            });
        }
    });

    //===== moment.js date formatting =====//

    moment.lang('en', {
        calendar: {
            lastDay: '[Yesterday at] LT',
            sameDay: '[Today at ] LT',
            nextDay: '[Tomorrow at ] LT',
            lastWeek: 'MMM D, YYYY',
            nextWeek: 'dddd [at] LT',
            sameElse: 'MMM D, YYYY'
        }
    });


    //===== Form elements styling =====//

    $(".styled, .multiselect-container input").uniform({
        radioClass: 'choice',
        selectAutoWidth: false
    });


    /* # Default Layout Options
    ================================================== */

    //===== Top Nav Setup ======//
    configureTopNavActions();

    //===== Hiding sidebar =====//

    $('.sidebar-toggle').click(function () {
        $('.page-container').toggleClass('sidebar-hidden');
    });


    //===== Disabling main navigation links =====//

    $('.navigation li.disabled a, .navbar-nav > .disabled > a').click(function (e) {
        e.preventDefault();
    });


    //===== Toggling active class in accordion groups =====//

    $('.panel-trigger').click(function (e) {
        e.preventDefault();
        $(this).toggleClass('active');
    });


    //===== HotKeys for all pages =====//
    // Alt-A:  Activity List
    wb_HotKey('alt+a', function () {
        // 06/24/2014 - Brian disabled for now
        //$('a.wb-activity-toggler').click();
    });
    // Alt-S:  Search
    wb_HotKey('alt+s', function () {
        $('input.wb-globalsearch-input').focus();
    });
    // Alt-1:  Help/Support
    wb_HotKey('alt+1', function () {
        $('a.wb-nav-supportlink').click();
    });



    // set up any funky event/behaviors on the nav
    function configureTopNavActions() {
        // file manager popup
        $('a.wb-nav-filemanlink').on('click', function () {
            window.open('../core/lib/ckfinder/ckfinderscripts/ckfinder.html?popup=1', 'CKFinderPopup1', 'location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes,resizable=yes,width=800,height=600');
            return false;
        });

        // AJAX instance reset
        $('a.wb-nav-instanceresetlink').on('click', function () {
            $('#wbirstatus').remove();
            $('body').append('<div id="wbirstatus" style="width:280px;padding:10px;margin:0 0 0 -150px;position:fixed;top:24px;left:50%;z-index:9999;background-color:#000;color:#fff;text-align:center;">Executing WebBack instance reset...</div>')
            $('#wbirstatus').click();

            var reseturl = $(this).attr('href');
            var xhr = $.ajax({
                url: reseturl,
                method: 'GET',
                dataType: 'html'
            });
            xhr.done(function (data) {
                $('#wbirstatus').remove();
                alert('SUCCESS\n\nInstance reset - in most cases, you will not see the results in action until you navigate to a new page.');
            });
            xhr.fail(function () {
                $('#wbirstatus').remove();
                alert('FAILURE\n\nWebBack instance reset failed (AJAX).')
            });

            return false;
        });
    }
});




