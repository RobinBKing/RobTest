/* ========= PAGE CODE FOR WEBBACK DETAIL PAGE ========== */

$(document).ready(function () {

    //===== Date pickers =====//
    $(".datepicker").datepicker({
        changeMonth: true,
        changeYear: true,
        constrainInput: true,
        selectOtherMonths: true,
        showButtonPanel: true,
        showOtherMonths: true,
        minDate: new Date(1900, 0, 1),
        beforeShow: function (input) {
            // add a 'clear' button to the widget after display
            setTimeout(function () {
                var btnPanel = $(input).datepicker('widget').find('.ui-datepicker-buttonpane');
                var clearBtn = $('<button class="ui-datepicker-current ui-state-default ui-priority-secondary ui-corner-all" type="button">Clear</button>');
                clearBtn.unbind('click').bind('click', function () {
                    $.datepicker._clearDate(input);
                });
                clearBtn.appendTo(btnPanel);
            }, 1);
        }
    }).filter('input').bind('keydown', function (evt) {
        // keyboard input is currently allowed, uncomment lines below to block it
        //evt.preventDefault();
        //return false;
    }).bind('blur', function (evt) {
        // hopefully "fix" bad dates when focus is lost
        var rawtext = $(this).val();
        if (rawtext.length > 0) {
            // we have a non-empty string ... make sure it can be parsed as a date
            var inMoment = moment(rawtext);
            if (inMoment != null && inMoment.isValid() && inMoment.year() >= 1753) {
                // we got a usable SQL server date!  try to format it properly
                $(this).val(inMoment.format('MM/DD/YYYY'));
                return true;
            }
            else {
                // date could not be parsed, wipe it out
                $(this).val('');
                alert('Invalid date was entered.');
                return false;
            }
        }
        return true;
    });

    //===== Time pickers =====//
    $('.timepicker').timepicker({
        'scrollDefaultNow': true,
        'step': 15,
        'timeFormat': 'g:i A'
    }).filter('input').bind('keydown', function (evt) {
        // block keyboard input
        evt.preventDefault();
        return false;
    });

    //===== Tab-Hiding Logic ====//
    wbDetailSetVisibleTabs();

    //===== Inline Tabs ====//
    wb_TabInlineInit();

    //==== Pub Dates ====// 
    wb_PubDatesInit();

    //==== Sidebar Checkboxes ====//
    wb_SidebarFieldsInit();

    //==== Publish Actions ====//
    wb_PubActionsInit();

    //===== HotKeys For Detail ====//
    // Alt-Q:  Save to Queue
    wb_HotKey('alt+q', function () {
        // run the save postback
        eval($('a.wb-detail-btn-save').attr('href'));
    });
    // Alt-P:  Publish
    wb_HotKey('alt+p', function () {
        // run the publish postback
        eval($('a.wb-detail-btn-save').attr('href'));
    });

    //===== Image Uploader (Remove Button) =====//
    $('.wb-imageupload a.wb-upload-btnremove').each(function () {
        var fieldbox = $(this).closest('.wb-upload');
        var fieldfilename = fieldbox.find('input.wb-upload-filename');
        // add a click handler which blanks the filename field and hides the whole 'current' box
        $(this).click(function () {
            // save previous name just in case
            var prevname = fieldfilename.val();
            fieldfilename.attr('data-valueprev', prevname);
            fieldfilename.val('');
            fieldbox.children('.wb-upload-current').slideUp(350);
            return false;
        });
    });

    //===== File Uploader (Remove Button) =====//
    $('.wb-fileupload a.wb-upload-btnremove').each(function () {
        var fieldbox = $(this).closest('.wb-upload');
        var fieldfileid = fieldbox.find('input.wb-upload-fileid');
        // add a click handler which blanks the filename field and hides the whole 'current' box
        $(this).click(function () {
            // save previous ID just in case
            var previd = fieldfileid.val();
            fieldfileid.attr('data-valueprev', previd);
            fieldfileid.val('-1');
            // do the hide
            fieldbox.children('.wb-upload-current').slideUp(350);
            return false;
        });
    });

    //===== Tab visibility Configuration =====//
    function wbDetailSetVisibleTabs() {
        // associations tab, hide if we had none
        var assCount = $('div.wb-ass-panel', $('#detailassoc')).length;
        if (assCount == 0) {
            wbDetailGetTab('detailassoc').hide();
        }

        // seo panel
        var seoContent = $.trim($('#detailseo').text());
        if (seoContent == '') {
            wbDetailGetTab('detailseo').hide();
        }

        // social media panel
        var socialContent = $.trim($('#detailsocialmedia').text());
        if (socialContent == '') {
            wbDetailGetTab('detailsocialmedia').hide();
        }

        // metrics panel
        var metricTabBody = $('#wbdetailmetrics');
        if (metricTabBody.length == 0) {
            wbDetailGetTab('detailmetrics').hide();
        }
    }

    // get the tab element named for the given ID (pass in 'detailnotes' to get the <li> for that tab)
    function wbDetailGetTab(tabname) {
        return $('a[href="#' + tabname + '"]', $('ul.nav')).parent('li');
    }

    //===== TEXT EDITOR config =====//
    // set up initial overrides
    wb_EditorAddOverrides();
    // we will use a queue to loop through element setup in an orderly fashion
    var edCountEarly = 3, edDelayEarly = 300, edDelayLate = 500;
    var edElements = $('textarea.wb-detail-editorflag');
    var edQueue = $({});
    var edCounter = 0;
    edElements.each(function () {
        edCounter++;
        var targetEl = $(this);
        // add a delay based on early/late status
        edQueue.delay(edCounter <= edCountEarly ? edDelayEarly : edDelayLate, 'editorqueue');
        // staged execution step
        edQueue.queue('editorqueue', function () {
            wb_EditorConfig(targetEl);
            $(this).dequeue('editorqueue');
        });
    });
    // kick off our task queue
    edQueue.dequeue('editorqueue');


    //===== ASSOCIATOR config =====//
    // we will use a queue to loop through element setup in an orderly fashion
    var assCountEarly = 1, assDelayEarly = 200, assDelayLate = 400;
    var assElements = $('div.wb-ass-panel');
    var assQueue = $({});
    var assCounter = 0;
    assElements.each(function () {
        assCounter++;
        var targetEl = $(this);
        // add a delay based on early/late status
        assQueue.delay(assCounter <= assCountEarly ? assDelayEarly : assDelayLate, 'assqueue');
        // staged execution step
        assQueue.queue('assqueue', function () {
            // each queue step will do a single setup
            wb_AssociatorConfig(targetEl);
            $(this).dequeue('assqueue');
        });
    });
    // kick off our task queue
    assQueue.dequeue('assqueue');

});



