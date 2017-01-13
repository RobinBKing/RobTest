CKEDITOR.plugins.add('wb-editor-form', {
    requires: 'widget',
    icons: 'wb-editor-form',
    init: function (editor) {

        // set up required stylesheets
        editor.addContentsCss(this.path + 'styles/wbform.css');

        // pull our custom raw template content
        var rawTemplate = editor.config.wbFormTemplateGet(editor);

        // add the configured widget
        editor.widgets.add('wb-editor-form', {
            button: 'Create a Webback Form',
            template: rawTemplate,
            editables: {
                title: {
                    selector: '.wb-editor-form-title'//,
                  //  allowedContent: 'br strong em'
                },
                content: {
                    selector: '.wb-editor-form-content'//,
                   // allowedContent: 'p br ul ol li strong em'
                }
            },
            requiredContent: 'div(wb-editor-form)',
            upcast: function (element) {
                return element.name == 'div' && element.hasClass('wb-editor-form');
            }
        });
    }
});