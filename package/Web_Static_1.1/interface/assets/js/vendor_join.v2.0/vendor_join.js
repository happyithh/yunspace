/**
 * Created by bll on 15/8/14.
 */
//没有阅读协议无法提交
//$(".j-submit").find("button").attr("disabled", true);
if ($(".j-register").hasClass("hide")) {
    $(".j-submit").find("button").attr("disabled", false).css({
        background: "rgb(255, 48, 142)"
    });
} else {
    $(".j-submit").find("button").attr("disabled", true).css({
        background: "#cac5c5"
    });
}
//提交成功后出现弹框
$(".j-submit").find("button").on("click", function () {
    var ok = true;
    if (ok) {
        $(".cover").fadeIn(400);
    } else {
        $(".j-register").show();
    }
})
$(".close-sub,.sub-ok").on("click", function () {
    $(".cover").fadeOut(400);
});
//复选框


$(".input-check").on("click", function () {
    $(this).find("span").toggleClass("ion-checkmark");
    if ($(this).find("span").hasClass("ion-checkmark")) {
        $(".j-check").find("input[type='checkbox']").prop("checked", true);
        $(".j-submit").find("button").attr("disabled", false).css({
            background: "#ff308e"
        });
    } else {
        $(".j-check").find("input[type='checkbox']").prop("checked", false);
        $(".j-submit").find("button").attr("disabled", true).css({
            background: "#cac5c5"
        });
        ;
    }
});


//没有提交成功就出现快速登陆


//分类选择
var htm = '', info, category_id, category_text;
$(".c-select").on("click", function () {
    $(".c-select").find("span").toggleClass("ion-arrow-up-b");
    $(".c-list-parent").slideToggle(100);
    if (!$(".c-select").find("span").hasClass("ion-arrow-up-b")) {
        $(".c-list-son").fadeOut(100);
        $(".c-list-grandson").fadeOut(100);
    }
});
$(".c-list-parent,.cate").hover(function () {
}, function () {
    $(".c-list-parent").hide();
    $(".c-select").find("span").removeClass("ion-arrow-up-b");
});
$(".c-list-parent > li").click(function () {
    $(this).siblings().find(".c-list-son").slideUp(100);
    $(this).siblings().find(".c-l-p-icon").removeClass("ion-arrow-down-b").addClass("ion-arrow-right-b ");
    $(this).find(".c-list-son").slideDown(100);
    $(this).find(".c-l-p-icon").removeClass("ion-arrow-right-b").addClass("ion-arrow-down-b");
});
$(".c-list-son > li").on("click", function () {
    category_text = $(this).find("a").text();
    category_id = $(this).find("a").attr('data-value');
    $(".c-select").find("p").text(category_text).css({
        color: "#000"
    });
    $(".select-val").val(category_text);
});

//城市选择
var province, city, all = "";
$(".city-selects").first().on("click", function () {
    if ($(".city-selects").eq(1).find("p").text("") != "") {
        $(".input-city").val("");
        $(".city-selects").eq(1).find("p").text("城市").css({
            color: "#a9a9a9"
        });
    }
    $(this).find("span").addClass("ion-arrow-up-b");
    $(this).parent().find(".province-city").slideDown(100);
    $(this).parent().find(".province-city").hover(function () {
    }, function () {
        $(this).parent().find(".province-city").hide();
        $(".city-selects").first().find("span").removeClass("ion-arrow-up-b");
    });
});
$(".city-selects").eq(1).on("click", function () {
    if (!province) {
        $('.city-selects').eq(0).click();
        return false;
    }
    $(this).find("span").addClass("ion-arrow-up-b");
    $(this).parent().find(".province-city").slideDown(100);
    $(this).parent().find(".province-city").hover(function () {
    }, function () {
        $(this).parent().find(".province-city").hide();
        $(".city-selects").eq(1).find("span").removeClass("ion-arrow-up-b");
    });
});


/**
 *选择省份
 */
$(".ul-province li").on('click', function () {
    var province_code = $(this).attr('data-value');
    var name = $(this).text();
    YunSpace.api('city/auto/complete.jsonp', {
        'province_code': province_code
    }, function (data) {
        if (data.status == 1) {
            var k = '';
            var liHtml = '';
            for (k in data.data) {
                liHtml += '<li onclick="selectCity(this)" data-value="' + data.data[k]['name'] + '">' + data.data[k]['name'] + '</li>';
            }
            $(".ul-city").html(liHtml);
            province = name;
            $('.input-province').val(province);
            $(".city-selects").first().find("p").text(province).css({
                color: "#000"
            });
            $(".city-selects").eq(1).find("span").addClass("ion-arrow-up-b");
            $(".city-selects").eq(1).parent().find(".province-city").slideDown(100);
            $(".city-selects").eq(1).parent().find(".province-city").hover(function () {
            }, function () {
                $(this).parent().find(".province-city").hide();
                $(".city-selects").eq(1).find("span").removeClass("ion-arrow-up-b");
            });
        }
    });
});

/**
 * 选择市
 */
