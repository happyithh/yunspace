
$(document).ready(function () {
    var re_id =  getUrlParam('re_id');

    YunSpace.api('livechat/relation/info.jsonp', {
        re_id : re_id
    }, function (data) {
        if (data.status == 1) {
            var  host = window.location.host;
            var dataInfo = data.data;
            $(".sculpture-body").find('img').attr("src",dataInfo['avatar']);
            $(".sculpture-body").find('p').html(dataInfo['username']);
            $(".sculpture-body").find('p').html(dataInfo['username']);
            if(dataInfo['disturb_status']==1){
                $("#disturb").val(1);
                $("#disturb").attr("checked","checked");
            }else{
                $("#disturb").val(0);
                $("#disturb").removeAttr("checked","");
            }
            if(dataInfo['black_status']==1){
                $("#blacklist").val(1);
                $("#blacklist").attr("checked","checked");
            }else{
                $("#blacklist").val(0);
                $("#blacklist").removeAttr("checked","");
            }
            $(".js-send-message").attr("href",'http://'+host+'/m/chat/chat_body?to_id='+dataInfo['relation_id']+'&to_name='+dataInfo['username']+'');
        }
    });
    $("#blacklist").change(function(){
        var blackstatus = 0;
        ($("#blacklist").val() == 1) ? blackstatus = 0 : blackstatus = 1;
        YunSpace.api('livechat/add/blacklist.jsonp', {
            re_id : re_id,
            status : blackstatus
        }, function (data) {
            if (data.status == 1) {
                blackinfo = data.data;
                $("#blacklist").val(blackinfo['status']);
            }
        });
    })
    $("#disturb").change(function(){
        var disturbstatus = 0;
        ($("#disturb").val() == 1) ? disturbstatus = 0 : disturbstatus = 1;
        YunSpace.api('livechat/free/disturb.jsonp', {
            re_id : re_id,
            status : disturbstatus
        }, function (data) {
            if (data.status == 1) {
                disturbinfo = data.data;
                $("#disturb").val(disturbinfo['status']);
            }
        });
    })

});

getUrlParam = function(name)
{
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r!=null) return unescape(r[2]); return null;
}