/* ========= PAGE CODE FOR WEBBACK LIST PAGE ========== */

$(document).ready(function () {

    // mark active nav tab
    wb_List_NavInit();

    // set up filter elements and mark any selections
    wb_List_FiltersInit();

    // initialize datatable content and events
    var oTable = wb_List_TableInit();

    // execute actions that need to run after table load
    wb_List_TableLoaded(oTable);

    // handled the post-publish popups
    wb_List_PostPublishPopupInit();

    //===== Date pickers =====//
    $(".datepicker").datepicker({
        showOtherMonths: true
    }).filter('input').bind('keydown', function (evt) {
        // block keyboard input
        evt.preventDefault();
        return false;
    });;

    //===== HotKeys For List ====//
    // Alt-N:  Next Page (listview)
    wb_HotKey('alt+n', function () {
        $('a.paginate_button.next').click();
    });
    // Alt-B:  Back to previous page (listview)
    wb_HotKey('alt+b', function () {
        $('a.paginate_button.previous').click();
    });
    // Alt-O:  Filters activate!
    wb_HotKey('alt+o', function () {
        // open the adv filters if we have em
        $('.wb-listfilters-toggler a').not('.active').click();
        // focus the keyword filter area
        $('.dataTables_filter input').focus();
    });
});



/* ========= PAGE-SPECIFIC FUNCTION DEFS ============= */

// get the general record status we're currently showing: ("active","private", "queued", "archived")
function wb_List_StatusGet() {
    var status = $.trim(wb_WBDataGet("currentstatus"));

    // empty? fall back to the query string...
    if (status == "") {
        var queryStatus = wb_QueryString("status");
        if (queryStatus != null) {
            queryStatus = queryStatus.toLowerCase();
            if (queryStatus == "queued") {
                status = "queued";
            }
            if (queryStatus == "private") {
                status = "private";
            }
            else if (queryStatus == "archived") {
                status = "archived";
            }
        }
    }

    // still empty? we'll use default of active
    if (status == "") {
        status = "active";
    }
    return status;
}

// mark the correct nav tab based on record status
function wb_List_NavInit() {
    var currstatus = wb_List_StatusGet();
    var activetab = $('.wb-listnav li').filter(function (idx) {
        // match only tabs containing the text of our active status
            
        return ($(this).attr("wb-data-tabstatus").toLowerCase().indexOf(currstatus) >= 0);
    }).addClass('active');
}

// detect and execute the code to run a post-publish popup (if necessary)
function wb_List_PostPublishPopupInit() {
    var popurlbase = wb_WBDataGet('postpublishpopupurl');
    if (popurlbase != '') {
        // need to take this base url and augment it with record details if a record was published
        var pubmarker = $('.wb-postpublish-indicator');
        if (pubmarker.length > 0) {
            // prepare to attach query string params...
            var popurl = popurlbase + (popurlbase.indexOf('?') >= 0 ? '&' : '?');
            popurl += 'object=' + pubmarker.attr('data-object');
            popurl += '&language=' + pubmarker.attr('data-language');
            popurl += '&id=' + pubmarker.attr('data-id');
            // now execute the load of our final url!
            $('#modal_remote').modal({
                remote: popurl
            });
        }
    }
}

// Configure the active "advanced filters" for this list view
function wb_List_FiltersInit() {
    var filters = $('.wb-listfilter');
    var filtertoggle = $('.wb-listfilters-toggler a');

    // no filters found? hide the toggler button
    if (filters.length == 0) {
        filtertoggle.hide();
    }
    else {
        // configure a click to toggle the advanced filters
        filtertoggle.bind('click', function (evt) {
            var currentstate = $(this).hasClass('active');
            wb_List_FiltersSetVisible(!currentstate);
            return false;
        });

        // MARK SELECTIONS based on saved-state info
        var dtsavedraw = null;
        if ($.fn.dataTable.fnVersionCheck('1.10') && ('localStorage' in window) && (window['localStorage'] !== null)) {
            // construct storage key using pathname, should look like "/admin/core/recordlist.aspx"
            var storagekey = 'DataTables_DataTables_Table_0_' + window.location.pathname;

            // try to read storage key based on capitalization
            dtsavedraw = localStorage.getItem(storagekey);
        }
        if (dtsavedraw != null) {
            // parse as JSON to read our saved-state values
            var dtsaved = JSON.parse(dtsavedraw);
            if (dtsaved != null && dtsaved != "") {
                var advfilters = dtsaved['aWBFilters'];
                if (advfilters != null && dtsaved['sWBKey'] == wb_List_PageKeyGet()) {
                    // loop through each filter and try to set its value
                    for ( var j=0; j<advfilters.length; j++ ) {
                        wb_List_FiltersInitSingle(advfilters[j]['id'], advfilters[j]['val']);
                    }
                }
            }
        }
    }
}

