/**
 * Created by Alex Shen on 2015/8/7.
 */
var currentDate = new Date();
var currentYear = currentDate.getFullYear();
var currentMonth = currentDate.getMonth() + 1;
$(document).ready(function (e) {
    /* enter */
    $(".broke-news-info-content").css("max-height", document.body.clientHeight - 140);
    $(".js-show-broke-info").click(function (e) {
        $(".broke-news-info-content").addClass("active");
        $(".mask-layer").addClass("active");
    });
    $(".js-hide-broke-info").click(function (e) {
        $(".broke-news-info-content").removeClass("active");
        $(".mask-layer").removeClass("active");
    });

    /* form */
    $(".js-toggle-rule").click(function () {
        $(".broke-news-form-rule").toggleClass("unset");
        updateSubmitButton();
    })
    $(".js-contact").blur(updateSubmitButton).keyup(updateSubmitButton);
    $(".js-contact-num").blur(updateSubmitButton).keyup(updateSubmitButton);
    $(".js-broke-contact-num").blur(updateSubmitButton).keyup(updateSubmitButton);
    // 提交用户爆料信息
    $(".js-broke-the-news").click(function (e) {
        if ($(this).hasClass("disabled")) {
            return false;
        }
        var city = $('#city').val();
        var type = $('#type').val();
        var demand_name = $('.js-contact').val();
        var phone = $('.phone-num').val();
        var otherData = $('.otherData').val();
        var submit_person = $('.js-broke-contact-num').val();
        var action = 'broke';
        YunSpace.api('demand/create.jsonp',
            {
                city: city,
                type: type,
                contact_people: demand_name,
                phone: phone,
                submit_person: submit_person,
                otherData:otherData,
                action: action
            },
            function (data) {
                if (data.status == 1) {
                    var newUrl = $(".show-my-news-button").attr("href");
                    $(".broke-news-form-info").addClass("active");
                    $(".mask-layer").addClass("active");
                    $(".show-my-news-button").attr("href", newUrl);
                } else {
                    top.alert(data.msg);
                }
            }
        )

    });

    $(".js-hide-broke-news-form-info").click(function (e) {
        $(".broke-news-form-info").removeClass("active");
        $(".mask-layer").removeClass("active");
        $(".js-contact-num").val("");
        $(".js-contact").val("");
        updateSubmitButton();
    });
    $(".broke-news-mine-month table").width(document.body.clientWidth-80);
    $(".js-show-month").click(function (e) {
        if ($(".broke-news-mine-month").hasClass("active")) {
            $(".broke-news-mine-month").removeClass("active");
            $(this).removeClass("ion-chevron-up").addClass("ion-chevron-down");
            $(".mask-layer").removeClass("active");
            $(".mask-layer").css("top", "0");
        } else {
            $(".broke-news-mine-month").addClass("active");
            $(this).removeClass("ion-chevron-down").addClass("ion-chevron-up");
            $(".mask-layer").addClass("active");
            $(".mask-layer").css("top", "44px");
        }
    });
    //根据月份查询 用户对应的爆料信息
    $(".js-date-data").click(function (e) {
        var year = $(this).find(".js-tb-year").text();
        var month = $(this).find(".js-tb-month").text();
        var dataDate = $(this).find(".js-tb-year").text() + "-" + $(this).find(".js-tb-month").text();

        YunSpace.api('broke/listPreview.jsonp',
            {
                search_time: dataDate
            },
            function (data) {
                if (data.status == 1) {
                    $('.sumBroke').text(data.data['sumBroke']);
                    $('.waitingBroke').text(data.data['waitingBroke']);
                    $('.abandonBroke').text(data.data['abandonBroke']);
                    $('.doneBroke').text(data.data['doneBroke']);
                    $('#num').text(data.data['reward']['num']);
                    $('#reward_price').text(data.data['reward']['reward_price']);
                    $('.reward').text(data.data['reward']['reward'] + '元');
                    $('.price').text(data.data['reward']['price'] + '元/条');
                    $('.js-year').text(year);
                    $('.js-month').text(month);
                    $(".broke-news-mine-month").removeClass("active");
                    $(this).removeClass("ion-chevron-up").addClass("ion-chevron-down");
                    $(".mask-layer").removeClass("active");
                    $(".mask-layer").css("top", "0");
                } else {
                    top.alert(data.msg);
                    javascript:history.go(0);
                }
            }
        )
    });
    function updateSubmitButton() {
        if (("" !== $(".js-contact").val()) &&
            ("" !== $(".js-contact-num").val()) &&
            ("" !== $(".js-broke-contact-num").val()) &&
            (!$(".broke-news-form-rule").hasClass("unset"))) {
            $(".js-broke-the-news").removeClass("disabled");
        } else {
            $(".js-broke-the-news").addClass("disabled");
        }
    }

    initDateInfo();
    function initDateInfo() {
        $(".js-year").text(currentYear);
        $(".js-month").text(currentMonth);
        var year = currentYear;
        var month = currentMonth;
        for (var i = 0; i < $(".js-date-data").length; i++) {
            $(".js-tb-year").eq(i).text(year);
            $(".js-tb-month").eq(i).text(month);
            if (month === 1) {
                month = 12;
                year--
            } else {
                month--;
            }
        }
    }
});