// WINDOW LOAD (for later-executing events)
$(window).load(function () {

    //==== Delayed loading of thumbnails =====//
    $('img[data-srcdelay]').each(function () {
        var newsrc = $(this).attr('data-srcdelay');
        if (newsrc != '') {
            $(this).attr('src', newsrc);
        }
    });

    //==== Notes ====//
    wb_NoteInit();

    //==== URLs ====//
    wb_UrlInit();

    //==== History ====//
    wb_HistoryInit();
});


// ===== NOTES Management ===== //
function wb_NoteInit() {
    // NOTES inputs and add button
    var noteInput = $('input.wb-notes-input');
    var noteAddButton = $('a.wb-notes-add');
    noteAddButton.click(function () {
        var noteText = $.trim(noteInput.val());
        if (noteText != '') {
            wb_NoteAdd(noteText);
        }
        return false;
    });
    // hook up enter-to-submit
    noteInput.satEnterSubmit(noteAddButton);

    // load the notes to start
    wb_NoteLoad();
}

function wb_NoteLoad() {
    var urlAjax = '../core/ajax/WBAjaxPage.aspx';
    var qsObject = wb_QueryString("object");
    var qsID = wb_QueryString("id");

    // important elements/strings
    var ulDestination = $('ul.wb-notes-list');
    var liTemplate = $('ul.wb-notes-template li').first().clone().wrap('<div>').parent().html();
    var liTemplateEmpty = liTemplate.replace('{name}', 'None found.').replace('{text}', '').replace('{date}', '');
    var noteCounter = $('span.wb-notes-counter');

    // assemble our request
    var xhr = $.ajax({
        url: urlAjax,
        type: 'GET',
        dataType: 'json',
        data: {
            action: 'note_getall',
            object: qsObject,
            id: qsID
        }
    });

    // handle results and populate!
    xhr.done(function (data) {
        // ActionName, Success, Data
        if (!data.Success) {
            alert("Note Load Failed:\n\n" + data.ErrorMessage);
        }
        else if ($.isEmptyObject(data.Data.records)) {
            // no results! pop in the empty template
            ulDestination.empty().append(liTemplateEmpty);
            noteCounter.html('0').hide();
        }
        else {
            // package up the results one by one for display!
            var outRecs = data.Data.records;
            var outBuffer = '';
            for (var i = 0; i < outRecs.length; i++) {
                var recData = outRecs[i];
                var recTemplate = liTemplate;
                // replace, name, text, and date
                recTemplate = recTemplate.replace('{name}', recData.firstname + ' ' + recData.lastname);
                recTemplate = recTemplate.replace('{date}', moment(recData.commentdate).fromNow());
                recTemplate = recTemplate.replace('{text}', recData.comment);
                recTemplate = recTemplate.replace('{id}', recData.commentid);

                // add this single item to our list
                outBuffer += recTemplate;
            }
            ulDestination.empty().html(outBuffer);
            noteCounter.html(outRecs.length).show();

            //Wire up Deletes
            $(ulDestination).find(".note-delete").click(function () {
                wb_NoteDelete($(this).closest(".list-group-item").attr("data-id"))
                return false;
            });
        }
    });
}

