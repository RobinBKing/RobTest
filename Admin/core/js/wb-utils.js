/* #  General purpose utility functions and extensions
   #  for WebBack, we like to prefix these with "wb_"
   #  if possible to keep things neat... 
   #  03/12/2014
====================================================== */

// webback-supported language code table
var wb_LangCodes = {
    "arabic": "ar",
    "bengali": "bn",
    "dutch": "nl",
    "english": "en",
    "cantonese": "cn",
    "chinese": "zh",
    "farsi": "fa",
    "french": "fr",
    "german": "de",
    "gujarati": "gu",
    "greek": "el",
    "hebrew": "he",
    "hindi": "hi",
    "italian": "it",
    "japanese": "jp",
    "javanese": "jv",
    "korean": "ko",
    "malay": "ms",
    "mandarin": "zh",
    "marathi": "mr",
    "polish": "pl",
    "portuguese": "pt",
    "punjabi": "pa",
    "russian": "ru",
    "spanish": "es",
    "tamil": "ta",
    "telugu": "te",
    "thai": "th",
    "turkish": "tr",
    "urdu": "ur",
    "vietnamese": "vi"
};

// get a langcode from a supplied language name
function wb_LangCodeGet(langname) {
    var langlower = langname.toLowerCase();
    var code = wb_LangCodes[langlower];
    if (code == null) {
        code = wb_LangCodes["english"];
    }
    return code;
}

// get a value from the #wbdata section
function wb_WBDataGet(key) {
    var node = $('#wbdata .wbdata-' + key);
    if (node.length == 1) {
        return node.html();
    }
    else {
        return "";
    }
}

// Get the value of a named parameter from the query string
function wb_QueryString(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)", "i");
    var results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

// Template replace function to replace {tagname} tag with the given value
function wb_TemplateReplace(template, tagname, value) {
    var templateregex = new RegExp("\{" + tagname + "\}", "gi");
    return template.replace(templateregex, value);
}

// basic hotkey binding function for an entire page
function wb_HotKey(keyCombo, fnHandler) {
    $(document).on('keydown', null, keyCombo, function (evt) {
        evt.stopPropagation();
        fnHandler();
        return false;
    });
}

// add enter-to-submit functionality to an element
// pass in the element you wish to be 'clicked' when enter is pressed
jQuery.fn.satEnterSubmit = function (submitelement) {
    return this.each(function (idx) {
        jQuery(this).keypress(function (e) {
            if (e.keyCode == 13) {
                if (jQuery(submitelement).is('a') && jQuery(submitelement).attr('href').indexOf('javascript:__doPostBack(') == 0) {
                    // POSTBACK LINK CLICKS!
                    eval(jQuery(submitelement).attr('href'));
                } else {
                    jQuery(submitelement).click();
                }
                return false;
            }
        });
    });
};



/* BEGIN JQUERY HOTKEYS PLUGIN ======================================================================== */
/*
* jQuery Hotkeys Plugin
* Copyright 2010, John Resig
* Dual licensed under the MIT or GPL Version 2 licenses.
*
* Based upon the plugin by Tzury Bar Yochay:
* http://github.com/tzuryby/hotkeys
*
* Original idea by:
* Binny V A, http://www.openjs.com/scripts/events/keyboard_shortcuts/
*/

(function (jQuery) {

    jQuery.hotkeys = {
        version: "0.8",

        specialKeys: {
            8: "backspace", 9: "tab", 13: "return", 16: "shift", 17: "ctrl", 18: "alt", 19: "pause",
            20: "capslock", 27: "esc", 32: "space", 33: "pageup", 34: "pagedown", 35: "end", 36: "home",
            37: "left", 38: "up", 39: "right", 40: "down", 45: "insert", 46: "del",
            96: "0", 97: "1", 98: "2", 99: "3", 100: "4", 101: "5", 102: "6", 103: "7",
            104: "8", 105: "9", 106: "*", 107: "+", 109: "-", 110: ".", 111: "/",
            112: "f1", 113: "f2", 114: "f3", 115: "f4", 116: "f5", 117: "f6", 118: "f7", 119: "f8",
            120: "f9", 121: "f10", 122: "f11", 123: "f12", 144: "numlock", 145: "scroll", 191: "/", 224: "meta"
        },

        shiftNums: {
            "`": "~", "1": "!", "2": "@", "3": "#", "4": "$", "5": "%", "6": "^", "7": "&",
            "8": "*", "9": "(", "0": ")", "-": "_", "=": "+", ";": ": ", "'": "\"", ",": "<",
            ".": ">", "/": "?", "\\": "|"
        }
    };

    function keyHandler(handleObj) {
        // Only care when a possible input has been specified
        if (typeof handleObj.data !== "string") {
            return;
        }

        var origHandler = handleObj.handler,
			keys = handleObj.data.toLowerCase().split(" ");

        handleObj.handler = function (event) {
            // Don't fire in text-accepting inputs that we didn't directly bind to
            if (this !== event.target && (/textarea|select/i.test(event.target.nodeName) ||
				 event.target.type === "text")) {
                // 06/24/2014 - Brian removed so we get hotkeys everywhere
                //return;
            }

            // Keypress represents characters, not special keys
            var special = event.type !== "keypress" && jQuery.hotkeys.specialKeys[event.which],
				character = String.fromCharCode(event.which).toLowerCase(),
				key, modif = "", possible = {};

            // check combinations (alt|ctrl|shift+anything)
            if (event.altKey && special !== "alt") {
                modif += "alt+";
            }

            if (event.ctrlKey && special !== "ctrl") {
                modif += "ctrl+";
            }

            // TODO: Need to make sure this works consistently across platforms
            if (event.metaKey && !event.ctrlKey && special !== "meta") {
                modif += "meta+";
            }

            if (event.shiftKey && special !== "shift") {
                modif += "shift+";
            }

            if (special) {
                possible[modif + special] = true;

            } else {
                possible[modif + character] = true;
                possible[modif + jQuery.hotkeys.shiftNums[character]] = true;

                // "$" can be triggered as "Shift+4" or "Shift+$" or just "$"
                if (modif === "shift+") {
                    possible[jQuery.hotkeys.shiftNums[character]] = true;
                }
            }

            for (var i = 0, l = keys.length; i < l; i++) {
                if (possible[keys[i]]) {
                    return origHandler.apply(this, arguments);
                }
            }
        };
    }

    jQuery.each(["keydown", "keyup", "keypress"], function () {
        jQuery.event.special[this] = { add: keyHandler };
    });

})(jQuery);
/* END JQUERY HOTKEYS PLUGIN ======================================================================== */