// Initialize an on-page controls for a single filter, based on a given id/val combination
function wb_List_FiltersInitSingle(filterid, filterval) {
    var filterel = $('.wb-listfilter[data-filterid="' + filterid + '"]');
    if ( filterel.length > 0 && filterval != null) {
        // store the value in attribute
        filterel.attr('data-filtervalue', filterval);

        // prepare to set value in form control
        var formctl = filterel.find('.wb-filterelement');
        var formval = filterval;
        if ( formctl.is('[multiple]') ) {
            formval = filterval.split(',');
        }
        // actually store the results!
        if (formctl.is('input[type="checkbox"]')) {
            // checkbox fields
            formctl.prop('checked', (filterval == '1')).trigger('change');
        }
        else {
            // standard value fields
            formctl.val(formval);
        }
    }
}

// Returns true if we are on a rankable list view
function wb_List_IsRankable() {
    var rankels = $('.wb-listactions-rank', $('#wbdata'));
    return (rankels.length > 0);
}

// Get the selected state of the "advanced filters" for this list view
function wb_List_FiltersGetState() {
    var filterVals = [];
    $('.wb-listfilter').each(function(idx) {
        var fid = $(this).attr('data-filterid');
        var fval = $(this).attr('data-filtervalue');
        if ( fval != '' ) {
            filterVals.push({
                'id' : fid,
                'val' : fval
            });
        }
    });
    return filterVals;
}

// Set the visible status of the advanced filters section
function wb_List_FiltersSetVisible(vis) {
    var filterbutton = $('.wb-listfilters-toggler a');
    var filtercontainer = $('.datatable-filteradv');
    if (vis) {
        // show the filters
        filterbutton.addClass('active btn-primary').removeClass('btn-default');
        filtercontainer.slideDown(250);
    }
    else {
        // hide the filters
        filterbutton.addClass('btn-default').removeClass('active btn-primary');
        filtercontainer.slideUp(250);
    }
}

// Carry out post-table actions here... the DOM components do not all exist until the table finishes its setup
function wb_List_TableLoaded(oTable) {
    // attach a placeholder attribute to the primary filter
    $('.dataTables_filter input').attr('placeholder', 'Keyword');

    // areas where we need to do some surgery
    var dtHeader = $('.datatable-header');
    var dtFilters = $('.datatable-filteradv');

    // move the language swap into the table header
    dtHeader.append($('.wb-langswap'));
    dtHeader.append($('.wb-listfilters-toggler'));

    // move the advanced filters into the filters area
    dtFilters.append($('.wb-listfilters'));

    // CHANGE EVENTS to make filters store their selected values in the "data-filtervalue" attribute
    var filterboxes = $('.wb-listfilter');
    filterboxes.each(function (idx) {
        var filterbox = $(this);
        filterbox.on('change keypress', 'input,select', function (evt) {
            // if our value is changed, we save the val()!
            var originator = $(evt.target);
            var newval = originator.val();
            // read values as 1/0 for checkboxxes
            if (originator.is('input[type="checkbox"]')) {
                newval = originator.prop('checked') ? 1 : 0;
            }
            filterbox.attr('data-filtervalue', newval);
            // notify the table object of our update!
            wb_List_TableFilterChanged(oTable, filterbox.attr('data-filterid'), newval);
        });
    });

    // open the filters panel if any pre-set filters are found
    var activefilters = filterboxes.filter(function(){
        var filterval = $(this).attr('data-filtervalue');
        return ( filterval != null && filterval != '' && filterval != '-1' && filterval != '0');
    });
    if ( activefilters.length > 0 ) {
        dtFilters.show();
        wb_List_FiltersSetVisible(true);
    }
}

// Called whenever one of the external filters on the table gets changed, in case we want to make updates!
function wb_List_TableFilterChanged(oTable, filterid, filterval) {
    // ask for a redraw which will force a state save
    oTable.draw(false);
    // need a new filtration url ... update the table and ask it to reload!
    var updatedurl = wb_List_AjaxServerSideUrlGet();
    //alert('Updating ajax url for reload:\n\n' + updatedurl);
    oTable.ajax.url(updatedurl).load();
}