function wb_NoteDelete(id) {
    var urlAjax = '../core/ajax/WBAjaxPage.aspx';
    var qsObject = wb_QueryString("object");

    // assemble our request
    var xhr = $.ajax({
        url: urlAjax,
        type: 'GET',
        dataType: 'json',
        data: {
            action: 'note_delete',
            object: qsObject,
            id: id
        }
    });

    // handle results... we repopulate
    xhr.done(function (data) {
        if (data.Success) {
            wb_NoteLoad();
        }
        else {
            alert('Note Deletion Failed:\n\n' + data.ErrorMessage);
        }
    });
}

function wb_NoteAdd(text) {
    var urlAjax = '../core/ajax/WBAjaxPage.aspx';
    var qsObject = wb_QueryString("object");
    var qsID = wb_QueryString("id");

    // assemble our request
    var xhr = $.ajax({
        url: urlAjax,
        type: 'POST',
        dataType: 'json',
        data: {
            action: 'note_add',
            object: qsObject,
            id: qsID,
            text: text
        }
    });

    // handle results... we repopulate
    xhr.done(function (data) {
        if (data.Success) {
            $('.wb-notes-input').val('');
            wb_NoteLoad();
        }
        else {
            alert('Note Add Failed:\n\n' + data.ErrorMessage);
        }
    });
}


// ======= URLS Management ===== //
function wb_UrlInit() {
    var myWrapper = $('#wbdetailurls');

    // we are finished if this stuff is not on the page
    if (myWrapper.length == 0) {
        return;
    }

    // inputs and add button
    var myInput = $('input.wb-urls-input');
    var myAddButton = $('a.wb-urls-add');
    myAddButton.click(function () {
        var myText = $.trim(myInput.val());
        if (myText != '') {
            wb_UrlAdd(myText);
        }
        return false;
    });
    // hook up enter-to-submit
    myInput.satEnterSubmit(myAddButton);

    // delete buttons!
    $('div.wb-urls-existing', myWrapper).on('click', 'a.wb-urls-delete', function (evt) {
        var clickedItem = $(this).closest('li');
        wb_UrlDelete(clickedItem);
        return false;
    });

    // load to start
    wb_UrlLoad();
}

