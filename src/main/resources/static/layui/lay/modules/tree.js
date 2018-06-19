/** layui-v2.2.4 MIT License By http://www.layui.com */
;layui.define("jquery", function (e) {
    "use strict";
    var a = layui.$, c = layui.hint(), t = "layui-tree-enter", i = function (e) {
        this.options = e, this.checkedLeafNodes = []
    }, n = {
        arrow: ["&#xe623;", "&#xe625;"],
        checkbox: ["&#xe603;", "&#xe621;", "&#xe608;"],
        radio: ["&#xe67e;", "&#xe633;"],
        branch: ["&#xe622;", "&#xe624;"],
        leaf: "&#xe621;"
    };
    i.prototype.init = function (e) {
        var a = this;
        a.root = e, e.addClass("layui-box layui-tree"), a.options.skin && e.addClass("layui-tree-skin-" + a.options.skin), a.checkedLeafNodes.length = 0, a.tree(e), a.on(e), a.checkedLeafNodes.length > 0 && layui.each(a.checkedLeafNodes, function (e, c) {
            a.checkThisNode(c)
        })
    }, i.prototype.tree = function (e, c) {
        var t = this, i = t.options, o = c || i.nodes;
        layui.each(o, function (c, o) {
            var r = o.children && o.children.length > 0,
                h = a('<ul class="' + (o.spread ? "layui-show" : "") + '"></ul>'),
                l = a(["<li " + (o.spread ? 'data-spread="' + o.spread + '"' : "") + ">", function () {
                    return r ? '<i class="layui-icon layui-tree-spread">' + (o.spread ? n.arrow[1] : n.arrow[0]) + "</i>" : ""
                }(), function () {
                    return i.check ? '<i class="layui-icon-ext layui-tree-check">' + ("checkbox" === i.check ? n.checkbox[0] : "radio" === i.check ? n.radio[0] : "") + "</i>" : ""
                }(), function () {
                    return '<a href="' + (o.href || "javascript:;") + '" ' + (i.target && o.href ? 'target="' + i.target + '"' : "") + ">" + ('<i class="layui-icon layui-tree-' + (r ? "branch" : "leaf") + '">' + (r ? o.spread ? n.branch[1] : n.branch[0] : n.leaf) + "</i>") + ("<cite>" + (o.name || "未命名") + "</cite></a>")
                }(), "</li>"].join(""));
            r && (l.append(h), t.tree(h, o.children));
            var d = a.extend({}, o);
            delete d.children, l.data("json", d), i.check && (l.children("i.layui-tree-check").data("uncheck", !0), !r && o.checked && t.checkedLeafNodes.push(l)), e.append(l), "function" == typeof i.click && t.click(l, o), t.spread(l, o), i.drag && t.drag(l, o)
        })
    }, i.prototype.checkThisNode = function (e) {
        var c = this, t = c.options, i = e.children("i.layui-tree-check");
        if ("checkbox" == t.check) {
            var o, r = !0;
            i.data("uncheck") || i.data("halfcheck") ? (o = n.checkbox[1], i.data("halfcheck", !1).data("uncheck", !1).data("check", !0)) : (r = !1, o = n.checkbox[0], i.data("halfcheck", !1).data("check", !1).data("uncheck", !0)), i.html(o), e.find("ul>li").each(function () {
                a(this).children("i.layui-tree-check").html(o).data("halfcheck", !r).data(r ? "uncheck" : "check", !1).data(r ? "check" : "uncheck", !0)
            }), !e.parent().hasClass("layui-tree") && c.checkNode(e)
        } else "radio" == t.check && i.data("uncheck") && (a(c.root).find('i[class*="layui-tree-check"]').each(function () {
            a(this).html(n.radio[0]).data("check", !1).data("uncheck", !0)
        }), i.html(n.radio[1]).data("uncheck", !1).data("check", !0))
    }, i.prototype.checkNode = function (e) {
        var c = this, t = !0, i = 0, o = a.merge(e.siblings(), [e]);
        layui.each(o, function () {
            var e = a(this).children("i.layui-tree-check");
            e.data("uncheck") && (t = !1, i++)
        });
        var r, h = !1;
        (r = e.parent()).hasClass("layui-tree") || (r = e.parent().parent()).hasClass("layui-tree") || (h = !0), r.children("ul").find("i.layui-tree-check").each(function () {
            (a(this).data("uncheck") || a(this).data("halfcheck")) && (t = !1)
        });
        var l = i == o.length, d = l ? n.checkbox[0] : t ? n.checkbox[1] : n.checkbox[2],
            s = r.children("i.layui-tree-check").html(d);
        l ? s.data("check", !1).data("halfcheck", !1).data("uncheck", !0) : (s.data("uncheck", !1).data("check", !0), t ? s.data("halfcheck", !1) : s.data("halfcheck", !0)), h && c.checkNode(r)
    }, i.prototype.getChecked = function (e) {
        var c = [], t = this.root.find("li");
        return layui.each(t, function () {
            var t = a(this);
            t.children("i.layui-tree-check").data("check") && (e ? t.children("a").find("i.layui-tree-leaf")[0] && c.push(t.data("json")) : c.push(t.data("json")))
        }), c
    }, i.prototype.click = function (e, a) {
        var c = this, t = c.options;
        e.children("a,i.layui-tree-check").on("click", function (i) {
            layui.stope(i), t.click(a), t.check && c.checkThisNode(e)
        })
    }, i.prototype.spread = function (e, a) {
        var c = this, t = (c.options, e.children(".layui-tree-spread")), i = e.children("ul"), o = e.children("a"),
            r = function () {
                e.data("spread") ? (e.data("spread", null), i.removeClass("layui-show"), t.html(n.arrow[0]), o.find(".layui-icon").html(n.branch[0])) : (e.data("spread", !0), i.addClass("layui-show"), t.html(n.arrow[1]), o.find(".layui-icon").html(n.branch[1]))
            };
        i[0] && (t.on("click", r), o.on("dblclick", r))
    }, i.prototype.on = function (e) {
        var c = this, i = c.options, n = "layui-tree-drag";
        e.find("i").on("selectstart", function (e) {
            return !1
        }), i.drag && a(document).on("mousemove", function (e) {
            var t = c.move;
            if (t.from) {
                var i = (t.to, a('<div class="layui-box ' + n + '"></div>'));
                e.preventDefault(), a("." + n)[0] || a("body").append(i);
                var o = a("." + n)[0] ? a("." + n) : i;
                o.addClass("layui-show").html(t.from.elem.children("a").html()), o.css({
                    left: e.pageX + 10,
                    top: e.pageY + 10
                })
            }
        }).on("mouseup", function () {
            var e = c.move;
            e.from && (e.from.elem.children("a").removeClass(t), e.to && e.to.elem.children("a").removeClass(t), c.move = {}, a("." + n).remove())
        })
    }, i.prototype.move = {}, i.prototype.drag = function (e, c) {
        var i = this, n = (i.options, e.children("a")), o = function () {
            var n = a(this), o = i.move;
            o.from && (o.to = {item: c, elem: e}, n.addClass(t))
        };
        n.on("mousedown", function () {
            var a = i.move;
            a.from = {item: c, elem: e}
        }), n.on("mouseenter", o).on("mousemove", o).on("mouseleave", function () {
            var e = a(this), c = i.move;
            c.from && (delete c.to, e.removeClass(t))
        })
    }, e("tree", function (e) {
        var t = new i(e = e || {}), n = a(e.elem);
        return n[0] ? (t.init(n), t) : c.error("layui.tree 没有找到" + e.elem + "元素")
    })
});