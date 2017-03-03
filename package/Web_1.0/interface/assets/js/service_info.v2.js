$(document).ready(function () {
    //$('.tab_product_item').hide();
    //$('.tab_product').find('div.active').show();
    //$('.tab_product').find('div.active').eq(0).addClass('tab_product_item_active');
    $('.pikachoose').hide().eq(0).show();
    $('.tab_product_item').click(function () {
        $(this).addClass('tab_product_item_active')
            .siblings().removeClass('tab_product_item_active');
        $('.pikachoose').hide().eq($(this).index()).show();
    });
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

    $(".pikachoose ul").PikaChoose({
        carousel: true,
        carouselVertical: true
    });
});