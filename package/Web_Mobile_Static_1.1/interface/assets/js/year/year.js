/**
 * Created by pzl on 15/10/26.
 */
var winH=$(window).height();
setTimeout(function(){
    $(".advance2-des-p").addClass("advance2-des-p-active");
    $(".advance2-title").addClass("advance2-title-active");
    $(".advance2-bottom").addClass("advance2-bottom-active");
},100);

setInterval(function(){
    if(!$(".up-look").hasClass("up-look-active")){
        $(".up-look").addClass("up-look-active");
    }
    setTimeout(function(){
        $(".up-look").removeClass("up-look-active");
    },500);
},1000);

var swiper = new Swiper('.swiper-container', {
    pagination: '.swiper-pagination',
    paginationClickable: true,
    direction: 'vertical',
    onSlideChangeEnd: function(swiper){
      if(swiper.activeIndex==1){
          $(".up-look").addClass("none");
      }else{
          $(".up-look").removeClass("none");
      }
        switch(swiper.activeIndex){
            case 1:
                $(".advance2-title").removeClass("advance2-title-active");
                $(".advance2-bottom").removeClass("advance2-bottom-active");
                $(".advance2-des-p").removeClass("advance2-des-p-active");
                    $(".advance1-p1").addClass("advance1-p1-active");
                    $(".advance1-p2").addClass("advance1-p2-active");
                setTimeout(function(){
                    $(".advance1-p2-img").fadeIn(200);
                },1500);
            break;
            case 0:
                $(".advance1-p1").removeClass("advance1-p1-active");
                $(".advance1-p2").removeClass("advance1-p2-active");
                $(".advance1-p2-img").hide();
                    $(".advance2-des-p").addClass("advance2-des-p-active");
                    $(".advance2-title").addClass("advance2-title-active");
                    $(".advance2-bottom").addClass("advance2-bottom-active");
                break;
        }

    }
});


