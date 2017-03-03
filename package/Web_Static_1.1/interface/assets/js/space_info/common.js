
/*******************************************/
function fixedSidebar() {
    var side = $('#test2');
    var sideTop = side.offset().top + side.height();
    var h = $("#test").height() - side.height();
    var timer = 300;
    var fixStatus = function () {
        var winHeight = $(window).height();
        var scrollTop = $(document).scrollTop();
        var tempBottom = scrollTop + winHeight - sideTop;
        if (tempBottom > h) { tempBottom = h };
        if (scrollTop + winHeight > sideTop) {
            side.css({ position: 'absolute', right: '0' }).stop(true).animate({ top: (tempBottom) }, timer)
        } else {
            side.css({ position: 'static', right: '0' }).stop(true).animate({ top: 0 }, timer)
        }
    };
    $(window).scroll(function () { fixStatus() });
    $(window).resize(function () { fixStatus() })
};
$(function () {
    fixedSidebar();
});
function reloads(target) {
    var _this = $('#refresh' + target);
    var soffset = _this.offset().top;
    window.location.reload();
    setTimeout(function () { $('body,html').animate({ scrollTop: soffset }, 10) }, 200)
};