function wb_UrlLoad() {
    var urlAjax = '../core/ajax/WBAjaxPage.aspx';
    var qsObject = wb_QueryString("object");
    var qsID = wb_QueryString("id");

    // important elements/strings
    var ulDestination = $('ul.wb-urls-list');
    var liTemplate = $('ul.wb-urls-template li').first().clone().wrap('<div>').parent().html();

    // assemble our request
    var xhr = $.ajax({
        url: urlAjax,
        type: 'GET',
        dataType: 'json',
        data: {
            action: 'pageurl_getall',
            object: qsObject,
            id: qsID
        }
    });

    // handle results and populate!
    xhr.done(function (data) {
        // ActionName, Success, Data
        if ($.isEmptyObject(data.Data.records)) {
            // no results! pop in the empty template
            ulDestination.empty();
        }
        else {
            // package up the results one by one for display!
            var outRecs = data.Data.records;
            var outBuffer = '';
            for (var i = 0; i < outRecs.length; i++) {
                var recData = outRecs[i];
                var recTemplate = liTemplate;
                // replace, name, text, and date
                recTemplate = recTemplate.replace('{id}', recData.id);
                recTemplate = recTemplate.replace('{pageurl}', recData.pageurl);
                // add this single item to our list
                outBuffer += recTemplate;
            }
            ulDestination.empty().html(outBuffer);

            // === SORTING BEHAVIOR
            ulDestination.sortable({
                handle: '.wb-ranking-handle',
                axis: 'y',
                update: function (event, ui) {
                    // gather the new item order
                    var sortArray = $(this).sortable('toArray', {
                        attribute: 'data-id'
                    });

                    // execute our action
                    var xhr = $.ajax({
                        type: 'POST',
                        url: urlAjax,
                        data: {
                            action: 'pageurl_sort',
                            object: qsObject,
                            id: qsID,
                            order: sortArray
                        }
                    });

                    // when finished, only report errors
                    xhr.done(function (data) {
                        if (!data.Success) {
                            alert('Url Ranking Failed:\n\n' + data.ErrorMessage);
                        }
                    });
                }
            });
        }
    });
}

function wb_UrlDelete(clickedEl) {
    var urlAjax = '../core/ajax/WBAjaxPage.aspx';
    var qsObject = wb_QueryString("object");
    var qsID = clickedEl.attr('data-id');

    // assemble our request
    var xhr = $.ajax({
        url: urlAjax,
        type: 'POST',
        dataType: 'json',
        data: {
            action: 'pageurl_delete',
            object: qsObject,
            id: qsID
        }
    });

    // handle results... we just delete the clicked item!
    xhr.done(function (data) {
        if (data.Success) {
            clickedEl.slideUp(250, function () {
                $(this).remove();
            });
        }
        else {
            alert('Url Delete Failed:\n\n' + data.ErrorMessage);
        }
    });
}

function wb_UrlAdd(text) {
    var urlAjax = '../core/ajax/WBAjaxPage.aspx';
    var qsObject = wb_QueryString("object");
    var qsID = wb_QueryString("id");

    // assemble our request
    var xhr = $.ajax({
        url: urlAjax,
        type: 'POST',
        dataType: 'json',
        data: {
            action: 'pageurl_add',
            object: qsObject,
            id: qsID,
            text: text
        }
    });

    // handle results... we repopulate
    xhr.done(function (data) {
        if (data.Success) {
            $('.wb-urls-input').val('');
            wb_UrlLoad();
        }
        else {
            alert('Url Add Failed:\n\n' + data.ErrorMessage);
        }
    });
}


// ====== Detail Page Inline Tabs Setup ===== //
function wb_TabInlineInit() {
    var tablinks = $('.wb-detail-tabinline-strip ul.nav a[data-tabname]');
    if (tablinks.length > 0) {
        // gather ref to all our potential tabbed fields
        var tabrows_all = $('div.wb-detail-tabinline-row');
        // individually configured click-to-show for each tab
        tablinks.each(function (idx) {
            var tablink = $(this);
            var tabname = tablink.attr('data-tabname');
            var tabrows_this = tabrows_all.filter('[data-tabnames*="' + tabname + '"]');
            // on click, show the correct items... and hide the others
            tablink.bind('click', function (evt) {
                tabrows_this.show();
                tabrows_all.not(tabrows_this).hide();
                // mark the parent <li> with the active status
                $(this).parent('li').addClass('active').siblings().removeClass('active');
                return false;
            });
        });
        // initialize by clicking first tab
        tablinks.first().click();
    }
}


