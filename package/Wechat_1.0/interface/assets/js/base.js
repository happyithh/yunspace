$(document).ready(function () {
    var winW = $(window).width();
    $('#h_tap span').click(function (event) {
        var index = $(this).index();
        $(this).addClass('active').siblings().removeClass('active');
        $('.mytap').eq(index).show().siblings('.mytap').hide();


    });

    $('#left_nav li').hover(function () {
        $(this).find('div').fadeIn('fast');
    }, function () {
        $('#left_nav ul li div').hide();
    });
    $('#left_nav li').each(function (index, el) {
        var that = $(this);
        var html = that.find('p').html()
        that.find('.all_w div').html(html);
    });

    $('#secTapTri').click(function (event) {//首页第二个TAP触发延迟加载
        $("#sectap img").lazyload({
            event: "click"
        });
    });

    $('#toSearchForm').bind('click', function (event) {
        $('#top_search').slideToggle('fast');
        isShowMask()
    });
    $('#showNav').bind('click', function (event) {
        $('#top_nav').slideToggle('fast');
        isShowMask()
    });
    $('#layer').bind('click', function (event) {
        $('#top_search').hide();
        $('#top_nav').hide();
        $(this).fadeOut();
    });

    window.onresize = showWapNav;
    if (winW < 1024) {
        $('#mose_ke').bind('click', function (event) {
            $('#se_wrap').slideToggle();
        });
    } else {
        $('#mose_ke').bind('click', function (event) {
            $('#hide_sek').slideToggle();
            $('#hide_sek').parent().toggleClass('open_all');
        });
    }
    showWapNav();
});

function isShowMask() {
    var layer = $('#layer');
    if (layer.is(":visible")) {
        layer.hide()
    } else {
        $('#layer').fadeIn('fast');
        // $('#layer').show();
    }
}


function showWapNav() {
    var winW = $(window).width();//需要动态获取
    if (winW < 1024 && $('#wapNexNav').size() > 0) {

        var myScroll, navWidth = 0, offsetLeft = 0, maxOffSetLeft, actLiWidth;
        winW = winW > 750 ? 750 : winW;//移动端页面最大宽度
        $('#wapNexNav').html($('#nav_sl').html());
        $('#wapNexNav li').each(function (index, el) {
            var width = $(this).width();
            navWidth += width;
        });

        navWidth += 30;
        $('#wapNexNav').width(navWidth);

        if (!$('#nav_scr ul li.active').size()) {
            offsetLeft = 0;
        } else {
            offsetLeft = $('#nav_scr ul:first-child li.active').offset().left;
        }

        maxOffSetLeft = navWidth - winW;

        if (offsetLeft > maxOffSetLeft) {
            offsetLeft = maxOffSetLeft;

        }

        (function loaded() {
            // myScroll = new IScroll('#nav_wrap', { scrollX: true});
            myScroll = new IScroll("#nav_scr", {
                click: true, //调用判断函数
                mouseWheel: true,//允许滑轮滚动
                fadeScrollbars: true,//滚动时显示滚动条，默认影藏，并且是淡出淡入效果
                scrollX: true,
                startX: -offsetLeft
            });
        })()
    }
}
function loaded() {
    // myScroll = new IScroll('#nav_wrap', { scrollX: true});
    myScroll = new IScroll("#nav_scr", {
        click: true, //调用判断函数
        mouseWheel: true,//允许滑轮滚动
        fadeScrollbars: true,//滚动时显示滚动条，默认影藏，并且是淡出淡入效果
        scrollX: true,
        startX: -offsetLeft
    });
}
var scrolltotop = {
    //startline: Integer. Number of pixels from top of doc scrollbar is scrolled before showing control
    //scrollto: Keyword (Integer, or "Scroll_to_Element_ID"). How far to scroll document up when control is clicked on (0=top).
    setting: {
        startline: 100,
        scrollto: 0,
        scrollduration: 1000,
        fadeduration: [500, 100]
    },
    controlattrs: {offsetx: 10, offsety: 10}, //offset of control relative to right/ bottom of window corner
    anchorkeyword: '#top', //Enter href value of HTML anchors on the page that should also act as "Scroll Up" links

    state: {isvisible: false, shouldvisible: false},

    scrollup: function () {
        if (!this.cssfixedsupport) //if control is positioned using JavaScript
            this.$control.css({opacity: 0}) //hide control immediately after clicking it
        var dest = isNaN(this.setting.scrollto) ? this.setting.scrollto : parseInt(this.setting.scrollto)
        if (typeof dest == "string" && jQuery('#' + dest).length == 1) //check element set by string exists
            dest = jQuery('#' + dest).offset().top
        else
            dest = 0
        this.$body.animate({scrollTop: dest}, this.setting.scrollduration);
    },

    keepfixed: function () {
        var $window = jQuery(window)
        var controlx = $window.scrollLeft() + $window.width() - this.$control.width() - this.controlattrs.offsetx
        var controly = $window.scrollTop() + $window.height() - this.$control.height() - this.controlattrs.offsety
        this.$control.css({
            left: controlx + 'px',
            top: controly + 'px'
        })
    },

    togglecontrol: function () {
        var scrolltop = jQuery(window).scrollTop()
        if (!this.cssfixedsupport)
            this.keepfixed()
        this.state.shouldvisible = (scrolltop >= this.setting.startline) ? true : false
        if (this.state.shouldvisible && !this.state.isvisible) {
            this.$control.stop().animate({opacity: 1}, this.setting.fadeduration[0])
            this.state.isvisible = true
            if ($(window).width() < 1025) {
                $('.top').hide().fadeIn();
                $('body').addClass('top_fixed');
            }
        }
        else if (this.state.shouldvisible == false && this.state.isvisible) {
            this.$control.stop().animate({opacity: 0}, this.setting.fadeduration[1])
            this.state.isvisible = false
            $('body').removeClass('top_fixed');
        }
    },

    init: function () {
        jQuery(document).ready(function ($) {
            var mainobj = scrolltotop
            var iebrws = document.all
            mainobj.cssfixedsupport = !iebrws || iebrws && document.compatMode == "CSS1Compat" && window.XMLHttpRequest //not IE or IE7+ browsers in standards mode
            mainobj.$body = (window.opera) ? (document.compatMode == "CSS1Compat" ? $('html') : $('body')) : $('html,body')
            mainobj.$control = $('#topcontrol')//$('<div id="topcontrol">'+mainobj.controlHTML+'</div>')
                .removeClass('hide')
                .css({
                    position: mainobj.cssfixedsupport ? 'fixed' : 'absolute',
                    bottom: mainobj.controlattrs.offsety,
                    right: mainobj.controlattrs.offsetx,
                    opacity: 0,
                    cursor: 'pointer'
                })
                .attr({title: 'Scroll Back to Top'})
                .click(function () {
                    mainobj.scrollup();
                    return false
                })
                .appendTo('body')
            if (document.all && !window.XMLHttpRequest && mainobj.$control.text() != '') //loose check for IE6 and below, plus whether control contains any text
                mainobj.$control.css({width: mainobj.$control.width()}) //IE6- seems to require an explicit width on a DIV containing text
            mainobj.togglecontrol()
            $('a[href="' + mainobj.anchorkeyword + '"]').click(function () {
                mainobj.scrollup()
                return false
            })
            $(window).bind('scroll resize', function (e) {
                mainobj.togglecontrol()
            })
        })
    }
}

scrolltotop.init()