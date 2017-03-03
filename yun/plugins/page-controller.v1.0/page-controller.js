/**
 * Created by Alex Shen on 2015/6/25.
 */
yun('global/jquery-1.9.1.min.js');
//该插件用于管理手机端的页面跳转
//将物理上的页面跳转转换为逻辑上的页面跳转
//该插件将生成一个页面栈用于保存页面之间的跳转
//其出入栈规则如下
//1.单向跳转（也就说C的前进方向不能是倒退的，C不能前进到B，C不能前进到A）
//  入   A->B->C
//  出   C->B->A
//2.非单向跳转
//  入   A->B->C->B
//  出   B->A
//针对这种跳转，需要在逻辑上保障B的回退不是C而是再之前的B的前驱A
//此时需要将最后一个B前的B和C清除
//此处用于记录使用本插件时，系统历史记录与插件栈之间的差分
function PageStack() {
    if (typeof PageStack.singleInstance !== "undefined") {
        return PageStack.singleInstance;
    }
    this.pages = [];
    this.theme = "page-controller-content";
    this.styleFile = window.YunSpace.plugin_src + "page-controller.v1.0/page-controller" + ".css";
    this.animation_duration = 400;
    PageStack.singleInstance = this;
}
var plugin = {
    isInit: false,
    pageStack: {},
    initPlugin: function () {
        this.pageStack = new PageStack();
        window.yun.dom = function (nodeName) {
            return document.createElement(nodeName);
        };
    },
    getMask: function () {
        if ($(".page-controller-mask").length > 0) {
            return $(".page-controller-mask");
        }
        var mask = window.yun.dom("div");
        $("body").append(mask);
        mask.className = "page-controller-mask";
        return $(mask);
    },
    showPage: function (ele, args, fn) {
        if (!this.isInit) {
            this.initPlugin();
            this.isInit = true;
        }
        var mask = this.getMask();
        mask.addClass("active");
        var css = yun.dom("link");
        var div = yun.dom("div");
        document.head.appendChild(css);
        css.rel = "stylesheet";
        css.href = this.pageStack.styleFile;
        var virtualDom = yun.dom("div");
        div.id = "yun-page-next";
        div.className = this.pageStack.theme;
        document.body.appendChild(div);
        var pages = this.pageStack.pages;
        var o = this;
        $(virtualDom).load(args.url, function (response, status, xhr) {
            var locationOrigin = location.origin + args.url;
            var childCount = virtualDom.childNodes.length;
            for (var i = childCount - 1; i > 0; i--) {
                var nodeName = virtualDom.childNodes[i].nodeName.toUpperCase();
                if (nodeName === "SCRIPT") {
                    var src = virtualDom.childNodes[i].src;
                    if (src) {
                        if (-1 !== src.indexOf("yunspace.js")) {
                            var origin = virtualDom.childNodes[i].src;
                            var format = origin.replace(/yunspace\.js(\.dev\.js)?/ig, "");
                            var obReg = /\.js/;
                            if (obReg.test(format)) {
                                virtualDom.childNodes[i].src = format;
                            } else {
                                (virtualDom.childNodes[i]).remove();
                            }
                        }
                    } else {
                        (virtualDom.childNodes[i]).remove();
                    }
                } else if (nodeName === "LINK") {
                    //Todo 这里留空的原因是考虑到确实会有css污染的问题，但是还没有合适的解决方案
                    //可以预见的是通过ajax请求向服务器传递一个keyword，并经由服务器包装后再行返回一个拥有命名空间的css文件
                } else if ((nodeName === "META") || (nodeName === "TITLE")) {
                    (virtualDom.childNodes[i]).remove();
                }
            }
            div.innerHTML = virtualDom.innerHTML;
            div.style.position = "fixed";
            div.style.top = 0;
            var currentNode;
            $(div).unbind("webkitTransitionEnd").bind("webkitTransitionEnd", function () {
                var scrollTop = 0;
                if ($("#yun-page-current").length === 0) {
                    scrollTop = document.body.scrollTop;
                    currentNode = window.yun.dom("div");
                    currentNode.innerHTML = document.body.innerHTML;
                    var childNodeCount = document.body.childNodes.length;
                    for (var i = childNodeCount - 1; i > 0; i--) {
                        var nodeName = document.body.childNodes[i].nodeName.toUpperCase();
                        if ((nodeName !== "SCRIPT") && (nodeName !== "LINK") && (nodeName !== "META")) {
                            if ((document.body.childNodes[i].id !== "yun-page-next") && ( !($(document.body.childNodes[i]).hasClass("page-controller-mask")))) {
                                $(document.body.childNodes[i]).remove();
                            } else {
                                $(currentNode.childNodes[i]).remove();
                            }
                        } else {
                            $(currentNode.childNodes[i]).remove();
                        }
                    }

                } else {
                    currentNode = $("#yun-page-current")[0];
                    scrollTop = currentNode.scrollTop;
                }
                pages.push({"url": window.location.href, "htmlData": currentNode.innerHTML,"scrollTop":scrollTop});
                $(div).after(mask);
                mask.removeClass("active");
                $("#yun-page-current").remove();
                $(div).attr("id", "yun-page-current");
                window.YunSpace.buildPluginWithNodes(div, true);
                $(div).unbind("webkitTransitionEnd");
                var title = '';
                var url = locationOrigin;
                var state = {title: title, url: url};
                history.replaceState(state, title, url);
            });
            $(div).addClass("active");
        });
        return;
    },
    closePage: function (ele, args, fn) {
        if (!this.isInit) {
            return;
        }
        var lastUrlData = this.pageStack.pages.pop();
        var lastPage = "";
        var preDom = window.yun.dom("div");
        preDom.id = "yun-page-prev";
        if (lastUrlData !== undefined) {
            $(preDom).addClass(this.pageStack.theme);
            $(preDom).addClass("active");
            lastPage = lastUrlData["htmlData"];
            var title = '';
            var url = lastUrlData["url"];
            var state = {title: title, url: url};
            history.replaceState(state, title, url);
        }
        if (lastPage === "") {
            return;
        }
        preDom.innerHTML = lastPage;
        $(preDom).insertBefore($("#yun-page-current"));
        $(preDom).scrollTop(lastUrlData["scrollTop"]);
        window.YunSpace.buildPluginWithNodes(preDom, true);
        var mask = $(this.getMask());
        mask.addClass("active");
        $("#yun-page-current").unbind("webkitTransitionEnd").bind("webkitTransitionEnd", function () {
            $("#yun-page-current").remove();
            preDom.id = "yun-page-current";
            mask.removeClass("active");
        });
        $("#yun-page-current").removeClass("active");
    }
};