// ======= History Tab Management ===== //
function wb_HistoryInit() {
    var htab = $('#detailhistory');
    var hdates = $('.wb-detail-historydate', htab);
    hdates.each(function () {
        var hcontainer = $(this);
        var hdateorig = hcontainer.text();
        var hmoment = moment.utc(hdateorig);
        if (hmoment != null && hmoment.isValid()) {
            // convert to local time
            hmoment.local();
            var hdatefriendly = hmoment.format('MM/DD/YYYY') + '&nbsp;&nbsp;&nbsp;' + hmoment.format('h:mm A');
            hcontainer.html(hdatefriendly);
        }
    });
}


// ===== Configure Pub Dates behavior  ==== //
function wb_PubDatesInit() {
    $('div.wb-detail-pubdate').each(function () {
        // gather references
        var elHidden = $('input[type="hidden"]', $(this));
        var elDate = $('input.datepicker', $(this));
        var elTime = $('input.timepicker', $(this));
        var elReset = $('a.wb-detail-pubdate-close', $(this));

        // initialize display
        var initialUtcDate = elHidden.val();
        if (initialUtcDate != '') {
            var momentInitial = moment.utc(initialUtcDate);
            if (momentInitial.isValid()) {
                // convert to local time for display
                momentInitial.local();
                elDate.val(momentInitial.format('MM/DD/YYYY'));
                // show a blank for the time if it comes out to 00:00
                if (momentInitial.hour() > 0 || momentInitial.minute() > 0) {
                    elTime.val(momentInitial.format('h:mm A'));
                }
            }
            else {
                elDate.val('');
                elTime.val('');
                alert('Parsing error in the publish/remove dates section.');
            }
        }

        // event hookup: reset button
        elReset.on('click', function () {
            elDate.val('').trigger('change');
            elTime.val('').trigger('change');
            return false;
        });

        // event hookup: re-sync every time values change
        elDate.add(elTime).on('change', function () {
            syncPubDate();
        });

        // re-sync the hidden element based on contents of the date/time elements
        function syncPubDate() {
            // when a date or time has changed, we need to combine the date + time strings together and parse using moment
            var strDateBuffer = '';
            if (elDate.val() != '') {
                // place date into our buffer
                strDateBuffer += elDate.val();
                // optionally... add the time as well
                if (elTime.val() != '') {
                    strDateBuffer += ' ' + elTime.val();
                }
                else {
                    strDateBuffer += ' 12:00 AM';
                }
            }
            // consider parsing the date+time string
            if (strDateBuffer != '') {
                var momentInput = moment(strDateBuffer, 'MM/DD/YYYY h:mm A');
                if (momentInput.isValid()) {
                    // convert to UTC and store in proper format
                    momentInput.utc();
                    elHidden.val(momentInput.format('YYYY-MM-DDTHH:mm:00'));
                }
                else {
                    //alert('Failed to parse a datetime from: ' + strDateBuffer);
                    elHidden.val('');
                }
            }
            else {
                // clear the hidden storage field
                elHidden.val('');
            }
        }
    });

    // show/hide for the pubdates based on 'show on website' checkbox
    var cbShowWeb = $('input.wb-detail-showweb');
    var elPubDates = $('div.wb-detail-pubdates');

    // click toggles!
    cbShowWeb.on('click', null, function (evt) {
        if ($(this).val() == "on") {
            elPubDates.slideDown(150);
        }
        else {
            elPubDates.slideUp(150);
        }
        // re-sync our actions panel
        syncActionsToShowWeb();
    });
    // initial state
    var radioValue = $("input.wb-detail-showweb:checked").val();

    if (cbShowWeb.length > 0 && radioValue != "on") {
        elPubDates.hide();
    }

    // kick off an initial sync
    syncActionsToShowWeb();

    // make sure actions panel behaves according to showweb checkbox
    function syncActionsToShowWeb() {
        //nothing here
    }
}


