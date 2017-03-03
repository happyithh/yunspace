/**
 * Created by Alex Shen on 2015/6/5.
 */
function openPanelWithName(name, callback) {
    if (window.event) {
        window.event.preventDefault(window.event);
    }
    if (callback) {
        $(".panel-" + name).one("webkitTransitionEnd", (function () {
            callback();
        }));
    }
    window.history.pushState({},window.location.href);
    //window.history_bk = window.history;
    //window.history = null;
    $(".panel-" + name).addClass("active");
    //$(document).unload(function () {
    //    alert(2);
    //});

    window.onbeforeunload = function () {
        //alert(1);
    }
}
function closePanelWithName(name, callback) {
    if (window.event) {
        window.event.preventDefault(window.event);
    }
    if (callback) {
        $(".panel-" + name).one("webkitTransitionEnd", (function () {
            callback();
        }));
    }
    $(".panel-" + name).removeClass("active");
    //window.history = window.history_bk;
}
function closePanelWithPosition(position, callback) {
    if (window.event) {
        window.event.preventDefault(window.event);
    }
    window.history.go(-1);
    $("." + position + "-panel").removeClass("active");
    if (callback) {
        $("." + position + "-panel").one("webkitTransitionEnd", (function () {
            callback();
        }));
    }
}
