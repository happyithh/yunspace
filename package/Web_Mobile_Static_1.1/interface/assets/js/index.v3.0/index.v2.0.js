/**
 * Created by pzl on 15/9/10.
 */

var Wh = $(window).height();
var Ww = $(window).width();
//var bOffset = $(".banner1-act").offset().top;
//var bHei = $(".banner1-act").height();

var dOffset = $("ul.des").length > 0 ? $(".des").offset().top : 0;

$(document).ready(function(){

    //我的收藏 数量读取
    var space = JSON.parse(localStorage.getItem('space'));
    var article = JSON.parse(localStorage.getItem('article'));
    if(Object.size(space)+Object.size(article)!=0){
        $('.collect-num').text(Object.size(space)+Object.size(article));
    }
});
//我的收藏 数量读取
Object.size = function (obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};


function init() {
    var bannerW=$(".banner4-list").find("img").width();
    var imgMargin=(bannerW-Ww)/2;
    var Whh = Wh>500?Wh:540;


    var oBtn = $("#topcontrol");
    var timer = null;
    var bSys = true;

    $(".banner4-list").find("img").css({
        marginLeft:"-"+imgMargin+"px"
    });



    /*返回顶部*/
    window.onscroll = function () {
        if (!bSys) {
            clearInterval(timer);
        }

        bSys = false;
    }
    oBtn.bind("click",function () {
        timer = setInterval(function () {
            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            var iSpeed = Math.floor(-scrollTop / 4);
            if (scrollTop == 0) {
                clearInterval(timer);
            }
            bSys = true;
            document.body.scrollTop = document.documentElement.scrollTop = scrollTop + iSpeed;
        }, 30);
    });
    window.onscroll = function () {
        var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
        if (scrollTop < 100) {
            oBtn.css("display","none");
        } else {
            oBtn.css("display","block");
        }

        //菜单球球显示
        if (scrollTop >= dOffset) {
            $(".nav-point").show(10);
        }
    }


}
init();


$(".city-sel").on("click", function () {
    var city = $(this).text();
    window.location = '?df_city=' + city + '&t=' + (new Date()).valueOf() + '&url_back=' + window.location.href;
});

//侧导航滑进滑出动画
$('.nav-point').on('click',function(){
    $('.nav-fix-list1').addClass('nav-list-move');
    $('.nav-fix-list-bg').removeClass('hidden');
});
$('.nav-fix-list-bg').on('click',function(){
    $('.nav-fix-list1').removeClass('nav-list-move');
    $(this).addClass('hidden');
});


//菜单动画
var navStatus = {
    statue: true,//默认状态;false为展开，true为圆圈
    srcTop: "",
    animateOpen: true,
    CircleMove: true,
    isAlreadyAnimate : false,

    statueCircle: function () {
        var that = this;
        that.srcTop = $(window).scrollTop();
        if (navStatus.animateOpen == true) {
            //console.log(navStatus.statue);
            if (navStatus.statue == true) {
                return;
            }
            $(".nav-point").show(10);
            navStatus.statue = true;
        } else {
            //console.log(navStatus.statue);
            if (navStatus.statue == false) {
                return;
            }
            $(".nav-point").parent().removeClass("nav-fix-active");
            setTimeout(function () {
                $(".nav-point").hide(10);
                navStatus.statue = false;
            }, 400);
        }
    },

    statueCircleMove:function(){
        $('.desmove').show();
        $('.desmove').hide(800);
        $('.desmove').addClass('desmoveOn');
    },

    eventScroll: function () {
        if($('ul.des').length <= 0){
            $('.nav-point').css({"display":"block"})
        }else{
            $(window).on("scroll", function () {
                navStatus.srcTop = $(window).scrollTop();

                if (navStatus.srcTop >= (dOffset-50)) {
                    navStatus.animateOpen = true;
                    navStatus.statueCircle();
                } else {
                    navStatus.animateOpen = false;
                    navStatus.statueCircle();
                }

                //if (navStatus.srcTop >= (dOffset-50) && navStatus.srcTop <= dOffset) {
                //
                //    var imgclone = $('.desmove').show()
                //        .css({'position':'fixed','bottom':$(window).height() - 180})
                //        .animate({
                //            'bottom':"110px",
                //            'left':$('.nav-fix').offset().left
                //        }, 300);
                //    imgclone.animate({'width':0, 'height':0}, function(){ $(this).detach();});
                //    $(".nav-point").show(10);
                //}

            });
        }



    }

}

navStatus.eventScroll();