// ===== Configure Pub Actions custom behavior  ==== //
function wb_PubActionsInit() {
    // force publish button to pay attention to STALE status
    var pubbutton = $('a.wb-detail-btn-publish');
    pubbutton.bind('click', function () {
        var stale_status = $('div.wb-detail-page').attr('data-wb-record-stale') == '1';
        if (stale_status) {
            var dlgresult = confirm("WARNING\n\nThis draft is more than a week old and its associations to other WebBack records may now be out of date.\n\nPublish anyway?");
            return dlgresult;
        }
        return true;
    });

    // force archive button to require confirmation
    var arcbutton = $('a.wb-detail-btn-archive');
    arcbutton.bind('click', function () {
        var dlgresult = confirm("ARCHIVE\n\nAre you sure you wish to archive this record?");
        return dlgresult;
    });
}


// ==== Move special fields to the sidebar ==== //
function wb_SidebarFieldsInit() {
    // identify the "insertion point"
    var targetMarker = $('div.wb-detail-puboptions');

    // run through all fields that need to be shown in sidebar
    var fields = $('label.wb-sidebarfield');
    if (fields.length > 0) {
        if (targetMarker.length == 1) {
            fields.each(function () {
                var field = $(this);
                // get the home row from regular field display
                var homerow = field.closest('.form-group');
                // pop field into its new home
                targetMarker.prepend(field);
                // necessary restyling
                field.addClass('checkbox-info').removeClass('checkbox-primary').removeClass('checkbox-inline');
                // hide the original row
                homerow.hide();
            });
        }
    }

    // cleanup afterward
    if (targetMarker.length == 1 && $.trim(targetMarker.text()) == "") {
        targetMarker.hide();
    }
}

// ===== Add global override behaviors to editor! ===== //
function wb_EditorAddOverrides() {
    // attach once when instance is created
    CKEDITOR.on('instanceReady', function (ev) {

        // create rule that runs our element tweaks on every possible element
        var customRules = {
            elements: {
                $: function (element) {
                    return wb_EditorCustomElementTweaks(element);
                }
            }
        };

        // apply our rules to the data processing areas
        ev.editor.dataProcessor.htmlFilter.addRules(customRules);
        ev.editor.dataProcessor.dataFilter.addRules(customRules);

        // attempt to create a rule which will also run on INSERT of elements for our form controls trickery
        ev.editor.on('insertElement', function (evInsert) {
            // we get a CKEditor element here, tweak it for 
            var ckel = evInsert.data;
            var stampClass = 'wb-editor-form-element';
            var stampableTags = ['input', 'textarea', 'select', 'button'];
            // stamp all elements that match our tag
            for (var i = 0; i < stampableTags.length; i++) {
                if (ckel.getName().toLowerCase() == stampableTags[i]) {
                    if (!ckel.hasClass(stampClass)) {
                        ckel.addClass(stampClass);
                    }
                }
            }
        });
    });
}

// Custom WebBack function that manipulates elements ... we call this upon insertion or in batch mode for HTML processing
function wb_EditorCustomElementTweaks(element) {
    // modify img tags:   attempt to strip styles for width/height/float and turn them into attributes
    if (element.name == 'img') {
        var style = element.attributes.style;
        if (style) {
            // WIDTH value
            var match = /(?:^|\s)width\s*:\s*(\d+)px/i.exec(style);
            var width = match && match[1];

            // HEIGHT value
            match = /(?:^|\s)height\s*:\s*(\d+)px/i.exec(style);
            var height = match && match[1];

            // FLOAT (left/right)
            match = /(?:^|\s)float\s*:\s*(left|right)/i.exec(style);
            var float = match && match[1];

            // re-set styles as attributes
            if (width) {
                element.attributes.style = element.attributes.style.replace(/(?:^|\s)width\s*:\s*(\d+)px;?/i, '');
                element.attributes.width = width;
            }
            if (height) {
                element.attributes.style = element.attributes.style.replace(/(?:^|\s)height\s*:\s*(\d+)px;?/i, '');
                element.attributes.height = height;
            }
            if (float) {
                element.attributes.style = element.attributes.style.replace(/(?:^|\s)float\s*:\s*(left|right);?/i, '');
                element.attributes.align = float;
            }
        }

        // CKEditor 4 safety wipe-outs to prevent attributes from being removed later
        element.forEach = function () { };
        element.writeChildrenHtml = function () { };
    }

    // modify form element tags:   attempt to label with a special saturno class
    if (element.name == 'input' || element.name == 'textarea' || element.name == 'select' || element.name == 'button') {
        if (!element.attributes['class']) {
            element.attributes['class'] = "wb-editor-form-element";
        }
        else if (!element.attributes['class'].match(/(?:^|\s)wb-editor-form-element(?!\S)/)) {
            element.attributes['class'] += " wb-editor-form-element";
        }

        // CKEditor 4 safety wipe-outs to prevent attributes from being removed later
        element.forEach = function () { };
        if (element.name != 'select') {
            element.writeChildrenHtml = function () { };
        }
    }

    // cleanup for all elements
    if (element.attributes && !element.attributes.style) {
        delete element.attributes.style;
    }
    return element;
}


