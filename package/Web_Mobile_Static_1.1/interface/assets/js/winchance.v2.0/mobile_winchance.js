/**
 * Created by Administrator on 2015/10/13.
 */

var c = 1;
var led=false;
$(window).bind("scroll", function () {
    if ($(document).scrollTop() + $(window).height() > $(document).height() - 100 && c != 0)// 接近底部100px
    {
        if(led==true){
            return;
        }
        led=true;
        YunSpace.api('winchance/list.json', {
            'num': 5,
            'create_time': $(".w-act-cont").last().attr('data-createTime')
        }, function (data) {
            if (data.status == 1) {
                setTimeout(function(){
                    led=false;
                },1);
                $("#content").append(data.data);
            } else {
                $(".load-more").text('没有更多啦...');
                c = 0;
            }
        });

    }
});