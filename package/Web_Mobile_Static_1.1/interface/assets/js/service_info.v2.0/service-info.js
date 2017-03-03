/**
 * Created by Alex Shen on 2015/6/4.
 */
$(document).ready(function () {
    $(".youku-video").height(window.innerWidth / 4 * 3 + "px");

    var imageContentSwiper = new Swiper('.image-content-area .swiper-container', {
        pagination: '.image-content-area .swiper-pagination',
        direction: 'horizontal',
        paginationClickable: true,
        calculateHeight: true,
        speed: 600,
        loop: true,
        autoplay: 8000
    });

    var bestContentSwiper = new Swiper('.best-pair-area .swiper-container', {
        direction: 'horizontal',
        slidesPerView: 4,
        slidesPerGroup: 4,
        calculateHeight: true,
        paginationClickable: true,
        speed: 600,
        loop: true
    });
    $(".open-right-panel").bind("click", function () {
        openPanelWithName($(this).attr("data-panel"), function () {
            $(".origin-content").addClass("hide");
            $(".close-panel").addClass("active");
        });
    });

    $(".close-panel").bind("click", function () {
        $(".origin-content").removeClass("hide");
        $(".close-panel").removeClass("active");
        closePanelWithPosition("right");
    });

    $(".best-pair-area .left-arrow").bind("click", function () {
        bestContentSwiper.slideNext();
    });
    $(".best-pair-area .right-arrow").bind("click", function () {
        bestContentSwiper.slidePrev();
    });

    $(".js-open-video-panel").bind("click", function () {
        window.event.preventDefault(window.event);
        $(".origin-content").addClass("hide");
        var vedioSrc = $(this).attr("data-video-src");
        vedioSrc = vedioSrc.replace(/player.php\/sid/g, "embed");
        vedioSrc = vedioSrc.replace(/\/v.swf/g, "");
        $(".js-youku-video").attr("src", vedioSrc);
        $(".panel-video").addClass("active");
        $(".close-panel").addClass("active");
    });
    window.onscroll = function () {
        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        if (scrollTop < 50) {
            $(".top").removeClass('top-fixed');
            $("#scrolltop-raider").css("display","none");
        } else {
            $(".top").addClass('top-fixed');
            $("#scrolltop-raider").css("display","block");
        }
    }

    $('.js-share').on('click',function(){
        $('.share').addClass('shareOn');
        $('.share-bg').removeClass('hidden');
        $('.nav-point').hide();
    });
    $('.share-bg').on('click',function(){
        $('.share').removeClass('shareOn');
        $(this).addClass('hidden');
        $('.nav-point').show();
    });

});
