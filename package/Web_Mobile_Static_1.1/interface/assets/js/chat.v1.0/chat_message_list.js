$(document).ready(function () {
    YunSpace.api('livechat/message/list.jsonp', {

    }, function (data) {
        if (data.status == 1) {
            var  host = window.location.host;
            var dataList = data.data;

            var listHTML = '';
            var avatar = '';
                for (key in dataList) {
                    if (dataList[key]['avatar']) {
                        avatar = dataList[key]['avatar'];
                    } else {
                        avatar = '/package/Web_Mobile_Static_1.1/interface/assets/imgat.v1.0/icon.png';
                    }
                    listHTML += '<li>'+
                    '<a href="http://'+host+'/m/chat/chat_body?to_id='+dataList[key]['relation_id']+'&to_name='+dataList[key]['relation_name']+'" class="js-send-message">'+
                    '  <div class="message-person-img">'+
                    '       <img src="' + avatar + '" alt=""/>'+
                    ' </div>'+
                    ' <div class="message-title">'+
                    '    <p class="message-text1 block">'+dataList[key]['relation_name']+'</p>'+
                    '    <p class="message-text2 block">'+dataList[key]['message']+'</p>'+
                    '</div>'+
                    '<div class="tip absolute">'+
                    '  <p class="tip-time block">'+dataList[key]['end_time']+'</p>'+
                   // '  <p class="tip-number block">13</p>'+
                    ' </div>'+
                    ' </a>'+
                    ' </li>';
                }
            $(".message-list").html(listHTML);
        }
    });

});