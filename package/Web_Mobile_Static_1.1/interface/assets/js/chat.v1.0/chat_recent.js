YunSpace.api('livechat/message/list/new.jsonp', {}, function (data) {
    if (data.status == 1) {
        dataList = data.data;
        console.log(dataList);
        var toUrl = '';     //聊天的URL
        for (var k in  dataList) {
            newList = $(".recent-item").clone().removeClass('hidden');
            toUrl = 'http://' + window.location.host + '/m/chat/chat_body?to_id=' + dataList[k]['relation_account_id'] + '&to_name=' + dataList[k]['username'];
            newList.find('a').attr('href', toUrl);
            newList.find('img').attr('src', dataList[k]['avatar']);
            newList.find('.recent-name').text(dataList[k]['username']);
            newList.find('.recent-message').text(dataList[k]['message']);
            newList.find('.recent-time').text(dataList[k]['end_time']);
            newList.find('.recent-no-read').text(dataList[k]['total']);
            newList.appendTo(".chat-recent");
        }
    }
});