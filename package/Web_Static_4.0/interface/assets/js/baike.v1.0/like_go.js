
$(function(){
    var space_id=$('body').data("sid");

    //渲染我喜欢和现场足迹页面
    YunSpace.api("baike/like/go.jsonp", {
        space_id:space_id,
        action:'fetch_like_go'
    }, function (data) {
        $(".person_side").html(data.data['tpl']);
        $(".like_go_total").text(parseInt(data.data['num']['people']));
    });

    //获取浏览量总数
    YunSpace.api("baike/like/go.jsonp", {
        space_id:space_id,
        action:'click_num'
    }, function (data) {
        if(data.data<100){
            $(".click_total").text(parseInt(data.data)+100);
        }else{
            $(".click_total").text(parseInt(data.data));
        }
    });



});