/**
 * Created by Administrator on 2015/10/13.
 */

var c = 1;
$(window).bind("scroll", function () {
    if ($(document).scrollTop() + $(window).height() > $(document).height() - 100 && c != 0)// 接近底部100px
    {
        YunSpace.api('winchance/list.json', {
            'num': 5,
            'create_time': $(".w-act-cont").last().attr('data-createTime')
        }, function (data) {
            if (data.status == 1) {
                $("#content").append(data.data);
            } else {
                $(".load-more").text('没有更多数据');
                c = 0;
            }
        });

    }
});