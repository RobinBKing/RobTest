// EDITOR CONFIG defaults!
CKEDITOR.editorConfig = function (config) {
    // create an approximate 5-minute timestamp to allow caching after first call
    var mycurrtime = (new Date());
    var mycachestamp = mycurrtime.getMonth() + '-' + mycurrtime.getDate() + '-' + mycurrtime.getHours() + '-' + (mycurrtime.getMinutes() % 5);

    // CHAIN-CALL the custom definitions if necessary
    config.customConfig = '../../../custom/js/wb-ckeditor-custom.js?mod=' + mycachestamp;

    // basic settings
    config.uiColor = '#e6e6e6';
    config.toolbarCanCollapse = false;
    config.disableNativeSpellChecker = false;
    config.fillEmptyBlocks = false;

    // extra plugins (non-default)
    config.extraPlugins = 'stylesheetparser,label,wb-editor-form,extraformattributes,';

    if (!$.isArray(config.contentsCss)) {
        // we always want config.contentsCss to be an array!
        if (config.contentsCss != null && config.contentsCss != '') {
            // if we have base styles, put them into the array
            var strDefaultCssPath = config.contentsCss;
            config.contentsCss = [strDefaultCssPath];
        }
        else {
            // with no base styles, initialize to an empty array
            config.contentsCss = [];
        }
    }

    // file manager settings (ROXY FILEMAN)
    var ckFinderBase = '../core/lib/ckfinder/';
    var ckFinderConnectorBase = '../core/lib/ckfiles/';
    config.filebrowserBrowseUrl = ckFinderBase + 'CKFinderScripts/ckfinder.html?Type=WebFiles';
    config.filebrowserImageBrowseURL = ckFinderBase + 'CKFinderScripts/ckfinder.html?Type=Images';
    config.filebrowserFlashBrowseURL = ckFinderBase + 'CKFinderScripts/ckfinder.html?Type=Flash';
    config.filebrowserUploadUrl = ckFinderConnectorBase + 'connector?command=QuickUpload&type=WebFiles'
    config.filebrowserImageUploadUrl = ckFinderConnectorBase + 'connector?command=QuickUpload&type=Images';
    config.filebrowserFlashUploadUrl = ckFinderConnectorBase + 'connector?command=QuickUpload&type=Flash';

    // default toolbar is the basic one
    config.toolbar = 'basic';

    // BASIC TOOLBAR
    config.toolbar_basic = [
        { name: 'mode', items: ['Source', '-', 'Undo', 'Redo'] },
        { name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord'] },
        { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'RemoveFormat', '-', 'NumberedList', 'BulletedList'] },
        { name: 'insert', items: ['Link', 'Unlink', '-', 'Image', 'Table', 'SpecialChar'] }
    ];

    // ADVANCED TOOLBAR
    config.toolbar_full = [
	    { name: 'document', items: ['Source', 'Maximize', 'ShowBlocks'] },
        { name: 'tools', items: ['Undo', 'Redo'] },
	    { name: 'clipboard', items: ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', 'RemoveFormat', ] },
	    { name: 'links', items: ['Link', 'Unlink', 'Anchor'] },
	    { name: 'insert', items: ['Image', 'Table', 'SpecialChar', 'Flash'] },
	    '/',
	    { name: 'basicstyles', items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat'] },
	    { name: 'paragraph', items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'] },
	    '/',
	    { name: 'styles', items: ['Styles', 'Format', 'Font', 'FontSize', 'Templates'] },
	    { name: 'colors', items: ['TextColor'] },
        { name: 'forms', items: ['Wb-editor-form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'Label'] }
    ];

    // default 'extra' allowed content tags to prevent advanced editor styles from being stripped
    config.extraAllowedContent += ' span{*}; ';
    config.extraAllowedContent += ' div{*}; ';
    config.extraAllowedContent += ' p{text-align}; ';
    config.extraAllowedContent += ' a[*]{*}; ';
    config.extraAllowedContent += ' h1; h2; h3; h4; h5; h6; blockquote; '
    config.extraAllowedContent += ' sub; sup; s; pre{*}; ';
    config.extraAllowedContent += ' embed[*]{*}; object[*]{*}; ';
    config.extraAllowedContent += ' input[*]{*}; textarea[*]{*}; select[*]{*}; option[*]{*}; button[*]{*}; ';

    // template management
    config.templates_replaceContent = false;
    config.templates_files.push('../custom/js/templates.js');

    // ---------------------------------
    // WEBBACK SPECIFIC HELPER FUNCTIONS, attached to the config object so we can use in custom config files
    // ---------------------------------

    // Given a toolbar reference, add the 'toolname' to the given group
    config.wbToolAdd = function (bar, toolname, groupname) {
        if (bar != null) {
            var groupfound = false;
            // try to add to existing group
            for (var i = 0; i < bar.length && !groupfound; i++) {
                if (bar[i].name == groupname) {
                    groupfound = true;
                    bar[i].items.push(toolname);
                }
            }
            // if we didn't find existing group, create new one
            if (!groupfound) {
                bar.push({
                    name: groupname,
                    items: [toolname]
                });
            }
        }
    }

    // Given a toolbar reference, remove the 'toolname' from all groups
    config.wbToolRemove = function (bar, toolname) {
        if (bar != null) {
            for (var i = 0; i < bar.length; i++) {
                if (bar[i].items) {
                    // only check collections, not separators
                    var toolindex = bar[i].items.indexOf(toolname);
                    if (toolindex >= 0) {
                        bar[i].items.splice(toolindex, 1);
                    }
                }
            }
        }
    }

    // -----------------------------------
    // WEBBACK FORM EDITOR TEMPLATE
    // -----------------------------------
    config.wbFormTemplateGet = function (editor) {
        return '<div class="wb-editor-form">' +
            '<h3 class="wb-editor-form-title">Contact Us</h3>' +
            '<div class="wb-editor-form-content">' +
            '<table border="0" cellpadding="1" cellspacing="1" style="width:100%;">' +
                '<tbody>' +
                    '<tr>' +
                        '<td style="width: 100%;"><input class="wb-editor-form-element" required="required" name="fullname" type="text" PlaceHolder="Name *" /></td>' +
                    '</tr>' +
                    '<tr>' +
                        '<td style="width: 100%;"><input class="wb-editor-form-element" required="required" name="email" type="email" PlaceHolder="Email *" /></td>' +
                    '</tr>' +
                    '<tr>' +
                        '<td style="width: 100%;"><input class="wb-editor-form-element" name="company" type="text" PlaceHolder="Company" /></td>' +
                    '</tr>' +
                    '<tr>' +
                        '<td style="width: 100%;"><textarea class="wb-editor-form-element" id="message" name="message" cols="30" rows="5" PlaceHolder="Enter Your Message"></textarea></td>' +
                    '</tr>' +
                    '<tr>' +
                        '<td style="width: 100%;"><input class="wb-editor-form-element" name="submit" type="submit" value="Send" /></td>' +
                    '</tr>' +
                '</tbody>' +
            '</table>' +
            '</div>' +
            '</div>';
    }

};