// Get the correct path to the ajax source data, based on current page state (filters, etc.)
function wb_List_AjaxUrlGet() {
    // base data url
    var currObjName = wb_WBDataGet("objectname");
    var currObjStatus = wb_WBDataGet("currentstatus");
    var currObjLang = wb_WBDataGet("currentlanguage");
    var url = "ajax/recordlist_data.aspx?object=" + currObjName + "&status=" + currObjStatus + "&language=" + currObjLang;

    // attach the filter params for any filters selected on the page
    var advfilters = wb_List_FiltersGetState();
    for ( var i=0; i<advfilters.length; i++ ) {
        var advfilter = advfilters[i];
        url += "&" + advfilter['id'] + "=" + advfilter['val'];
    }
    return url;
}

// Get the correct path to the server-side processing source data, including current page state (filters, etc.)
function wb_List_AjaxServerSideUrlGet() {
    // base data url
    var currObjName = wb_WBDataGet("objectname");
    var currObjStatus = wb_WBDataGet("currentstatus");
    var currObjLang = wb_WBDataGet("currentlanguage");
    var url = "ajax/jqdt/jqdtAjaxProcessor.aspx?object=" + currObjName + "&status=" + currObjStatus + "&language=" + currObjLang;

    // attach the filter params for any filters selected on the page
    var advfilters = wb_List_FiltersGetState();
    for (var i = 0; i < advfilters.length; i++) {
        var advfilter = advfilters[i];
        url += "&" + advfilter['id'] + "=" + advfilter['val'];
    }
    return url;
}

// Get the unique page key for this record list
function wb_List_PageKeyGet() {
    var currObjName = wb_WBDataGet("objectname");
    var currObjStatus = wb_WBDataGet("currentstatus");
    var currObjLang = wb_WBDataGet("currentlanguage");
    var key = currObjName+":"+currObjStatus+":"+currObjLang;
    return key;
}

