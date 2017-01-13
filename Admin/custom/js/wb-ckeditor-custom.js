// Custom Editor Config
// Values here will be added on top of the defaults from WebBack core (not a total replace).
// Reference: http://docs.ckeditor.com/#!/api/CKEDITOR.config

CKEDITOR.editorConfig = function (config) {

    // ---- CUSTOM STYLESHEET? INCLUDE LIKE THIS
    // config.contentsCss.push('/styles/filename.css');

    // ---- NEED EXTRA PLUGINS? USE "+=" AND END YOUR ADDITIONS WITH A COMMA
    // config.extraPlugins += 'custom-plugin-name,';

    // ---- NEED TO ADD/REMOVE TOOLBAR TOOLS?
    // ---- (reference to default setup is in /admin/core/js/wb-ckeditor-default.js)
    // config.wbToolAdd( config.toolbar_full, 'ToolName', 'group' );
    // config.wbToolRemove( config.toolbar_full, 'ToolName' );

    // ---- NEED TO CUSTOMIZE THE DEFAULT 'USER FORM' TEMPLATE? RETURN HTML FROM THIS FUNCTION
    // ---- (reference is in /admin/core/js/wb-ckeditor-default.js)
    // config.wbFormTemplateGet = function (editor) { return 'html here';}

}