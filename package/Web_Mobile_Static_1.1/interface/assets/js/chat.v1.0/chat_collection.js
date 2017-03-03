var type = "space";
YunSpace.api('collection/getList.jsonp', {
    type:type
}, function (data) {


        if (data.status == 1) {
            var url ="";
            switch(type){
                case "space" :
                    url = "service_info";
                    break;
                case "set" :
                    url = "service_info";
                    break;
                case "vendor" :
                    url = "vendor_info";
                    break;
                case "event" :
                    url = "event_info";
                    break;
            }
            dataList = data.data;
            //不同的type模板不一样吧 如果一样的话,字段是不一样.收藏的联系人
            console.log(dataList);
            for (var k in  dataList) {
                newList = $("#recent-list").clone().removeClass('hidden').attr('id','');

                toUrl = 'http://' + window.location.host +'/'+url+'/' + dataList[k]['id'] + '.html' ;
                newList.find('a').attr('href', toUrl);
                newList.find('img').attr('src', dataList[k]['logo']);
                newList.find('.recent-name').text(dataList[k]['name']);
                newList.find('.recent-message').text(dataList[k]['addr']);
                newList.find('.recent-time').text(dataList[k]['create_time']);
                //newList.find('.recent-no-read').text(dataList[k]['counter_follow']);
                newList.appendTo("#chat-recents");
            }
        }
});