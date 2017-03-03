/**
 * Created by pzl on 15/9/14.
 */
var allH,ww,wH,sh,h2,aH,topH,headerH,navH,carouselH;
function initHeader(){
     topH = $(".top").outerHeight();
     headerH = $(".header3").outerHeight();
     navH = $(".guide4_outside").outerHeight();
     carouselH = $(".carousel").outerHeight();
    allH = topH + headerH + navH + carouselH + 40;
    ww = $(window).width();
    wH = $(window).height();
    sh = $(window).scrollTop();
    h2 = $(".range-room").height();
    aH = allH - h2 - 20;
    if (aH <= sh) {
        $(".header-find-room").removeClass("hide");
    } else {
        $(".header-find-room").addClass("hide");
        $(".triangle-down,.need-activity").hide();
    }
//打开下拉
$(".select-click").on("click", function () {
    $(".dropDown").hide();
    $(".select-click").removeClass("act");
    $(this).addClass("act");
    $(this).parent().find(".dropDown").fadeIn(200);
    $(".select-click").find("span").removeClass("s-s-active");
    $(this).find("span").addClass("s-s-active");
});

$(".select-hover").hover(function () {
    $(".dropDown").hide();
    $(".select-click").removeClass("act");
    $(this).addClass("act");
    $(this).parent().find(".dropDown").show();
    $(".select-click").find("span").removeClass("s-s-active");
    $(this).find("span").addClass("s-s-active");
}, function () {
    $(this).parent().find(".dropDown").hide();
    $(this).find("span").removeClass("s-s-active");
});

$(".dropDown").find("li").on("click", function () {
    $(".dropDown").hide();
    $(".select-click").find("span").removeClass("s-s-active");
    var txt = $(this).text();
    var place = $(this).parent().parent().parent();
    if (place.find(".select-input").hasClass("cate-input")) {
        $(".par2").text(txt);
        $(".cate-input").val(txt);
    }
    if (place.find(".select-input").hasClass("city-input")) {
        //var txt1=$(this).find("a").text();
        $(".par4").text(txt);
        $(".city-input").val(txt);
        if ($(".city-input").val() != "") {
            place.parent().find(".distance").find(".select-click").trigger("click");
        }
    }
    if (place.find(".select-input").hasClass("person-input")) {
        $(".par1").text(txt);
        $(".person-input").val(txt);
        //console.log( $(".person-input").val());
        if ($(".person-input").val() != "") {
            place.parent().find(".distance").find(".select-click").trigger("click");
        }
    }
    if (place.find(".select-input").hasClass("area-input")) {
        $(".area-input").val(txt);
        if ($(".area-input").val() != "") {
            place.parent().find(".distance").find(".select-click").trigger("click");
        }
    }
    if (place.find(".select-input").hasClass("far-input")) {
        $(".par3").text(txt);
        $(".far-input").val(txt);
    }
    if (place.find(".select-input").hasClass("range-input")) {
        $(".par5").text(txt);
        $(".range-input").val(txt);
        //console.log($(".range-input").val());
    }
    if ($(this).parent().hasClass("city-select")) {
        $(this).find("a").css({
            background: "#000",
            color: "#fff"
        });
        $(this).siblings().find("a").css({
            background: "#fff",
            color: "#000"
        });
        //切换城市ajax请求
        YunSpace.Api("", function () {

        })
    } else {
        $(this).siblings().css({
            background: "#fff"
        });
        $(this).css({
            background: "#f2f2f2"
        });
    }
})
$(window).bind("scroll", function () {
    var sh = $(window).scrollTop();
    var h2 = $(".range-room").height();
    var aH = allH - h2 - 20;
    if (aH <= sh) {
        $(".header-find-room").removeClass("hide");
    } else {
        $(".header-find-room").addClass("hide");
        $(".triangle-down,.need-activity").hide();
    }
});
$(".f-room").on("click", function () {
    $(".cover-body").fadeIn(200);
    $(".demand-one").show();
    var wH = $(window).height();
    if (wH < 760) {
        var sT = $(window).scrollTop();
        $('.demand-body').css({
            'position': 'absolute'
        });
        $(".demand-one").animate({
            top: sT + wH * 0.1 + 'px'
        }, 400)
    } else {
        $('.demand-body').css({
            'position': 'fixed'
        });
        $(".demand-one").animate({
            top: "10%"
        }, 400)
    }
});
$(".cover-body,.demand-close").on("click", function () {
    $(".cover-body,.submit-success").fadeOut(200);
    $(".demand-body").animate({
        top: "-100%"
    }, 400, function () {
        $(".demand-body").hide();
    });

});
$('#datepicker').on("click", function () {
    $(".date-picker").removeClass("hide");
});
//打开遮罩下拉
$(".header-find-room").hover(function () {
    $(this).find(".party-title").stop().slideDown(200);
}, function () {
    $(this).find(".party-title").stop().slideUp(200);
});
$(document).on(
    ' click',
    function (e) {
        //console.log(e.target)
        var wd = $(".demand-body").width();
        var hd = $(".demand-body").height();
        $(".demand-body").css({
            marginLeft: "-" + wd / 2 + "px",
            marginHeight: "-" + hd / 2 + "px"
        })
        if ($(e.target).closest(".r-r-select").length === 0) {
            $(".r-r-select .dropDown").fadeOut(200, function () {
                $(".select1").find("span").removeClass("s-s-active");
            });
        }
        if ($(e.target).closest(".f-method").length === 0) {
            $(".f-method .dropDown").fadeOut(200, function () {
                $(".select2").find("span").removeClass("s-s-active");
            });
        }
        if ($(e.target).closest(".c-s-c-select2").length === 0) {
            if ($(".iframe").length > 0) {
                $(window.frames["home-frame"].document).find(".d-s-input").find(".dropDown").fadeOut(200, function () {
                    $(window.frames["home-frame"].document).find(".select4").find("span").removeClass("s-s-active");
                });
            }
            $(".c-s-c-select2 .dropDown").fadeOut(200, function () {
                $(".select3").find("span").removeClass("s-s-active");
            });
        }
        if ($(e.target).closest(".d-s-input").length === 0) {
            $(".d-s-input .dropDown").fadeOut(200, function () {
                $(".select4").find("span").removeClass("s-s-active");
            });
        }
        if ($(e.target).closest(".city_guide > li").length === 0) {
            $(".city_guide > li .dropDown").fadeOut(200, function () {
                $(".select5").find("span").removeClass("s-s-active");
            });
        }
        if ($(e.target).closest("#datepicker,.dp-table-controller").length === 0) {
            $(".date-picker").addClass("hide");
        }
    }
);
$(".mobile_phone a").click(function () {
    $('.dayer2').removeClass("none");
    $('.mobile_phone_sao').show();
});
$('.dayer2').click(function () {
    $(this).addClass("none");
    $('.hint').hide();
    $('.mobile_phone_sao').hide();
});
}
$(function(){
    initHeader();
})