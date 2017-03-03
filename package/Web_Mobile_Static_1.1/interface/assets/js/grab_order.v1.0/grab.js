$(function () {

    /*抢单列表-回到顶部*/
    $(window).scroll(function () {
        if ($(window).scrollTop() > 200) {
            $('.js-upward, .js-reload').fadeIn(500);
        }
        else {
            $('.js-upward, .js-reload').fadeOut(500);
        }
    });
    $('.js-upward-btn').on('click', function () {
        $('body,html').animate({scrollTop: 0}, 500);
    });

    /*弹窗-提交进度记录*/
    $('.js-cancel').click(function () {
        $('.popup_bg').remove();
        $('.pop-submit').fadeOut(200);
    });

    $(".js-update-btn").on('click', function () {
        $(".pop-submit").fadeIn().after('<div class="popup_bg"></div>');
    });
    /*重复单关闭-关闭理由下拉*/
    $("#col-selected").on('change', function () {
        var value = $(this).val();
        if (value == -1 || value == -2) {
            $("#input-reason").addClass('hide');
            $('.col.col-reason').removeClass('hide');
        } else {
            $('.col.col-reason').addClass('hide');
            $("#input-reason").removeClass('hide');

        }
    });
    $("input[name='reason']").on('change', function () {
        var value = $(this).val();
        if (value == 2000) {
            $('.reason-textarea').removeClass('hide');
        } else {
            $('.reason-textarea').addClass('hide');
        }
    })

});

var addTimer = function () {
    var list = [],
        interval;

    return function (id, time) {
        if (!interval)
            interval = setInterval(go, 1000);
        list.push({ele: document.getElementById(id), time: time});
        return time;
    }

    function go() {
        for (var i = 0; i < list.length; i++) {
            list[i].ele.innerHTML = getTimerString(list[i].time ? list[i].time -= 1 : 0);
            if (!list[i].time)
                list.splice(i--, 1);
        }
    }

    function getTimerString(time) {
        d = Math.floor(time / 86400),
            h = Math.floor((time % 86400) / 3600),
            m = Math.floor(((time % 86400) % 3600) / 60),
            s = Math.floor(((time % 86400) % 3600) % 60);
        if (time > 0) {
            var timeString = '';
            if (d) {
                timeString = timeString + d + '天';
            }
            if (h) {
                timeString = timeString + h + '小时';

            }
            if (m) {
                timeString = timeString + m + '分';
            }
            return timeString + s + "秒";


        } else {
            return 0;
        }
    }
}();