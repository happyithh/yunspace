$(document).ready(function () {
    var slider;
    var winW = $(window).width();
    var bannerImgNum = $("#imageGallery li").length;
    $('#imageGallery li').eq(0).addClass('active');//兼容IE
    if($(window).width()<1024){
        $('.imageBox').fancybox({
            'width':'100%',
            'height':'100%',
            'padding':'0',
            'showCloseButton':false,
            centerOnScroll:true
        });
        $('.videoBox').fancybox({
            'width':'100%',
            'height':'100%',
            'autoScale': false,
            'type': 'swf',
            'padding':'0',
            'showCloseButton':false,
            centerOnScroll:true
        });
    }else{
        $('.imageBox').fancybox();
        $('.videoBox').fancybox({
            'width':'70%',
            'height':'90%',
            'autoScale': false,
            'type': 'swf'
        });
    }

    if (winW < 560) {
        slider = $('#imageGallery').lightSlider({ //移动端初始化成一个banner图
            gallery: true,
            auto: true,
            mode: 'fade',
            loop: true,
            thumbItem: 5
        });

    } else {
        slider = $('#imageGallery').lightSlider({ //PC端成一个banner图
            gallery: true,
            auto: true,
            mode: 'fade',
            loop: true

        });
    }

    $('#home_content_tap span').bind('click', function () {
        var index = $(this).index();
        var bannerNumber = $(this).data('banner') - 1;
        $(this).addClass('active').siblings('span').removeClass('active');
        //$('#s_left .server_inner_banner').eq(index).show().siblings('.server_inner_banner').hide();
        slider.goToSlide(bannerNumber);

    });


//        var maxHeight = $('#imageGallery').outerHeight();//图片上下居中
//        $('#imageGallery li a').each(function(index, el) {
//
////                $(this).find("img").load(function(){
//            var thisH = $(this).outerHeight();
//            var marT = (maxHeight-thisH)/2;
//            marT = marT<0?0:marT;
//            $(this).css('margin-top', marT);
////                })
//
//        });
    if (!supportCss3('box-pack')) {
        makeImgCenter($('#imageGallery'));
        checkImgCenter($('#imageGallery'));
    }


    if ($(window).width() < 1024) {
        $('#supplier').appendTo('#wap_left');
        $('#s_kj').appendTo('#wap_left')
        $('.showDate').appendTo('#wap_left')
    }

    window.onresize = function () {
        if ($(window).width() < 1024) {
            $('#supplier').appendTo('#wap_left');
            $('#s_kj').appendTo('#wap_left')
            $('.showDate').appendTo('#wap_left')
        }

    }


});

function checkImgCenter(where) {
    var thisInt = setInterval(function () {
        var isAllReady = true;
        where.find('img').each(function () {
            var thisH = $(this).height();
            if (thisH <= 0) {
                isAllReady = false;
            }
        })
        if(isAllReady){
            clearInterval(thisInt);
            return false;
        }else{
           makeImgCenter(where);
        }

    },500)

}

function makeImgCenter(where){
    var maxHeight = $('#imageGallery').outerHeight();//图片上下居中
    where.find('img').each(function(index, el) {
            var thisH = $(this).outerHeight();
            var marT = (maxHeight-thisH)/2;
            marT = marT<0?0:marT;
            $(this).css('margin-top', marT);
        }
    )
}

function supportCss3(style) {
    var prefix = ['webkit', 'Moz', 'ms', 'o'],
        i,
        humpString = [],
        htmlStyle = document.documentElement.style,
        _toHumb = function (string) {
            return string.replace(/-(\w)/g, function ($0, $1) {
                return $1.toUpperCase();
            });
        };

    for (i in prefix)
        humpString.push(_toHumb(prefix[i] + '-' + style));

    humpString.push(_toHumb(style));

    for (i in humpString)
        if (humpString[i] in htmlStyle) return true;

    return false;
}