/**
 * Created by pzl on 15/9/10.
 */
var Wh = $(window).height();
var Ww = $(window).width();
var bOffset = $(".banner1-act").offset().top;
var bHei = $(".banner1-act").height();
var dOffset = $(".des").offset().top;
var dHei = $(".des").height();
var scrTop;
function init() {
    var bannerW=$(".banner4-list").find("img").width();
    var imgMargin=(bannerW-Ww)/2;
    var Whh = Wh>500?Wh:540;
    //if (Ww > 320) {
    //    $(".banner1").css({
    //        height: (Whh+36)+"px"
    //    });
    //    var biw = $(".banner5-img1 > img").height();
    //    $(".banner5-img,.banner5").css({
    //        height: biw + "px"
    //    })
    //} else {
    //    $(".banner1").css({
    //        height: (Whh+36)+"px"
    //    });
    //    $(".position-city-name").val(Ww);
    //}
    //if ($(".index-panel").height() < Wh) {
    //    $(".index-panel").height(Wh);
    //}
    var srcTop = $(window).scrollTop();
    //console.log(srcTop,(dOffset+dHei));
    $(".banner4-list").find("img").css({
        marginLeft:"-"+imgMargin+"px"
    })
    if (srcTop >= (dOffset + dHei)) {
        $(".nav-fix").show();
        setTimeout(function () {
            $(".nav-fix").css({
                left: "85%",
                opacity: "1"
            });
        }, 100);
    }

}
init();
$(".city-sel").on("click", function () {
    var city = $(this).text();
    window.location = '?df_city=' + city + '&t=' + (new Date()).valueOf() + '&url_back=' + window.location.href;
});

//搜索动画
var searchStatus = {
    statue: false,//默认状态;false为展开，true为圆圈
    srcTop: "",
    animateOpen: true,
    statueCircle: function () {
        var that = this;
        that.srcTop = $(window).scrollTop();
        if (searchStatus.animateOpen == true) {
            if (searchStatus.statue == true) {
                return;
            }
            $(".banner-img-search").addClass("search-scroll");
            $(".search-body").addClass("search-body-scroll");
            $(".search-body").find("a").addClass("hide");
            $(".search-icon").removeClass("hide");
            if (!$(".search-icon").hasClass("hide")) {
                var setOut = setTimeout(function () {
                    $(".banner-img-search").addClass("move-right");
                    searchStatus.statue = true;
                }, 10);
            }
        } else {
            if (searchStatus.statue == false) {
                return;
            }
            $(".banner-img-search").removeClass("move-right");
            if (!$(".search-icon").hasClass("hide") && !$(".banner-img-search").hasClass("move-right")) {
                var setOut = setTimeout(function () {
                    $(".search-icon").addClass("hide");

                    $(".banner-img-search").removeClass("search-scroll");
                    $(".search-body").removeClass("search-body-scroll");
                    $(".search-body").find("a").removeClass("hide");
                    searchStatus.statue = false;
                }, 10);
            }
        }
    },
    eventScroll: function () {
        $(window).on("scroll", function () {
            var that = this;
            that.srcTop = $(window).scrollTop();
            if (that.srcTop >= 40) {
                searchStatus.animateOpen = true;
                searchStatus.statueCircle();
            } else {
                searchStatus.animateOpen = false;
                searchStatus.statueCircle();
            }
        })
    }
}
//活动按钮
var actStatus = {
    statue: false,//默认状态;false为展开，true为圆圈
    srcTop: "",
    animateOpen: false,
    statueCircle: function () {
        var that = this;
        that.srcTop = $(window).scrollTop();
        if (actStatus.animateOpen == true) {
            //console.log(actStatus.statue);
            if (actStatus.statue == true) {
                return;
            }
            $(".provide-activity").show();
            setTimeout(function () {
                $(".provide-activity").css({
                    left: "85%",
                    opacity: "1"
                });
                //$(".provide-activity").addClass("show");
                actStatus.statue = true;
            }, 10)
        } else {
            //console.log(actStatus.statue);
            if (actStatus.statue == false) {
                return;
            }
            //$(".provide-activity").removeClass("show");
            $(".provide-activity").css({
                left: "4%",
                opacity: "0"
            });
            setTimeout(function () {
                $(".provide-activity").hide();
                actStatus.statue = false;
            }, 400)
        }
    },
    eventScroll: function () {
        $(window).on("scroll", function () {
            actStatus.srcTop = $(window).scrollTop();
            //console.log( actStatus.srcTop,(bOffset+bHei));
            if (actStatus.srcTop >= (bOffset + bHei)) {
                actStatus.animateOpen = true;
                actStatus.statueCircle();
            } else {
                actStatus.animateOpen = false;
                actStatus.statueCircle();
            }
        })
    }
}

