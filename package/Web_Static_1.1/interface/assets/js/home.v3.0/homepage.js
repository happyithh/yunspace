/**
 * Created by pzl on 15/8/31.
 */
var browser = navigator.appName
var b_version = navigator.appVersion
var version = b_version.split(";");
if (version.length > 1) {
    var trim_Version = version[1].replace(/[ ]/g, "");
    if (browser == "Microsoft Internet Explorer" && (trim_Version == "MSIE7.0" || trim_Version == "MSIE8.0")) {
        $(".header-find-room").addClass("header-find-room-ie");
        $(".cover-body").addClass("cover-body-ie");
        //$(".d-s-input").find("input").css({
        //    paddingTop: "10px"
        //});
        $(".dropDown").css({
            background: "#fff"
        });
        $(".cov").addClass("cov-ie");
        $(".product-name-title").addClass("product-name-title-ie");
    }
    if (browser == "Microsoft Internet Explorer" && (trim_Version == "MSIE9.0" || trim_Version == "MSIE10.0")) {
        $(".d-s-input").find("input").addClass('input-ie9-10');
    }
    if (browser == "Netscape" && trim_Version == "WOW64") {
        $(".d-s-input").find("input").css({
            paddingBottom: "13px"
        });
    }
}

//弹出层效果
$(document).ready(function () {
    init();
    $(".pro-con-body li:nth-child(4n)").css({ marginRight:"0px" });
});
function init() {
    var cate = ["推荐", "套餐", "展馆", "广场", "会所", "服务", "攻略", "文创合作"];
    var floor = ["1F", "2F", "3F", "4F", "5F", "6F", "7F", "文创合作"];
    var offset = ["p1", "p2", "p3", "p4", "p5", "p6", "p7"];
    var offsetTop = [];
    for (var k in offset) {
        if ($('.p-mao').eq(k).size() > 0) {
            var offTop = $('.p-mao').eq(k).offset().top - 200;
        }
        offsetTop.push(offTop);
    }
    offsetTop.push(offTop + 500);
    $(window).on("scroll", function () {
        var sh = $(window).scrollTop();
        for (var i in floor) {
            $(".mao").eq(i).text(floor[i]);
            if (offsetTop[i]) {
                var j = i * 1 + 1;
                if (sh >= offsetTop[i] && sh < offsetTop[j]) {
                    $(".mao").css({
                        color: "rgb(161, 165, 177)"
                    })
                    $(".mao").eq(i).text(cate[i]);
                    $(".mao").eq(i).css({
                        color: "#45e5e3"
                    })
                }
            }
        }
        var h2 = $(".range-room").height();
        var aH = allH - h2 - 20;
        var tH = $(window).scrollTop() + $(window).height();
        if (tH > aH) {
            $(".range-room").addClass("range-room-active");
        } else {
            $(".range-room").addClass("range-room-active");
        }
        if ($(".range-room").hasClass("range-room-active")) {
            $(".icon-mouse").hide();
        } else {
            $(".icon-mouse").show();
        }
        var sT2 = allH + $(".tag").outerHeight();
        if ($(window).scrollTop() >= sT2) {
            $(".mao-all").removeClass("hide");
        } else {
            $(".mao-all").addClass("hide");
        }
    });


//标签特效
    $(".tag").find("li").hover(function () {
        $(this).find(".icon-tip").css({
            marginTop: "-114px"
        })
    }, function () {
        $(this).find(".icon-tip").css({
            marginTop: "0px"
        })
    });
//图片遮罩
    $(".pro-con-body").find("li").hover(function () {
        $(this).find(".product-name-title").addClass("product-name-title-active");
        $(this).find(".p-name").addClass("p-name-active");
        $(this).find(".p-n-d-1").addClass("p-n-d-1-active");
        $(this).find(".p-n-d-2").addClass("p-n-d-2-active");
        $(this).find(".p-n-d-3").removeClass("hide");
        if (browser == "Microsoft Internet Explorer" && (trim_Version == "MSIE7.0" || trim_Version == "MSIE8.0" || trim_Version == "MSIE9.0")) {
            $(this).find(".product-name-title").addClass("product-name-title-ie-active")
        }
    }, function () {
        $(this).find(".product-name-title").removeClass("product-name-title-active");
        $(this).find(".p-name").removeClass("p-name-active");
        $(this).find(".p-n-d-1").removeClass("p-n-d-1-active");
        $(this).find(".p-n-d-2").removeClass("p-n-d-2-active");
        $(this).find(".p-n-d-3").addClass("hide");
        if (browser == "Microsoft Internet Explorer" && (trim_Version == "MSIE7.0" || trim_Version == "MSIE8.0" || trim_Version == "MSIE9.0")) {
            $(this).find(".product-name-title").removeClass("product-name-title-ie-active")
        }
    });
    $(".cover-t").hover(function () {
        $(this).find(".cov").fadeIn(200);
        $(this).find(".cov-title").animate({
            top: "45%"
        }, 400);
        $(this).find(".cov-des").animate({
            opacity: "1",
            top: "53%"
        }, 400);
        $(this).find(".cov-btn").animate({
            bottom: "20px",
            opacity: "1"
        })
    }, function () {
        $(this).find(".cov").stop();
        $(this).find(".cov-title").stop();
        $(this).find(".cov-des").stop();
        $(this).find(".cov-btn").stop();
        $(this).find(".cov").hide();
        $(this).find(".cov-title").css({
            top: "50%"
        });
        $(this).find(".cov-des").css({
            opacity: "0",
            top: "60%"
        });
        $(this).find(".cov-btn").css({
            bottom: "-30px",
            opacity: "0"
        });
    });
//锚点
    $(".tag-link").each(function (index, dom) {
        mao(index, dom);
    });
    $(".mao").each(function (index, dom) {
        mao(index, dom);
    });
    function mao(index, o) {
        $(o).on("click", function () {
            for (var k in floor) {
                //console.log(floor[k]);
                $(".mao").eq(k).html(floor[k]);
            }
            var info = cate[index];
            $(".mao").css({
                color: "#a1a5b1"
            })
            $(".mao").eq(index).text(info).css({
                color: "#45e5e3"
            });
        })
    }

    //$(".mobile_phone a").click(function () {
    //    $('.dayer2').toggle();
    //    $('.mobile_phone_sao').show();
    //});

    //$('.dayer2').click(function () {
    //    $(this).hide();
    //    $('.hint').hide();
    //    $('.mobile_phone_sao').hide();
    //});
//鼠标响应
    $(window).resize(function () {
        wH = $(window).height();
        var h2 = $(".range-room").height();
        var aH = allH - h2;
        var sT = $(window).scrollTop();
        if (wH + sT <= aH) {
            $(".range-room").removeClass("range-room-active");
        } else {
            $(".range-room").addClass("range-room-active");
        }
        if (!$(".range-room").hasClass("range-room-active")) {
            $(".icon-mouse").show();
        } else {
            $(".icon-mouse").hide();
        }
    });


    $(".demand-back").on("click", function () {
        var dId = $(this).data("id");
        if (dId == 0) {
            $(".demand-full").addClass("hide");
            var demandFull = $(".demand-full").first().clone().removeClass("hide");
            demandFull.appendTo(".show-demand");
            $(".bottom-submit").addClass("hide");
            $(".bottom-submit").first().removeClass("hide");
            $(".d-s-title").text("我要办活动");
            $(".show-demand").css({
                height: "auto"
            })
        } else {
            //$(".demand-first").remove();
            $(".demand-full").addClass("hide");
            $(".demand-next").removeClass("hide");
            $(".bottom-submit").addClass("hide");
            $(".bottom-submit").eq(1).removeClass("hide")
        }
    })
    for (var i in floor) {
        $(".mao").eq(i).text(floor[i]);
    }
    var dw = $(".d-s-input").width();
    $(".date-picker").css({
        width: dw + "px"
    });
    var sw = $(".submit-success").outerWidth();
    $(".submit-success").css({
        marginLeft: "-" + sw / 2 + "px"
    });
    $(".home_question").eq(0).show();
    var sh = $(window).scrollTop();
    var h2 = $(".range-room").height();
    var aH = allH - h2 - 30;
    var sT = $(window).scrollTop();
    if (aH <= sh) {
        $(".header-find-room").removeClass("hide");
    } else {
        $(".header-find-room").addClass("hide");
        $(".triangle-down,.need-activity").hide();
    }
    var sT2 = allH + $(".tag").outerHeight();
    //console.log(sT2,$(window).scrollTop());
    if ($(window).scrollTop() >= sT2) {
        $(".mao-all").removeClass("hide");
    } else {
        $(".mao-all").addClass("hide");
    }
    if (wH + sT >= aH) {
        $(".icon-mouse").addClass("hide");
    } else {
        $(".icon-mouse").addClass("mouse-jump");
    }
    if ($(".range-room").hasClass("range-room-active")) {
        $(".icon-mouse").hide();
    }
    setInterval(function () {
        $(".icon-mouse").addClass("mouse-jump");
        setTimeout(function () {
            $(".icon-mouse").removeClass("mouse-jump");
        }, 1000);
    }, 5000);
    setTimeout(function () {
        if (wH <= aH) {
            $(".icon-mouse").show();
        } else {
            $(".range-room").addClass("range-room-active");
            if ($(".range-room").hasClass("range-room-active")) {
                $(".icon-mouse").hide();
            }
        }
    }, 200);
}
$(".demand-back").on("click", function () {
    var dId = $(this).data("id");
    $(".demand-body").eq(dId + 1).animate({
        top: "-100%"
    }, 400);
    setTimeout(function () {
        $(".demand-body").eq(dId).animate({
            top: "20%"
        }, 400);
    }, 200);
});