// initialize the webback list table
function wb_List_TableInit() {
    var globalRankAllowed = !wb_List_IsRankable();

    // build up the column data ----------
    var colsDynamic = [];

    // ID COLUMN
    colsDynamic.push({
        "sTitle": "ID",
        "sName": "ID",
        "mData": "ID",
        "bVisible": false
    });

    // STATUS COLUMN
    colsDynamic.push({
        "sTitle": "",
        "sName": "Status",
        "sClass": "wb-listcol-snug wb-listcol-status",
        "mData": "LastUpdated",
        "bSearchable": false,
        "bSortable": globalRankAllowed
    });

    // USER-SPECIFIED COLUMNS
    var userCols = wb_WBDataGet('listcols').split(',');
    var userLabels = wb_WBDataGet('listlabels').split(',');
    for (icol = 0; icol < userCols.length; icol++) {
        var colname = $.trim(userCols[icol]);
        var collabel = $.trim(userLabels[icol]);
        // automatically set nowrap on date
        var colclass = (collabel.toLowerCase().indexOf('date') >= 0) ? "wb-listcol-nowrap" : "";
        // build all the values for our column!
        var column = {
            "sTitle": collabel,
            "sName": colname.toLowerCase(),
            "sClass": colclass,
            "mData": "Values." + colname.toLowerCase(),
            "bSearchable": true,
            "bSortable": globalRankAllowed,
            "render": function (data,type,row,meta) {
                var valoriginal = data;
                var celloutput = data;
                // try to parse as a date and format using locale-specific logic
                var valmoment = moment(data, ['YYYY-MM-DD'], true);
                if (valmoment != null && valmoment.isValid()) {
                    // format using locale-specific logic
                    celloutput = "<span data-timestamp='" + data + "'>" + valmoment.format('ll') + "</span>";
                }
                return celloutput;
            }
        };
        colsDynamic.push(column);
    }

    // ACTIONS COLUMN
    colsDynamic.push({
        "sTitle": "",
        "sName": "Actions",
        "sClass": "wb-listcol-snug wb-listcol-actions",
        "mData": null,
        "bSearchable": false,
        "bSortable": false
    });

    // kick off the datatables plugin with server-side processing ---------------------
    var oTable = $('.datatable table').DataTable({
        "jQueryUI": false,
        "autoWidth": false,
        "deferRender": true,
        "pagingType": "full_numbers",
        "dom": '<"datatable-header"f><"datatable-filteradv"><"datatable-scroll"t><"datatable-footer"ipl>',
        "language": {
            "search": "<span>Filter:</span> _INPUT_",
            "lengthMenu": "<span>Show entries:</span> _MENU_",
            "paginate": {
                "first": "First",
                "last": "Last",
                "next": ">",
                "previous": "<"
            },
            "loadingRecords": "<span class='btn'><img class='wb-loader' src='../core/images/interface/loader.gif' alt='' />&nbsp;&nbsp;Loading...</span>"
        },
        "ajax": wb_List_AjaxServerSideUrlGet(),
        "processing": true,
        "serverSide": true,
        "order": [],
        "columns": colsDynamic,
        "rowCallback": wb_List_cbRowCallback,
        "stateSave": true,
        "stateLoadParams": wb_List_cbStateLoadParams,
        "stateSaveParams": wb_List_cbStateSaveParams
    });

    // configure javascript event handling for the resulting table!
    var wbTableRef = $('.wb-datatable-ajax table.dataTable');
    
    // hover event handling for the info icons
    wbTableRef.on('mouseover', '.wb-liststatus-hoverzone', function (evt) {
        $(this).addClass('open');
    });
    wbTableRef.on('mouseout', '.wb-liststatus-hoverzone', function (evt) {
        $(this).removeClass('open');
    });

    // configure each row so clicking on empty space will perform the default actions
    $('tbody', wbTableRef).on('click', 'tr', function (evt) {
        // see if the clicked spot was inside a link tag and it was a main button click
        var containinglink = $(evt.target).closest('a');
        if (containinglink.length <= 0 && (evt.which==1 || evt.which==0)) {
            // we clicked on a non-link ... dispatch to the default action if possible!
            var clickedrow = $(this);
            var actionitems = clickedrow.find('.wb-listaction-default');
            if (actionitems.length > 0) {
                var actionitem = $(actionitems[0]);
                var actionurl = actionitem.attr('href');
                if (actionitem.attr('data-toggle') != null) {
                    // we want clicks to handle the data-toggle
                    actionitem.click();
                }
                else {
                    // no data toggle, let's just take people to the link
                    window.location = actionurl;
                }
                return false;
            }
        }
        return true;
    });

    // configure "publish" action to be aware of stale checkouts
    $('tbody', wbTableRef).on('click', 'a.wb-listaction-publish', function (evt) {
        var recordrow = $(this).closest('tr.wb-listrow-checkout');
        if (recordrow.length == 1) {
            var checkout_tip = $('li.wb-listtip-checkout', recordrow);
            if (checkout_tip.length == 1) {
                var stale_status = checkout_tip.attr('data-wb-checkout-stale') == '1';
                if (stale_status) {
                    var dlgresult = confirm("WARNING\n\nThis draft is more than a week old and its associations to other WebBack records may now be out of date.\n\nPublish anyway?");
                    return dlgresult;
                }
            }
            return true;
        }
    });

    // configure "archive" action to have confirmation required
    $('tbody', wbTableRef).on('click', 'a.wb-listaction-archive', function (evt) {
        var dlgresult = confirm("ARCHIVE\n\nAre you sure you wish to archive this record?");
        return dlgresult;
    });

    return oTable;
}

// Callback function executed after state load, to modify the loaded params.
function wb_List_cbStateLoadParams(oSettings, oData) {
    // ignore save-states from different object/status/lang
    if (oData["sWBKey"] != wb_List_PageKeyGet()) {
        // return false forces a fresh start for settings
        return false;
    }
}

// Callback function executed after state change, to modify the saved params.
function wb_List_cbStateSaveParams(oSettings, oData) {
    // store unique key for this object/view/lang 
    oData["sWBKey"] = wb_List_PageKeyGet();

    // store the current state of our 'advanced filters'
    oData["aWBFilters"] = wb_List_FiltersGetState();

    // debug output of saved values!
    var output = '';
    for ( var key in oData ) {
        output += '['+key+'] = [' + oData[key] + ']\n\r';
    }
    //alert( 'wb_List_cbStateSaveParams:\n\n' + output);
}

