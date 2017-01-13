﻿/*****************/
/* Custom Select */
/*****************/
/*! Selectric ÏŸ v1.10.1 (2016-06-30) - git.io/tjl9sQ - Copyright (c) 2016 Leonardo Santos - MIT License */
! function (e) {
    "function" == typeof define && define.amd ? define(["jquery"], e) : "object" == typeof module && module.exports ? module.exports = function (t, s) {
        return void 0 === s && (s = "undefined" != typeof window ? require("jquery") : require("jquery")(t)), e(s), s
    } : e(jQuery)
}(function (e) {
    "use strict";
    var t = e(document),
        s = e(window),
        i = "selectric",
        n = "Input Items Open Disabled TempShow HideSelect Wrapper Focus Hover Responsive Above Scroll Group GroupLabel",
        l = ".sl",
        o = ["a", "e", "i", "o", "u", "n", "c", "y"],
        a = [/[\xE0-\xE5]/g, /[\xE8-\xEB]/g, /[\xEC-\xEF]/g, /[\xF2-\xF6]/g, /[\xF9-\xFC]/g, /[\xF1]/g, /[\xE7]/g, /[\xFD-\xFF]/g],
        r = function (t, s) {
            var i = this;
            i.element = t, i.$element = e(t), i.state = {
                enabled: !1,
                opened: !1,
                currValue: -1,
                selectedIdx: -1
            }, i.eventTriggers = {
                open: i.open,
                close: i.close,
                destroy: i.destroy,
                refresh: i.refresh,
                init: i.init
            }, i.init(s)
        };
    r.prototype = {
        utils: {
            isMobile: function () {
                return /android|ip(hone|od|ad)/i.test(navigator.userAgent)
            },
            escapeRegExp: function (e) {
                return e.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")
            },
            replaceDiacritics: function (e) {
                for (var t = a.length; t--;) e = e.toLowerCase().replace(a[t], o[t]);
                return e
            },
            format: function (e) {
                var t = arguments;
                return ("" + e).replace(/\{(?:(\d+)|(\w+))\}/g, function (e, s, i) {
                    return i && t[1] ? t[1][i] : t[s]
                })
            },
            nextEnabledItem: function (e, t) {
                for (; e[t = (t + 1) % e.length].disabled;);
                return t
            },
            previousEnabledItem: function (e, t) {
                for (; e[t = (t > 0 ? t : e.length) - 1].disabled;);
                return t
            },
            toDash: function (e) {
                return e.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase()
            },
            triggerCallback: function (t, s) {
                var n = s.element,
                    l = s.options["on" + t];
                e.isFunction(l) && l.call(n, n, s), e.fn[i].hooks[t] && e.each(e.fn[i].hooks[t], function () {
                    this.call(n, n, s)
                }), e(n).trigger(i + "-" + this.toDash(t), s)
            }
        },
        init: function (t) {
            var s = this;
            if (s.options = e.extend(!0, {}, e.fn[i].defaults, s.options, t), s.utils.triggerCallback("BeforeInit", s), s.destroy(!0), s.options.disableOnMobile && s.utils.isMobile()) return void (s.disableOnMobile = !0);
            s.classes = s.getClassNames();
            var n = e("<input/>", {
                "class": s.classes.input,
                readonly: s.utils.isMobile()
            }),
                l = e("<div/>", {
                    "class": s.classes.items,
                    tabindex: -1
                }),
                o = e("<div/>", {
                    "class": s.classes.scroll
                }),
                a = e("<div/>", {
                    "class": s.classes.prefix,
                    html: s.options.arrowButtonMarkup
                }),
                r = e("<span/>", {
                    "class": "label"
                }),
                p = s.$element.wrap("<div/>").parent().append(a.prepend(r), l, n);
            s.elements = {
                input: n,
                items: l,
                itemsScroll: o,
                wrapper: a,
                label: r,
                outerWrapper: p
            }, s.$element.on(s.eventTriggers).wrap('<div class="' + s.classes.hideselect + '"/>'), s.originalTabindex = s.$element.prop("tabindex"), s.$element.prop("tabindex", !1), s.populate(), s.activate(), s.utils.triggerCallback("Init", s)
        },
        activate: function () {
            var e = this,
                t = e.$element.width();
            e.utils.triggerCallback("BeforeActivate", e), e.elements.outerWrapper.prop("class", [e.classes.wrapper, e.$element.prop("class").replace(/\S+/g, e.classes.prefix + "-$&"), e.options.responsive ? e.classes.responsive : ""].join(" ")), e.options.inheritOriginalWidth && t > 0 && e.elements.outerWrapper.width(t), e.$element.prop("disabled") ? (e.elements.outerWrapper.addClass(e.classes.disabled), e.elements.input.prop("disabled", !0)) : (e.state.enabled = !0, e.elements.outerWrapper.removeClass(e.classes.disabled), e.$li = e.elements.items.removeAttr("style").find("li"), e.bindEvents()), e.utils.triggerCallback("Activate", e)
        },
        getClassNames: function () {
            var t = this,
                s = t.options.customClass,
                i = {};
            return e.each(n.split(" "), function (e, n) {
                var l = s.prefix + n;
                i[n.toLowerCase()] = s.camelCase ? l : t.utils.toDash(l)
            }), i.prefix = s.prefix, i
        },
        setLabel: function () {
            var t = this,
                s = t.options.labelBuilder,
                i = t.lookupItems[t.state.currValue];
            t.elements.label.html(e.isFunction(s) ? s(i) : t.utils.format(s, i))
        },
        populate: function () {
            var t = this,
                s = t.$element.children(),
                i = t.$element.find("option"),
                n = i.index(i.filter(":selected")),
                l = 0;
            t.state.currValue = t.state.selected = ~n ? n : 0, t.state.selectedIdx = t.state.currValue, t.items = [], t.lookupItems = [], s.length && (s.each(function (s) {
                var i = e(this);
                if (i.is("optgroup")) {
                    var n = {
                        element: i,
                        label: i.prop("label"),
                        groupDisabled: i.prop("disabled"),
                        items: []
                    };
                    i.children().each(function (s) {
                        var i = e(this),
                            o = i.html();
                        n.items[s] = {
                            index: l,
                            element: i,
                            value: i.val(),
                            text: o,
                            slug: t.utils.replaceDiacritics(o),
                            disabled: n.groupDisabled
                        }, t.lookupItems[l] = n.items[s], l++
                    }), t.items[s] = n
                } else {
                    var o = i.html();
                    t.items[s] = {
                        index: l,
                        element: i,
                        value: i.val(),
                        text: o,
                        slug: t.utils.replaceDiacritics(o),
                        disabled: i.prop("disabled")
                    }, t.lookupItems[l] = t.items[s], l++
                }
            }), t.setLabel(), t.elements.items.append(t.elements.itemsScroll.html(t.getItemsMarkup(t.items))))
        },
        getItemsMarkup: function (t) {
            var s = this,
                i = "<ul>";
            return e.each(t, function (t, n) {
                void 0 !== n.label ? (i += s.utils.format('<ul class="{1}"><li class="{2}">{3}</li>', e.trim([s.classes.group, n.groupDisabled ? "disabled" : "", n.element.prop("class")].join(" ")), s.classes.grouplabel, n.element.prop("label")), e.each(n.items, function (e, t) {
                    i += s.getItemMarkup(t.index, t)
                }), i += "</ul>") : i += s.getItemMarkup(n.index, n)
            }), i + "</ul>"
        },
        getItemMarkup: function (t, s) {
            var i = this,
                n = i.options.optionsItemBuilder;
            return i.utils.format('<li data-index="{1}" class="{2}">{3}</li>', t, e.trim([t === i.state.currValue ? "selected" : "", t === i.items.length - 1 ? "last" : "", s.disabled ? "disabled" : ""].join(" ")), e.isFunction(n) ? n(s, s.element, t) : i.utils.format(n, s))
        },
        bindEvents: function () {
            var t = this;
            t.elements.wrapper.add(t.$element).add(t.elements.outerWrapper).add(t.elements.input).off(l), t.elements.outerWrapper.on("mouseenter" + l + " mouseleave" + l, function (s) {
                e(this).toggleClass(t.classes.hover, "mouseenter" === s.type), t.options.openOnHover && (clearTimeout(t.closeTimer), "mouseleave" === s.type ? t.closeTimer = setTimeout(e.proxy(t.close, t), t.options.hoverIntentTimeout) : t.open())
            }), t.elements.wrapper.on("click" + l, function (e) {
                t.state.opened ? t.close() : t.open(e)
            }), t.elements.input.prop({
                tabindex: t.originalTabindex,
                disabled: !1
            }).on("keydown" + l, e.proxy(t.handleKeys, t)).on("focusin" + l, function (e) {
                t.elements.outerWrapper.addClass(t.classes.focus), t.elements.input.one("blur", function () {
                    t.elements.input.blur()
                }), t.options.openOnFocus && !t.state.opened && t.open(e)
            }).on("focusout" + l, function () {
                t.elements.outerWrapper.removeClass(t.classes.focus)
            }).on("input propertychange", function () {
                var s = t.elements.input.val();
                clearTimeout(t.resetStr), t.resetStr = setTimeout(function () {
                    t.elements.input.val("")
                }, t.options.keySearchTimeout), s.length && e.each(t.items, function (e, i) {
                    if (RegExp("^" + t.utils.escapeRegExp(s), "i").test(i.slug) && !i.disabled) return t.select(e), !1
                })
            }), t.$li.on({
                mousedown: function (e) {
                    e.preventDefault(), e.stopPropagation()
                },
                click: function () {
                    return t.select(e(this).data("index"), !0), !1
                }
            })
        },
        handleKeys: function (t) {
            var s = this,
                i = t.keyCode || t.which,
                n = s.options.keys,
                l = e.inArray(i, n.previous) > -1,
                o = e.inArray(i, n.next) > -1,
                a = e.inArray(i, n.select) > -1,
                r = e.inArray(i, n.open) > -1,
                p = s.state.selectedIdx,
                u = l && 0 === p || o && p + 1 === s.items.length,
                c = 0;
            if (13 !== i && 32 !== i || t.preventDefault(), l || o) {
                if (!s.options.allowWrap && u) return;
                l && (c = s.utils.previousEnabledItem(s.items, p)), o && (c = s.utils.nextEnabledItem(s.items, p)), s.select(c)
            }
            return a && s.state.opened ? void s.select(p, !0) : void (r && !s.state.opened && s.open())
        },
        refresh: function () {
            var e = this;
            e.populate(), e.activate(), e.utils.triggerCallback("Refresh", e)
        },
        setOptionsDimensions: function () {
            var e = this,
                t = e.elements.items.closest(":visible").children(":hidden").addClass(e.classes.tempshow),
                s = e.options.maxHeight,
                i = e.elements.items.outerWidth(),
                n = e.elements.wrapper.outerWidth() - (i - e.elements.items.width());
            !e.options.expandToItemText || n > i ? e.finalWidth = n : (e.elements.items.css("overflow", "scroll"), e.elements.outerWrapper.width(9e4), e.finalWidth = e.elements.items.width(), e.elements.items.css("overflow", ""), e.elements.outerWrapper.width("")), e.elements.items.width(e.finalWidth).height() > s && e.elements.items.height(s), t.removeClass(e.classes.tempshow)
        },
        isInViewport: function () {
            var e = this,
                t = s.scrollTop(),
                i = s.height(),
                n = e.elements.outerWrapper.offset().top,
                l = e.elements.outerWrapper.outerHeight(),
                o = n + l + e.itemsHeight <= t + i,
                a = n - e.itemsHeight > t,
                r = !o && a;
            e.elements.outerWrapper.toggleClass(e.classes.above, r)
        },
        detectItemVisibility: function (e) {
            var t = this,
                s = t.$li.eq(e).outerHeight(),
                i = t.$li[e].offsetTop,
                n = t.elements.itemsScroll.scrollTop(),
                l = i + 2 * s;
            t.elements.itemsScroll.scrollTop(l > n + t.itemsHeight ? l - t.itemsHeight : i - s < n ? i - s : n)
        },
        open: function (s) {
            var n = this;
            n.utils.triggerCallback("BeforeOpen", n), s && (s.preventDefault(), s.stopPropagation()), n.state.enabled && (n.setOptionsDimensions(), e("." + n.classes.hideselect, "." + n.classes.open).children()[i]("close"), n.state.opened = !0, n.itemsHeight = n.elements.items.outerHeight(), n.itemsInnerHeight = n.elements.items.height(), n.elements.outerWrapper.addClass(n.classes.open), n.elements.input.val(""), s && "focusin" !== s.type && n.elements.input.focus(), t.on("click" + l, e.proxy(n.close, n)).on("scroll" + l, e.proxy(n.isInViewport, n)), n.isInViewport(), n.options.preventWindowScroll && t.on("mousewheel" + l + " DOMMouseScroll" + l, "." + n.classes.scroll, function (t) {
                var s = t.originalEvent,
                    i = e(this).scrollTop(),
                    l = 0;
                "detail" in s && (l = s.detail * -1), "wheelDelta" in s && (l = s.wheelDelta), "wheelDeltaY" in s && (l = s.wheelDeltaY), "deltaY" in s && (l = s.deltaY * -1), (i === this.scrollHeight - n.itemsInnerHeight && l < 0 || 0 === i && l > 0) && t.preventDefault()
            }), n.detectItemVisibility(n.state.selectedIdx), n.utils.triggerCallback("Open", n))
        },
        close: function () {
            var e = this;
            e.utils.triggerCallback("BeforeClose", e), e.change(), t.off(l), e.elements.outerWrapper.removeClass(e.classes.open), e.state.opened = !1, e.utils.triggerCallback("Close", e)
        },
        change: function () {
            var e = this;
            e.utils.triggerCallback("BeforeChange", e), e.state.currValue !== e.state.selectedIdx && (e.$element.prop("selectedIndex", e.state.currValue = e.state.selectedIdx).data("value", e.lookupItems[e.state.selectedIdx].text), e.setLabel()), e.utils.triggerCallback("Change", e)
        },
        select: function (e, t) {
            var s = this;
            void 0 !== e && (s.lookupItems[e].disabled || (s.$li.filter("[data-index]").removeClass("selected").eq(s.state.selectedIdx = e).addClass("selected"), s.detectItemVisibility(e), t && s.close()))
        },
        destroy: function (e) {
            var t = this;
            t.state && t.state.enabled && (t.elements.items.add(t.elements.wrapper).add(t.elements.input).remove(), e || t.$element.removeData(i).removeData("value"), t.$element.prop("tabindex", t.originalTabindex).off(l).off(t.eventTriggers).unwrap().unwrap(), t.state.enabled = !1)
        }
    }, e.fn[i] = function (t) {
        return this.each(function () {
            var s = e.data(this, i);
            s && !s.disableOnMobile ? "string" == typeof t && s[t] ? s[t]() : s.init(t) : e.data(this, i, new r(this, t))
        })
    }, e.fn[i].hooks = {
        add: function (e, t, s) {
            this[e] || (this[e] = {}), this[e][t] = s
        },
        remove: function (e, t) {
            delete this[e][t]
        }
    }, e.fn[i].defaults = {
        onChange: function (t) {
            e(t).change()
        },
        maxHeight: 300,
        keySearchTimeout: 500,
        arrowButtonMarkup: '<b class="button">&#x25be;</b>',
        disableOnMobile: !0,
        openOnFocus: !0,
        openOnHover: !1,
        hoverIntentTimeout: 500,
        expandToItemText: !1,
        responsive: !1,
        preventWindowScroll: !0,
        inheritOriginalWidth: !1,
        allowWrap: !0,
        optionsItemBuilder: "{text}",
        labelBuilder: "{text}",
        keys: {
            previous: [37, 38],
            next: [39, 40],
            select: [9, 13, 27],
            open: [13, 32, 37, 38, 39, 40],
            close: [9, 27]
        },
        customClass: {
            prefix: i,
            camelCase: !1
        }
    }
});
