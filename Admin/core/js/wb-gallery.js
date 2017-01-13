// initial automatic actions taken when this plugin is loaded
jQuery(document).ready(function () {

    // configure all the gallery controls we find on the page
    jQuery('ul.wbg-list').wbGallery({
        // options go here, none by default
    });

});



// ========================================
// WebBack Gallery jQuery plugin
// ----------------------------------------
// Plugins used/tested: 
//  jQuery 1.10.1
//  jQueryUI 1.10.2
// ----------------------------------------
// 04/14/2015 - Brian created, based on old code
// ========================================
(function ($) {

    // plugin main function def
    $.fn.wbGallery = function (options) {

        // execute plugin on each passed member
        this.each(function (idx) {
            var list = $(this);
            var panel = list.closest('.wbg-panel');

            // READ OPTIONS
            var opts = $.extend({}, $.fn.wbGallery.defaults, getAttrOptions(list), options);

            // DO WORK
            if (!panel.hasClass('wbg-panel-readonly')) {
                configure(list, opts);
            }

        }); // .each()

        // send back for chaining
        return this;
    }

    // configure dynamic behaviors of the galleries
    function configure(list, opts) {
        // make sure initial display is safe for FKEY fields used as titles
        $('select.wbg-select-istitle', list).each(function () {
            $(this).closest('li.wbg-item').find('.wbg-titleecho').html('Loading&hellip;');
        });

        // attach various events/handlers
        configureAdd(list, opts);
        configureDelete(list, opts);
        configureEdit(list, opts);
        configureSave(list, opts);
        configureSort(list, opts);
        configureUpload(list, opts);

        // start the foreign key data load on a delay
        setTimeout(function () {
            configureForeignKeyData(list, opts);
        }, 200);
    }

    function configureAdd(list, opts) {
        // gather references
        var galwbid = list.attr('data-wbg-wbid');
        var galname = list.attr('data-wbg-name');
        var panel = list.closest('.wbg-panel');

        // populate click handler for the button
        panel.on('click', '.wbg-addbutton', function (evt) {
            var actionbtn = $(this);

            // assemble our package for the AJAX request
            var ajaxData = {
                wbid: galwbid,
                name: galname,
            };

            // fire off our save command!
            var xhr = $.ajax({
                type: 'POST',
                url: opts.urlProcess,
                data: $.extend({}, getDefaultAjaxParams(opts), ajaxData, {
                    action: 'gallery_add'
                })
            });

            // response handler
            xhr.done(function (data, textStatus, jqXHR) {
                if (data.Success) {
                    var newid = -1;
                    try {
                        newid = data.Data.id;
                    }
                    catch (parseEx) {
                        // we can ignore exceptions
                    }

                    // dispatch the actual creation code only if we got a good ID
                    if (newid > 0) {
                        prepNewItem(list, newid, '', '');
                    }
                    else {
                        alert('New item could not be added.');
                        return false;
                    }
                }
                else {
                    alert("Add failed!\n\n" + data.ErrorMessage);
                }
            });

            // response handler for unexplained fail?
            xhr.fail(function (data, textStatus, jqXHR) {
                alert('WebBack gallery error on "add".');
            });

            return false;
        }); // on()
    }

    function configureDelete(list, opts) {
        // gather references
        var galwbid = list.attr('data-wbg-wbid');
        var galname = list.attr('data-wbg-name');

        // populate click handler for the button
        list.on('click', 'a.wbg-deletebutton', function (evt) {
            var actionbtn = $(this);
            var galitem = actionbtn.closest('li.wbg-item');
            var galitemid = galitem.attr('data-wbg-id');

            // make user confirm the click!
            var useragrees = confirm("Permanently remove this item?");
            if (!useragrees) {
                return false;
            }

            // assemble our package for the AJAX request
            var ajaxData = {
                wbid: galwbid,
                name: galname,
                itemid: galitemid
            };

            // fire off our command!
            var xhr = $.ajax({
                type: 'POST',
                url: opts.urlProcess,
                data: $.extend({}, getDefaultAjaxParams(opts), ajaxData, {
                    action: 'gallery_delete'
                })
            });

            // response handler
            xhr.done(function (data, textStatus, jqXHR) {
                if (data.Success) {
                    // fade the item out... 
                    galitem.slideUp(500, function () {
                        // ... then remove from the DOM tree!
                        galitem.empty().remove();
                        // after removal, refresh our sortable list
                        list.sortable('refresh');
                    });
                }
                else {
                    alert("Delete failed!\n\n" + data.ErrorMessage);
                }
            });

            // response handler for unexplained fail?
            xhr.fail(function (data, textStatus, jqXHR) {
                alert('WebBack gallery error on "delete".');
            });

            return false;
        }); // on()
    }

    function configureEdit(list, opts) {
        // click event to toggle the edit panel
        list.on('click', 'a.wbg-editbutton', function (evt) {
            var galitem = $(this).closest('li.wbg-item');
            var editpanel = $('.wbg-editpanel', galitem);
            editpanel.slideToggle(100, function () {
                if ($(this).is(':visible')) {
                    // when showing the panel, try to focus the first text field
                    var firstinput = $(this).find('input').first().focus().select();

                    // if there are any text areas, make sure they have a rich text editor
                    var textfields = editpanel.find('.wbg-field[data-wbg-type="text"]').not('.wbg-editor-loaded');
                    textfields.each(function (idx) {
                        $(this).addClass('wbg-editor-loaded');
                        var rawtextarea = $(this).find('textarea');

                        // our "standard" config settings
                        var defaultconfig = {
                            autoParagraph: true,
                            uiColor: '#e6e6e6',
                            disableNativeSpellChecker: false,
                            fillEmptyBlocks: false,
                            toolbar: [{
                                name: 'basic',
                                items: ['Source', '-', 'Bold', 'Italic', 'Underline', 'RemoveFormat', '-', 'BulletedList', 'Link', 'Unlink']
                            }]
                        };

                        // optional custom config from jquery data
                        var customconfig = list.data('wbg-editor-custom');

                        // final config will be combination of both!
                        var finalconfig = $.extend({}, defaultconfig, customconfig);

                        // actually build the CKEditor!
                        CKEDITOR.replace(rawtextarea.attr('id'), finalconfig);
                    });
                }
            });
            return false;
        });

        // key handler to intercept keyboard behaviors within the edit fields
        list.on('keydown', 'input.wbg-text, input.wbg-checkbox', function (evt) {
            // keycode
            var key = evt.keyCode ? evt.keyCode : evt.which;
            if (key == 9 || key == 16 || key == 17 || key == 18 || key == 20 || key == 27 || (key >= 33 && key <= 40)) {
                // do nothin, these keys don't actually change stuff
            }
            else if (key == 13) {
                // ENTER key ... click the save button
                $(this).closest('.wbg-editpanel').find('.wbg-savebutton').click();
                return false;
            }
            else {
                // for other keys.. mark content as changed
                $(this).closest('.wbg-editpanel').removeClass('wbg-nochanges');
            }
        });
    }

    function configureSave(list, opts) {
        // gather references
        var galwbid = list.attr('data-wbg-wbid');
        var galname = list.attr('data-wbg-name');

        // populate click handler for the save button
        list.on('click', 'a.wbg-savebutton', function (evt) {
            var actionbtn = $(this);
            var galitem = actionbtn.closest('li.wbg-item');
            var galitemid = galitem.attr('data-wbg-id');
            var echotitle = '';

            // get reference to our echo element
            var echospan = galitem.find('.wbg-statusecho');
            // notify user that we're saving!
            echospan.html('&nbsp;Saving...').stop().fadeTo(0, 1.0);

            // assemble our package for the AJAX request
            var ajaxData = {
                wbid: galwbid,
                name: galname,
                itemid: galitemid
            };

            // collect all field values
            var allfields = galitem.find('.wbg-field');
            allfields.each(function (findex) {
                var field = $(this);
                var ftype = field.attr('data-wbg-type');
                var fcolname = field.attr('data-wbg-column');
                var fvalue = '';
                var fvaluetext = '';

                // pull the value out depending on the datatype
                switch (ftype) {
                    case 'string':
                        fvalue = field.find('input').val();
                        break;
                    case 'text':
                        fvalue = field.find('textarea').val();
                        if (field.hasClass('wbg-editor-loaded')) {
                            var ftextarea = field.find('textarea');
                            var feditor = CKEDITOR.instances[ftextarea.attr('id')];
                            fvalue = feditor.getData();
                        }
                        break;
                    case 'checkbox':
                        fvalue = field.find('input').is(':checked') ? 1 : 0;
                        break;
                    case 'fkey':
                        var fselect = field.find('select');
                        fvalue = fselect.val();
                        fvaluetext = $(':selected', fselect).text();
                        break;
                    default:
                        break;
                }

                // save the first field value as the title
                if (findex == 0) {
                    echotitle = fvalue;
                    if (fvaluetext != '') {
                        echotitle = fvaluetext;
                    }
                }

                // add the value to our array-like object
                var fkey = 'field_' + ftype + '_' + fcolname;
                ajaxData[fkey] = fvalue;
            });

            // fire off our save command!
            var xhr = $.ajax({
                type: 'POST',
                url: opts.urlProcess,
                data: $.extend({}, getDefaultAjaxParams(opts), ajaxData, {
                    action: 'gallery_update'
                })
            });

            // response handler
            xhr.done(function (data, textStatus, jqXHR) {
                if (data.Success) {
                    // re-set the 'no changes' flag on the edit panel
                    actionbtn.closest('.wbg-editpanel').addClass('wbg-nochanges');
                    // the save is finished! echo status and slide back away			
                    galitem.find('.wbg-titleecho').html(echotitle);
                    echospan.html('<span class="text-success">Saved OK</span>').stop().fadeTo(1000, 0.0, function () {
                        actionbtn.closest('.wbg-editpanel').slideUp(100);
                    });
                }
                else {
                    echospan.html('<span class="text-danger">Save failed - ' + data.ErrorMessage + "</span>");
                }
            });

            // response handler for unexplained fail?
            xhr.fail(function (data, textStatus, jqXHR) {
                alert('WebBack gallery error on "save".');
            });

            return false;
        }); // on()
    }

    function configureSort(list, opts) {
        // gather references
        var galwbid = list.attr('data-wbg-wbid');
        var galname = list.attr('data-wbg-name');

        // dispatch the sortable plugin
        list.sortable({
            handle: '.wbg-handle',
            placeholder: 'wbg-placeholder',
            forcePlaceholderSize: true,
            items: '>li:gt(0)',
            update: function () {
                // assemble our package for the AJAX request
                var ajaxData = {
                    wbid: galwbid,
                    name: galname,
                    sort: list.sortable('toArray')
                };

                jQuery.ajax({
                    type: 'POST',
                    url: opts.urlProcess,
                    data: $.extend({}, getDefaultAjaxParams(opts), ajaxData, {
                        action: 'gallery_sort'
                    })
                });
            }
        });
    }

    function configureUpload(list, opts) {
        // gather references
        var galwbid = list.attr('data-wbg-wbid');
        var galname = list.attr('data-wbg-name');
        var panel = list.closest('.wbg-panel');
        var actionbtn = panel.find('a.wbg-uploadbutton');
        var statuselement = panel.find('.wbg-uploadstatus');

        // assemble our package for the AJAX requests
        var ajaxData = {
            wbid: galwbid,
            name: galname,
        };

        // create our uploader using plupload
        var uploader = new plupload.Uploader({
            browse_button: actionbtn.get(0),
            url: opts.urlProcess,
            runtimes: 'html5,html4',
            filters: {
                mime_types: [
                    { title: "Image files", extensions: "jpg,jpeg,gif,png" }
                ]
            },
            multipart_params: $.extend({}, getDefaultAjaxParams(opts), ajaxData, {
                action: 'gallery_upload'
            })
        });

        // initialize and set up events for basic action
        uploader.init();

        // ADD queues the file and prints out a message
        uploader.bind('FilesAdded', function (up, files) {
            var html = '';
            plupload.each(files, function (file) {
                html += '<span data-id="' + file.id + '">[' + file.name + ' <b>0%</b>]</span>';
            });
            statuselement.html(html);
            // automatically start, each time a file is added
            uploader.start();
        });

        // PROGRESS updates the view with an upload percentage
        uploader.bind('UploadProgress', function (up, file) {
            statuselement.find('[data-id="' + file.id + '"] b').html(file.percent + '%');
        });

        // COMPLETE
        uploader.bind('FileUploaded', function (up, file, respObj) {
            // remove the item from upload echo area
            statuselement.find('[data-id="' + file.id + '"]').delay(1500).fadeOut(1500, function () {
                $(this).empty().remove();
            });
            // get our JSON response back in expected format
            var data = $.parseJSON(respObj.response);
            if (data.Success) {
                var newid = -1;
                try {
                    newid = data.Data.id
                }
                catch (parseEx) {
                    // we can ignore exceptions
                }

                // dispatch the actual creation code only if we got a good ID
                if (newid > 0) {
                    prepNewItem(list, newid, data.Data.image, data.Data.imagethumb);
                }
                else {
                    alert('New upload item could not be added.');
                }
            }
            else {
                alert("Upload failed!\n\n" + data.ErrorMessage);
            }
        });

        // ERROR
        uploader.bind('Error', function (up, err) {
            alert('Upload failed with plupload error #' + err.code);
        });
    }

    // attempt to load fkdata for anything we find in this gallery
    function configureForeignKeyData(list, opts) {
        var fkfields = $('div.wbg-field[data-wbg-fkeyobject][data-wbg-fkeyobject!=""]', list);
        for (var i = 0; i < fkfields.length; i++) {
            // look for unique types that we haven't already started loading
            var fkobjectname = fkfields.eq(i).attr('data-wbg-fkeyobject');
            if (!$.fn.wbGallery.fkdata.hasOwnProperty(fkobjectname)) {
                // this type is not already loaded (or being loaded)!
                // create a marker entry in our data collection
                $.fn.wbGallery.fkdata[fkobjectname] = [];

                // assemble our package for the AJAX request
                var ajaxData = {
                    fkobject: fkobjectname
                };

                // now start the load process
                var xhr = $.ajax({
                    type: 'GET',
                    url: opts.urlProcess,
                    data: $.extend({}, getDefaultAjaxParams(opts), ajaxData, {
                        action: 'gallery_getfkeydata'
                    })
                });

                // response handler
                xhr.done(function (data, textStatus, jqXHR) {
                    if (data.Success) {
                        // pull the values from the data and get them into memory
                        var fkobject = data.Data.fkobject;
                        var recs = data.Data.recs;
                        $.fn.wbGallery.fkdata[fkobject] = recs;
                        // now populate!
                        populateForeignKeyItems(list, fkobject);
                    }
                    else {
                        alert("Failed to load data for gallery!\n\n" + data.ErrorMessage);
                    }
                });

                // response handler for unexplained fail?
                xhr.fail(function (data, textStatus, jqXHR) {
                    alert('WebBack gallery error on "getfkeydata".');
                });
            }
        }
    }

    // actually build any markup/info for a newly added item
    function prepNewItem(list, newid, newimage, newthumb) {
        // gather references, we'll use the first (invisible) list item as a template
        var templateitem = list.children('li').first();

        // clone the new item, set its proper ID, and blank its data
        var newitem = templateitem.clone();
        newitem.attr('id', 'wbg-item-' + newid);
        newitem.attr('data-wbg-id', newid);
        $('.wbg-text', newitem).val('');

        // set form element names and IDs based on the item and column name
        var newfields = newitem.find('.wbg-field');
        newfields.each(function (idx) {
            var newfield = $(this);
            var newtype = newfield.attr('data-wbg-type');
            var newcol = newfield.attr('data-wbg-column');
            var newfieldid = 'wbg-' + newid + '-' + newcol;
            var newfieldel = $([]);
            switch (newtype) {
                case 'string':
                case 'checkbox':
                    newfieldel = newfield.find('input');
                    break;
                case 'text':
                    newfieldel = newfield.find('textarea');
                    break;
                case 'fkey':
                    newfieldel = newfield.find('select');
                    break;
                default:
                    break;
            };
            newfieldel.attr('id', newfieldid);
            newfieldel.attr('name', newfieldid);
        });

        // we may need to configure images
        if (list.attr('data-wbg-hasimage') == 'true') {
            var imagepanel = newitem.find('.wbg-displayimage');
            var imageroot = imagepanel.attr('data-wbg-imgroot');
            var imagepath = imageroot + newimage;
            var imagethumbpath = imageroot + newthumb;
            // save refs to the correct image paths
            imagepanel.find('a.wbg-imagethumblink').attr('href', imagepath);
            imagepanel.find('img.wbg-imagethumb').attr('src', imagethumbpath);
        }

        // refresh the sortable list to include it!
        list.sortable('refresh');

        // actually display our new item!
        list.append(newitem);
        newitem.show();

        // open the edit panel ^_^
        list.children('li').last().find('a.wbg-editbutton').click();
    }

    // attempt to populate any existing fields with foreign key data for this object type
    function populateForeignKeyItems(list, fkobject) {
        var fkfields = $('div.wbg-field[data-wbg-fkeyobject="' + fkobject + '"]');
        fkfields.each(function (idx) {
            // pull some attributes for safety
            var field = $(this);
            var loader = $('.wbg-select-loading', field);
            var select = $('select.wbg-select-preinit', field);
            if (select.length == 1) {
                var initialvalue = select.attr('data-initial-value');

                // grab the data for this type
                var listvals = $.fn.wbGallery.fkdata[fkobject];

                // prepare collection of new options to create
                var realvaluefound = false;
                var newoptions = [];
                newoptions.push('<option selected value="' + initialvalue + '">N/A</option>');

                // loop through and set values!
                for (var i = 0; i < listvals.length; i++) {
                    var listitem = listvals[i];
                    newoptions.push('<option value="' + listitem.value + '">' + listitem.text + '</option>');
                    if (listitem.value == initialvalue) {
                        // we found the real value for this 
                        realvaluefound = true;
                    }
                }

                // plow all our new items into the dropdown
                select.html(newoptions.join(''));
                if (realvaluefound) {
                    // if real value was found, "clear" the default item before we mark a selection
                    $('option:first', select).attr('value', '-1').removeAttr('selected');
                }
                select.val(initialvalue);

                // remove the loader and show the actual select item
                loader.remove();
                select.removeClass('wbg-select-preinit');

                // update the echo title if necessary
                if (select.hasClass('wbg-select-istitle')) {
                    var titleelement = select.closest('.wbg-item').find('.wbg-titleecho');
                    titleelement.html($(':selected', select).text());
                }
            }
        });
    }

    // Given a set of key/value mappings, return the ones that we always need for our ajax calls
    function getDefaultAjaxParams(vals) {
        var ajaxKeys = ['object', 'wbid', 'name'];
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
        for (var attrKey in $.fn.wbGallery.defaults) {
            var translatedKey = 'data-wbg-' + attrKey.toLowerCase()
            var attrVal = elm.attr(translatedKey);
            if (attrVal != null && attrVal != '') {
                if (attrKey.toLowerCase().indexOf('is') == 0 || attrKey.toLowerCase().indexOf('has') == 0) {
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
    $.fn.wbGallery.defaults = {
        object: '',
        wbid: -1,
        name: '',
        itemid: -1,
        hasImage: false,
        urlProcess: '../core/ajax/WBAjaxPage.aspx'
    };

    // foreign key data placeholder, initially empty, should contain arrays of {value,text} objects
    $.fn.wbGallery.fkdata = [];

}(jQuery));