// DataTables row callback
// This will be called once for each visible row after the DOM has been generated.
function wb_List_cbRowCallback(nRow, aData) {

    // ------ ACTIONS -----------
    // populate actions cell using #wbdata template replacement
    var actioncell = $('td.wb-listcol-actions', nRow);
    var tempStatus = wb_List_StatusGet();
    if(tempStatus=="private")
    {
        tempStatus = "active";
    }
    actioncell.html(wb_List_TemplateStatusFill(wb_WBDataGet("template-actions-"+tempStatus), aData));

    // ------ STATUS ------------
    // populate status cell using #wbdata template replacement
    var statuscell = $('td.wb-listcol-status', nRow);
    var statusoutput = wb_WBDataGet("template-status-active");
    // standard records
    statusoutput = wb_List_TemplateStatusFill(statusoutput, aData);
    // alt lang records
    statusoutput = wb_TemplateReplace(statusoutput, "altlangstatus", wb_List_MarkupAltLangStatusGet(aData));
    // actually drop the results into the status cell
    statuscell.html(statusoutput);

    // ------ CHECKOUTS ---------
    if (aData['Checkouts'].length > 0) {
        $(nRow).addClass('wb-listrow-checkout');
    }
}

// Take HTML content, plus an array of data, and perform template replacements using {fieldname} syntax.
function wb_List_TemplateStatusFill(template, data) {
    // all standard webback fields listed here
    var wbfields = ['ID', 'ArchiveID', 'LastUpdated', 'LangID', 'LangName'];
    var output = template;
    // loop and perform replace once for each field
    for (var i = 0; i < wbfields.length; i++) {
        var fieldname = wbfields[i];
        if (data[fieldname] != null) {
            var fieldvalue = data[fieldname];
            output = wb_TemplateReplace(output, fieldname, fieldvalue);

            // special custom replace for {lastupdatedago} and {lastupdatedcal}
            if (fieldname == "LastUpdated") {
                var updatemoment = moment(fieldvalue);
                output = wb_TemplateReplace(output, "lastupdatedago", updatemoment.fromNow());
                output = wb_TemplateReplace(output, "lastupdatedcal", updatemoment.calendar());
            }
            // special lowercase langname = {lang}, langcode = {langcode}
            if (fieldname == "LangName") {
                output = wb_TemplateReplace(output, "lang", fieldvalue.toLowerCase());
                output = wb_TemplateReplace(output, "langcode", wb_LangCodeGet(fieldvalue));
            }
        }
    }

    // -- {checkouts} --
    output = wb_TemplateReplace(output, "checkouts", wb_List_MarkupCheckoutsGet(data));

    // send back filled template
    return output;
}

// Return the finished HTML markup that should be show for the {checkouts} template tag
function wb_List_MarkupCheckoutsGet(data) {
    var output = "";
    var reclist = data['Checkouts'];
    if (reclist != null) {
        // loop through checkouts and populate our template with legit field values
        for (var i = 0; i < reclist.length; i++) {
            var singleitem = wb_WBDataGet("template-checkout");
            // loop through each field and replace in template
            for (var fieldkey in reclist[i]) {
                if (reclist[i][fieldkey] != null) {
                    var fieldvalue = reclist[i][fieldkey];
                    singleitem = wb_TemplateReplace(singleitem, fieldkey, fieldvalue);

                    // special custom replace for {dateago} and {datecal}
                    if (fieldkey == "Date") {
                        var momentobj = moment(fieldvalue);
                        if (momentobj != null) {
                            singleitem = wb_TemplateReplace(singleitem, "dateago", momentobj.fromNow());
                            singleitem = wb_TemplateReplace(singleitem, "datecal", momentobj.calendar());
                            var checkout_age_days = moment().diff(momentobj, 'days');
                            var stale_status = checkout_age_days > 7 ? 1 : 0;
                            singleitem = wb_TemplateReplace(singleitem, "stalestatus", stale_status);
                        }

                    }
                }
            }
            output += singleitem;
        }
    }
    return output;
}

// Return the finished HTML markup that should be shown for the {altlangrecords} template tag
function wb_List_MarkupAltLangStatusGet(data) {
    var output = "";
    var reclist = data['AltLangRecords'];
    if (reclist != null) {
        // loop through alt lang records and assemble a template for each one
        for (var i = 0; i < reclist.length; i++) {
            var singleitem = wb_WBDataGet("template-statuslang");
            // populate single template and add results to our output?
            output += wb_List_TemplateStatusFill(singleitem, reclist[i]);
        }
    }
    return output;
}