function selectCity(e) {
    city = $(e).text();
    $('.input-city').val(city);
    $(".city-selects").eq(1).find("p").text(city).css({
        color: "#000"
    });
}
/*显示协议*/
var h, w, w1, h1;
function wp() {
    h = $(window).height();
    w = $(window).width();
    w1 = w * 0.7;
    h1 = h * 0.8;
    return h, w, w1, h1;
}
function init1() {
    wp();
    $("body").css({
        height: "100%",
        overflow: "inherit"
    });
    $(".agreement").css({
        width: w1,
        height: h1,
        left: "50%",
        top: "-100%",
        marginLeft: -w1 / 2,
    });
}
function init2() {
    wp();
    $("body").css({
        height: h1,
        overflow: "hidden"
    });
    $(".agreement").css({
        width: w1,
        height: h1,
        left: "50%",
        top: "-100%",
        marginLeft: -w1 / 2,
        top: "50%",
        marginTop: -h1 / 2,
        opacity: 1
    });
}
init1();
$(".read-agreement").on("click", function () {
    $(".agreement").css({
        display: "block"
    })
    init2();
    $(".cover2").fadeIn(200);
    $(window).resize(function () {
        init2();
    });
});
$(".cover2,.close-agreement").on("click", function () {
    $(".cover2").fadeOut(200);
    init1();
    setTimeout(function () {
        $(".agreement").css({
            display: "none"
        })
    }, 400);
});

var vendor_name, auth_code, phone;
/***提交start**/
$('.j-submit button').click(function () {
    //参数
    var province = $('input[name=province]').val();
    city = $('input[name=city]').val();
    if (!city) {
        $('.city-selects').parent().parent().parent().find(".error-tip").html("请选择城市~");
        $('.city-selects').eq(1).click();
        return false;
    } else {
        $('.city-selects').parent().parent().parent().find(".error-tip").html("");
    }
    var product_type = $("input[name=product_type]").val();
    if (!product_type) {
        $('.c-select').parent().parent().parent().find(".error-tip").html("请选择商品类型哦~");
        $('.c-select').click();
        return false;
    } else {
        $('.c-select').parent().parent().parent().find(".error-tip").html("");
    }
    var product_name = $('input[name=product_name]').val();
    if (!product_name) {
        $('input[name=product_name]').parent().find(".error-tip").html("商品名称不能为空哦~");
        $('input[name=product_name]').focus();
        return false;
    } else {
        $('input[name=product_name]').parent().find(".error-tip").html("");
    }

    vendor_name = $('input[name=vendor_name]').val();

    if (!vendor_name || vendor_name.length < 3 || vendor_name.length > 18) {
        $('input[name=vendor_name]').parent().find(".error-tip").html("供应商名称为3-18位字符~");
        $('input[name=vendor_name]').focus();
        return false;
    } else {
        $('input[name=vendor_name]').parent().find(".error-tip").html("");
    }

    var contact_people = $('input[name=contact_people]').val();

    if (!contact_people) {
        $('input[name=contact_people]').parent().find(".error-tip").html("联系人不能为空哦~");
        $('input[name=contact_people]').focus();
        return false;
    } else {
        $('input[name=contact_people]').parent().find(".error-tip").html("");
    }

    phone = $('input[name=phone]').val();
    checkPhone = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
    if (!checkPhone.test(phone)) {
        $('input[name=phone]').parent().find(".error-tip").html("请填写正确的手机号码~");
        $('input[name=phone]').focus();
        return false;
    } else {
        $('input[name=phone]').parent().find(".error-tip").html("");
    }
    var card = $('input[name=card]').val();
    var product_media = $('input[name=media]').val();

    if (!product_media[0]) {
        $('input[name=media]').parent().parent().parent().find(".error-tip").html("请上传产品图片，格式为jpg,png,jpeg，大小不超过10M哦~")
        return false;
    } else {
        $('input[name=media]').parent().parent().parent().find(".error-tip").html("")
    }
    var product_des = $('textarea[name=product_des]').val();
    if (!product_des) {
        $('textarea[name=product_des]').parent().find(".error-tip").html("请对产品做一些简单介绍吧~");
        $('textarea[name=product_des]').focus();
        return false;
    } else {
        $('textarea[name=product_des]').parent().find(".error-tip").html("");
    }

    if ($('.j-register').is(":visible")) {
        phone = $("input[name=account_phone]").val();
        $('input[name=phone]').val(phone);
        auth_code = $("input[name=code]").val();
        if (!auth_code) {
            $("input[name=code]").focus();
            return false;
        }
    }
    phone = $('input[name=phone]').val();
    YunSpace.api('vendor/join.jsonp', {
        city: city,
        category_id: category_id,
        product_name: product_name,
        product_des: product_des,
        vendor_name: vendor_name,
        contact_people: contact_people,
        phone: phone,
        card: card,
        media: product_media,
        auth_code: auth_code,
        other: {
            所在省市: province + city
        }
    }, function (data) {
        if (data.status == 1) {
            alert(data.msg);
            window.location.href = '/vendor_center/vendor_admin/vendor_edit?vendor_id=' + data.data;
        } else if (data.status == 2) {
            //验证手机号
            $("input[name=account_phone]").val(phone);
            $('.j-register').removeClass("hide");
        } else if (data.status == 3) {
            alert('验证码错误~');
            $("input[name=code]").focus();
            return false;
        } else {
            alert(data.msg);
        }
    });
});
/***提交end**/

$(".input-check").click();