//===== Custom Text Editor Build/Setup =====//
function wb_EditorConfig(mytextarea) {
    // get references and save vars
    var mytextareaid = mytextarea.attr('id');
    // create an approximate 5-minute timestamp to allow caching after first call
    var mycurrtime = (new Date());
    var mycachestamp = mycurrtime.getMonth() + '-' + mycurrtime.getDate() + '-' + mycurrtime.getHours() + '-' + (mycurrtime.getMinutes() % 5);
    // specify config file with our timestamp
    var mycustomconfig = '../../js/wb-ckeditor-default.js?mod=' + mycachestamp;

    // prevent editor plugin cache issues
    CKEDITOR.timestamp = mycachestamp;

    // get a standard 'desired size' for this element
    var desired_height = parseInt(parseInt(mytextarea.attr('rows')) * 18.5 + 14);

    // set up the 'more tools' button that swaps toolbars on click
    var myfieldrow = mytextarea.closest('.row');
    var mymorebutton = myfieldrow.find('span.wb-detail-text-btnmore');
    mymorebutton.click(function () {
        // look up the appropriate editor in memory to swap its toolbars
        var myeditor = CKEDITOR.instances[mytextareaid];
        if (myeditor) {
            myeditor.destroy();
            CKEDITOR.replace(mytextareaid, {
                customConfig: mycustomconfig,
                toolbar: 'full',
                height: desired_height * 2
            });
            $(this).hide();
        }
        return false;
    });

    // create the editor for this field!
    CKEDITOR.replace(mytextareaid, {
        height: desired_height,
        customConfig: mycustomconfig
    });
}

// ======= Associator Build/Setup ===== //
function wb_AssociatorConfig(assPanel) {
    assPanel.addClass('js-initialized');

    // dispatch the webback associator plugin (hooks up various ajax events etc)
    assPanel.wbAssociator();

    // jQueryUI autocomplete combobox config 
    $('select', assPanel).each(function () {
        // get reference to parent panel for identification purposes
        var parentPanel = $(this).closest('.wb-ass-panel');
        if (parentPanel != null && parentPanel.attr('data-recordcount') > 2000) {
            parentPanel.addClass('wb-ass-panel-highvolume');
        }

        // init the combobox only after the data is loaded into <select>
        $(this).on('wbAssociator.load', function (evt) {
            if (!$(this).hasClass('wb-ass-combobox-configured')) {
                // initialize the combobox!
                var jqbox = $(this).combobox();
                // mark as finished
                $(this).addClass('wb-ass-combobox-configured');
            }
            else {
                // refresh after data load... clear the text input
                $('input.wb-combobox-input', $(this).next('.wb-combobox')).val('');
            }
        });

        // route the autocomplete selections to force an automatic click on the ADD button
        $(this).on('wbcomboselect', function (evt, ui) {
            // clear the text from the fake input box
            $('input.wb-combobox-input', $(this).next('.wb-combobox')).val('');
            // dispatch a click to the add button
            var relatedAddButton = $(this).closest('.wb-ass-choices').find('a.wb-ass-choices-add');
            relatedAddButton.click();
        });
    });

    // Block propagation of ENTER key events beyond the ass panel
    assPanel.on('keypress', function (evt) {
        if (evt.which == 13) {
            evt.stopPropagation()
            return false;
        }
    });
}


