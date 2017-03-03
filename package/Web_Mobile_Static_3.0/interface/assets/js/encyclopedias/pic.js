$(function() {
    $("img.lazy").lazyload({effect:"fadeIn"});

    var mySwiper = new Swiper('.swiper-container',{
        autoplayDisableOnInteraction : false,
        onSlideChangeStart: function(swiper){
            lazyImg(swiper.activeIndex);
        }
    });
    var lazyload=[];
    $('.baike_pic ul li').each(function(index,dom){
        var dom=$(dom);
        dom.click(function(){
            var $this=$(this);
            if(!lazyload[index]){
                lazyImg(index);
            }
            $('.cover_pic_one').addClass("cover_pic_one_active");
            mySwiper.slideTo(index, 1, false);//切换到第一个slide，速度为1秒
        });
    });


//    $(dom),find('img’).onload
    function lazyImg(index){
        var src= $('.swiper-slide').eq(index).find('img').data('original');

        var Img= $('.swiper-slide').eq(index).find('img');
        if(Img.attr("src").length==0){
            $('.loading').removeClass('none');
        }
        Img.on('load',function(){
            $('.loading').addClass('none');
        });

        $('.swiper-slide').eq(index).find('img').attr("src",src);
        $('.swiper-slide').eq(index).find('img').css({width:"100%"});
        lazyload[index]=true;
    }
    $('.cover_pic_one,.cover_pic_icon').click(function(){
        $('.cover_pic_one').removeClass("cover_pic_one_active");
        $('.loading').addClass('none');
    });

});