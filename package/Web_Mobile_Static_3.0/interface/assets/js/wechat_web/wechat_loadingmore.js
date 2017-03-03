/**
 * Created by Administrator on 2015/10/13.
 */

var c = 1;
var led=false;
$(window).on("scroll", function () {
    var docScrolltop=$(document).scrollTop();
    var docHeight=$(document).height();
    var winHeight=$(window).height();

    if (docScrolltop + winHeight > docHeight - 100 && c != 0)// 接近底部100px
    {
        if(led==true){
            return;
        }
        led=true;
        YunSpace.api('wechat/web/article/list.json', {
            'num': 5,
            'category_id':$('.category_id').val(),
            'update_time': $(".article_list>li").last().attr('data-updateTime')
        }, function (data) {
            if (data.status == 1) {
                setTimeout(function(){
                    led=false;
                },1);
                $(".article_list").append(data.data);
            } else {
                $(".load-more").text('没有更多啦...');
                c = 0;
            }
        });

    }
});
$('.load-more').click(function(){
    YunSpace.api('wechat/web/article/list.json', {
        'num': 5,
        'category_id':$('.category_id').val(),
        'update_time': $(".article_list>li").last().attr('data-updateTime')
    }, function (data) {
        if (data.status == 1) {
            setTimeout(function(){
                led=false;
            },1);
            $(".article_list").append(data.data);
        } else {
            $(".load-more").text('没有更多啦...');
            c = 0;
        }
    });
});