// ====== JQUERY UI COMBOBOX IMPL ======
// Customized by Brian 06/09/2014 for compat with Bootstrap, plus custom behaviors
(function ($) {
    $.widget("custom.combobox", {
        _create: function () {
            this.wrapper = $("<span>")
                .addClass("wb-combobox")
                .insertAfter(this.element);
            this.element.hide();
            this._createAutocomplete();
            this._createShowAllButton();
        },
        _createAutocomplete: function () {
            var baseselect = this.element;
            var selected = this.element.children(":selected");
            var value = selected.val() ? selected.text() : "";

            // look up the parent panel for some info
            var isHighVolume = $(baseselect).closest('.wb-ass-panel').hasClass('wb-ass-panel-highvolume');
            var wbComboDelay = isHighVolume ? 150 : 50;
            var wbComboMinLength = isHighVolume ? 3 : 0;

            this.input = $("<input>")
                .appendTo(this.wrapper)
                .val(value)
                .attr("title", "")
                .addClass("wb-combobox-input form-control")
                .autocomplete({
                    delay: wbComboDelay,
                    autoFocus: true,
                    minLength: wbComboMinLength,
                    source: $.proxy(this, "_source")
                });
            this._on(this.input, {
                autocompleteselect: function (event, ui) {
                    ui.item.option.selected = true;
                    this._trigger("select", event, {
                        item: ui.item.option
                    });
                    // propagate an event to the 'select' element
                    baseselect.trigger('wbcomboselect', event, {
                        item: ui.item.option
                    });
                },
                autocompletechange: "_removeIfInvalid"
            });

        },
        _createShowAllButton: function () {
            var input = this.input,
                wasOpen = false;
            $("<a>")
                .attr("tabIndex", -1)
                .attr("title", "Show All Items")
                .appendTo(this.wrapper)
                .html('<i class="icon-search2"></i>')
                .addClass("wb-combobox-toggle wb-combobox-actionbtn")
                .mousedown(function () {
                    wasOpen = input.autocomplete("widget").is(":visible");
                })
                .click(function () {
                    input.focus();
                    // Close if already visible
                    if (wasOpen) {
                        return;
                    }
                    // Pass empty string as value to search for, displaying all results
                    input.autocomplete("search", "");
                });
        },
        _source: function (request, response) {
            var currentselection = this.input.val();
            var blanksearch = (currentselection == undefined || currentselection == '');
            if (blanksearch) {
                // for a 'blank' search, we'll just pull everything... with native for-loop
                var optionlist = this.element.children('option');
                var optioncount = optionlist.length;
                var resultdata = [];
                for (var i = 0; i < optioncount; i++) {
                    var optionitem = optionlist[i];
                    var text = $(optionitem).text();
                    if (text != '') {
                        resultdata.push({
                            label: text,
                            value: text,
                            option: optionitem
                        });
                    }
                }
                // call the response method with our data!
                response(resultdata);
            }
            else {
                // run the actual filtration search if we typed something
                var matcher = new RegExp($.ui.autocomplete.escapeRegex(request.term), "i");
                response(this.element.children("option").map(function () {
                    var text = $(this).text();
                    if (this.value && (!request.term || matcher.test(text))) {
                        return {
                            label: text,
                            value: text,
                            option: this
                        };
                    }
                }));
            }
        },
        _removeIfInvalid: function (event, ui) {
            // Selected an item, nothing to do
            if (ui.item) {
                return;
            }
            // Search for a match (case-insensitive)
            var value = this.input.val(),
                valueLowerCase = value.toLowerCase(),
                valid = false;
            this.element.children("option").each(function () {
                if ($(this).text().toLowerCase() === valueLowerCase) {
                    this.selected = valid = true;
                    return false;
                }
            });
            // Found a match, nothing to do
            if (valid) {
                return;
            }
            // Remove invalid value
            this.input.val("");
            this.element.val("");
            this.input.data("ui-autocomplete").term = "";
        },
        _destroy: function () {
            this.wrapper.remove();
            this.element.show();
        }
    });
})(jQuery);