//菜单动画
var navStatus = {
    statue: true,//默认状态;false为展开，true为圆圈
    srcTop: "",
    animateOpen: true,
    statueCircle: function () {
        var that = this;
        that.srcTop = $(window).scrollTop();
        if (navStatus.animateOpen == true) {
            //console.log(navStatus.statue);
            if (navStatus.statue == true) {
                return;
            }
            $(".nav-fix").show();
            setTimeout(function () {
                $(".nav-fix").css({
                    left: "85%",
                    opacity: "1"
                });
                //$(".nav-fix").addClass("show");
            }, 10);
            navStatus.statue = true;
        } else {
            //console.log(navStatus.statue);
            if (navStatus.statue == false) {
                return;
            }
            //$(".nav-fix").removeClass("show");
            $(".nav-fix").css({
                left: "4%",
                opacity: "0"
            })
            $(".nav-point").parent().removeClass("nav-fix-active");
            setTimeout(function () {
                $(".nav-fix").hide();
                navStatus.statue = false;
            }, 400);
        }
    },
    eventScroll: function () {
        $(window).on("scroll", function () {
            navStatus.srcTop = $(window).scrollTop();
            //console.log( navStatus.srcTop,(bOffset+bHei));
            if (navStatus.srcTop >= (dOffset + dHei)) {
                navStatus.animateOpen = true;
                navStatus.statueCircle();
            } else {
                navStatus.animateOpen = false;
                navStatus.statueCircle();
            }
        })
    }
}
searchStatus.eventScroll();
actStatus.eventScroll();
navStatus.eventScroll();
//phoneStatus.eventScroll();

$(".banner-img-search").on("click", function () {
    $(".banner-img-search,.search-body,.search-icon").stop();
    //$(window).unbind("scroll");
    searchStatus.statue = false;
    $(".banner-img-search").removeClass("move-right").removeClass("show");
    setTimeout(function () {
        if (!$(".banner-img-search").hasClass("move-right")) {
            $(".banner-img-search").removeClass("move-right");
            $(".search-icon").addClass("hide");
            $(".banner-img-search").removeClass("search-scroll");
            $(".search-body").removeClass("search-body-scroll");
            $(".search-body").find("a").eq(0).removeClass("hide");
            setTimeout(function () {
                $(".banner-img-search").removeClass("move-right");
                $(".search-body").find("a").eq(1).removeClass("hide");
                //$(window).bind("scroll", winScroll);
            }, 400);
        }
    }, 400);

});
$(".nav-point").on("click", function () {
    $(this).parent().toggleClass("nav-fix-active");
});

$(".city-option").on("click", function () {
    $(".city-select").addClass("city-select-active");
});
$(".close-city-select").on("click", function () {
    $(".city-select").removeClass("city-select-active");
});
$(".city-show-li").find("li").on("click", function () {
    var city = $(this).text();
    $(".position-city-name").text(city);
    $(".city-select").removeClass("city-select-active");
});
//$(".search").on("click", function () {
//    $(".search-bar").addClass("search-bar-active");
//});
$(".cancel-search").on("click", function () {
    $(".search-bar").removeClass("search-bar-active");
})
//$(".search-in").on("keyup",function(){
//    if(1){
//        var cloneSearch=$(".search-show-li").find("li").first().clone().removeClass("hide");
//            cloneSearch.appendTo(".search-show-li");
//    }
//})