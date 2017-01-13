// WebBack Ajax Uploader Event Trigger mechanism
// This is going to get called from iframes!
function wbau_ext_trigger(uploaderid,data)
{
    alert('WBAU/Parent/Trigger\n\nID: '+uploaderid+'\nAction: '+data.action+'\nSuccess: '+data.success);
}



// WebBack Ajax Uploader plugin for jQuery
// ---------------------------------------
// 01/12/2015 - Brian B - started
//
// ---------------------------------------
// This plugin should be called on a 
jQuery.fn.wbAjaxUploader = function (opts) {
    return this.each(function (idx) {
        
    });
};