// ========================================
// WebBack Association Panel jQuery plugin
// (Based on Phil Turney's functions)
// ----------------------------------------
// Plugins used/tested: 
//  jQuery 1.10.1
//  jQueryUI 1.10.2
// ----------------------------------------
// 05/16/2014 - Brian created
// ========================================
(function ($) {

    // plugin main function def
    $.fn.wbAssociator = function (options) {

        // execute plugin on each passed member
        this.each(function (idx) {
            var panel = $(this);

            // READ OPTIONS
            var opts = $.extend({}, $.fn.wbAssociator.defaults, getAttrOptions(panel), options);

            // BODY TOGGLER
            $('a.wb-ass-bodytoggle', panel).click(function () {
                $('.wb-ass-body', panel).toggle();
                return false;
            });

            // SET UP THE LOAD HANDLING EVENT
            $(panel).on('wbAssociator.requestload', function (evt) {
                loadAssociations(opts, panel);
            });

            // KICK OFF OUR INITIAL LOAD
            setTimeout(function () {
                $(panel).trigger('wbAssociator.requestload');
            }, 500);

            // UPDATE DETAILS BUTTON ------------------------------
            $('a.wb-ass-detail-update', panel).click(function () {
                // populate an array of values and save them!

                var itemArray = new Array();
                var detailFields = panel.find('.wb-ass-detail-field input,.wb-ass-detail-field select');

                detailFields.each(function () {
                    var assocObj = {};
                    assocObj.Id = $(this).attr("associd")
                    //just one detail for now     
                    if (!$(this).is(':checkbox')) {
                        assocObj.Detail = $(this).val();
                    }
                    else {
                        assocObj.Detail = $(this).is(':checked');
                    }
                    assocObj.Name = $(this).attr("detailname")
                    itemArray.push(assocObj);
                });

                var jsonString = JSON.stringify({ "Items": itemArray });

                $.ajax({
                    type: 'POST',
                    url: opts.urlProcess,
                    data: $.extend({}, getDefaultAjaxParams(opts), {
                        action: 'savedetails',
                        details: jsonString
                    }),
                    success: function (msg) {
                        // no activity
                        echoMessage(panel, 'success', 'Details saved');
                    }
                });

                return false;
            });

            // ADD ASSOCIATION BUTTON ------------------------
            $('a.wb-ass-choices-add', panel).click(function () {
                // add the selected item from the DDL
                var itemId = panel.find("select.wb-ass-choices-list").val();
                
                // execute the add action
                if (itemId != -1) {
                    $.ajax({
                        type: 'POST',
                        url: opts.urlProcess,
                        data: $.extend({}, getDefaultAjaxParams(opts), {
                            action: 'addassociation',
                            itemId: itemId
                        }),
                        success: function (msg) {
                            // reload the panel if we succeeded!
                            loadAssociations(opts, panel);
                            echoMessage(panel, 'success', 'Association added');
                        }
                    });
                }
                else {
                    echoMessage(panel, 'success', 'Please select an item');
                }
                

                return false;
            });

            // ENTER-KEY-TO-ADD functionality -------
            $('.wb-ass-choices-list', panel).on('change', function (evt) {
                //alert('evt.target = ' + evt.target + ', evt.which = ' + evt.which);
                if (evt.keyCode == 13) {
                    //alert('enter key for the select box!');
                    return false;
                }
            });


            // DELETE ASSOCIATION BUTTON -----------------------
            $(panel).on('click', 'a.wb-ass-existing-delete', function () {
                // look up refs to find out which item we deleted
                var actionBtn = $(this);
                var parentItem = actionBtn.closest('.wb-ass-nesting-item');
                var itemId = parentItem.attr("data-id");

                // execute the delete
                $.ajax({
                    type: 'POST',
                    url: opts.urlProcess,
                    data: $.extend({}, getDefaultAjaxParams(opts), {
                        action: 'delete',
                        itemId: itemId
                    }),
                    success: function (msg) {
                        // remove from DOM and then reload assocs after we finish
                        parentItem.slideUp(500, function () {
                            parentItem.empty().remove();
                            loadAssociations(opts, panel);
                        });
                        echoMessage(panel, 'success', 'Association removed');
                    }
                });

                return false;
            });

            // RANKABLE CONFIG ----------------------
            if (!$(this).hasClass('wb-ass-readonly')) {

                // configure the ranking! we only do this if it's not readonly
                $('.wb-ass-ranked', panel).nestedSortable({
                    handle: '.wb-ass-ranked-handle',
                    placeholder: 'wb-ass-placeholder',
                    //axis: 'y',
                    isTree: false,
                    listType: 'ul',
                    maxLevels: opts.rankLevels,
                    items: 'li',
                    tabSize: 30,
                    tolerance: 'pointer',
                    toleranceElement: 'div.wb-ass-nesting-box',
                    errorClass: 'mjs-nestedSortable-error',
                    stop: function (event, ui) {
                        // we loop through all the rankable assoc items and assign each one an appropriate rank based on its position within the tree
                        // top-level items get rank 1-99
                        // first-nest items get rank 101-9999 (based on the parent)
                        // second-nest items get rank 10101-999999 (based on the parent)

                        // assign ranks 1-99 to the top-level items
                        var elsTopLevel = $(this).children('li.wb-ass-nesting-item');
                        elsTopLevel.each(function (indexTop) {
                            var computedRankTop = indexTop + 1;
                            $(this).attr('data-wbrank', computedRankTop);

                            // assign ranks 101-9999 to the nest1 items, using parent's rank as prefix
                            var elsNest1 = $(this).children('ul').first().children('li.wb-ass-nesting-item');
                            elsNest1.each(function (indexNest1) {
                                var computedRankNest1 = computedRankTop * 100 + indexNest1 + 1;
                                $(this).attr('data-wbrank', computedRankNest1);

                                // assign ranks 10101-999999 to the nest2 items, using parent's rank as prefix
                                var elsNest2 = $(this).children('ul').first().children('li.wb-ass-nesting-item');
                                elsNest2.each(function (indexNest2) {
                                    var computedRankNest2 = computedRankNest1 * 100 + indexNest2 + 1;
                                    $(this).attr('data-wbrank', computedRankNest2);
                                });

                            });

                        });

                        // after assigning all our ranks, we simply need to collect all the embedded rank items
                        // and package up their values in an array for our AJAX processor
                        var allRankedElements = $(this).find('li.wb-ass-nesting-item');
                        var rankArray = [];
                        for (var i = 0; i < allRankedElements.length; i++) {
                            var singleElement = allRankedElements.eq(i);
                            // use the 'id:rank' syntax
                            rankArray[i] = singleElement.attr('data-id') + ':' + singleElement.attr('data-wbrank');
                        }

                        // execute our action
                        $.ajax({
                            type: 'POST',
                            url: opts.urlProcess,
                            data: $.extend({}, getDefaultAjaxParams(opts), {
                                action: 'rankassociations',
                                order: rankArray
                            })
                        });
                        
                    }
                });

            }

        }); // .each()

        // send back for chaining
        return this;
    }

    // load associations for the given panel
    function loadAssociations(opts, panel) {
        $.ajax({
            type: 'POST',
            url: opts.urlProcess,
            data: $.extend({}, getDefaultAjaxParams(opts), {
                action: 'loadassociations'
            }),
            success: function (msg) {
                var assDoc = $(msg);
                var ddlvalues = $('#associator_resp', assDoc).children("div.dropdownoptions").children("select.newoptionsddl");
                var listItems = $('#associator_resp', assDoc).children("ul.listitems");

                // load 'new assoc' choices into our select box and fire an event
                var tgtSelectNew = $("select.wb-ass-choices-list", panel);
                tgtSelectNew.html(ddlvalues.html());
                tgtSelectNew.trigger('wbAssociator.load');

                // load existing assocs into our output list
                var tgtExistingList = $(".wb-ass-existing-list", panel);
                tgtExistingList.html(listItems.html());
                tgtExistingList.trigger('wbAssociator.load');
            }
        });
    }

    // echo a status message to the panel (msgType can be 'info', 'success', 'default', 'warning', 'danger')
    function echoMessage(panel, msgType, text) {
        var echoElement = $('.wb-ass-statusecho', panel);
        // first wipe out whatever we used to have...
        echoElement.empty();
        echoElement.html('<span class="text-' + msgType + '">' + text + '</span>');
        // get a reference to our new message and fade it out
        $('span', echoElement).delay(1500).fadeOut();
    }

    // Given a set of key/value mappings, return the ones that we always need for our ajax calls
    function getDefaultAjaxParams(vals) {
        var ajaxKeys = ['srcObj', 'destObj', 'name', 'wbId', 'archiveId', "section"];
        var ajaxParams = {};
        for (var i = 0; i < ajaxKeys.length; i++) {
            var key = ajaxKeys[i];
            ajaxParams[key] = vals[key];
        }
        return ajaxParams;
    }

    // utility function for debugging
    function debug_printmap(vals, label) {
        var s = label + ' = {\n';
        for (var key in vals) {
            s += ' ' + key + ': [' + vals[key] + ']\n'
        }
        s += '}';
        alert(s);
    }

    // Get HTML data-* attribute values that should map into our options
    function getAttrOptions(elm) {
        var attrOptions = {};
        // loop through all defaults to see if any were populated
        // translate:  'srcObj' is set by 'data-srcobj' attribute on the element
        for (var attrKey in $.fn.wbAssociator.defaults) {
            var translatedKey = 'data-' + attrKey.toLowerCase()
            var attrVal = elm.attr(translatedKey);
            if (attrVal != null && attrVal != '') {
                if (attrKey.toLowerCase().indexOf('is') == 0) {
                    // boolean values are parsed
                    attrVal = (attrVal.toLowerCase() == 'true');
                }
                // store result in our array to return!
                attrOptions[attrKey] = attrVal;
            }
        }
        return attrOptions;
    }

    // plugin default settings
    $.fn.wbAssociator.defaults = {
        srcObj: 'src_undefined',
        destObj: 'dest_undefined',
        name: 'name_undefined',
        wbId: -1,
        archiveId: -1,
        isDetailed: false,
        isRanked: false,
        rankLevels: 1,
        urlProcess: '../core/ajax/WBAjaxAssociations.aspx',
        section: 'queued'
    };

} (jQuery));