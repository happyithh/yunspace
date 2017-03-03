//滚动监听
$(document).ready(function () {
    $('#nav1').click(function () {
        $('html,body').animate({
            scrollTop: $('#introduction').offset().top
        }, 500);
    });
    $('#nav2').click(function () {
        $('html,body').animate({
            scrollTop: $('#schedule').offset().top
        }, 500);
    });
    $('#nav3').click(function () {
        $('html,body').animate({
            scrollTop: $('#case').offset().top
        }, 500);
    });
    $('#nav4').click(function () {
        $('html,body').animate({
            scrollTop: $('#notice').offset().top
        }, 500);
    });
    $('#nav11').click(function () {
        $('html,body').animate({
            scrollTop: $('#introduction').offset().top
        }, 500);
    });
    $('#nav21').click(function () {
        $('html,body').animate({
            scrollTop: $('#case').offset().top
        }, 500);
    });
    $('#nav31').click(function () {
        $('html,body').animate({
            scrollTop: $('#notice').offset().top
        }, 500);
    });
    $('#nav41').click(function () {
        $('html,body').animate({
            scrollTop: $('#notice').offset().top
        }, 500);
    });

});


window.onscroll = function () {

    var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
    if (scrollTop < 1000) {
        document.getElementById('top').style.display = 'none';
    } else {
        document.getElementById('top').style.display = 'block';
    }
}

//焦点图弹出框
$(document).ready(function () {
    if ($(window).width() < 1024) {
        $('.imageBox').fancybox({
            'width': '100%',
            'height': '100%',
            'padding': '0',
            'showCloseButton': false,
            centerOnScroll: true
        });
        $('.videoBox').fancybox({
            'width': '100%',
            'height': '100%',
            'autoScale': false,
            'type': 'swf',
            'padding': '0',
            'showCloseButton': false,
            centerOnScroll: true
        });
    } else {
        $('.imageBox').fancybox();
        $('.videoBox').fancybox({
            'width': '70%',
            'height': '90%',
            'autoScale': false,
            'type': 'swf'
        });
    }
});