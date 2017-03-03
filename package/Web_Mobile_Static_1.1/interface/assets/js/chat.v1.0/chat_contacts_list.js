function tabActive(id, event, callback) {
    $(id).on(event, function () {

        $(this).siblings().removeClass("chat-list-tab-active");
        $(this).addClass("chat-list-tab-active");
        if (callback) {
            callback();
        }
    })
}
//联系人分类
function relationType(type) {
    YunSpace.api('livechat/contacts/list.jsonp', {

    }, function (data) {

        if (data.status == 1) {
            var host = window.location.host;
            var dataList = data.data.data;
            var letter = data.data.letter;
            var listHTML = '';
            //listHTML = '<ul class="chat-list-li">' +
            //'<li class=" relative">' +
            //' <a href="" class="chat-list-link block">' +
            //' <div class="chat-list-img absolute "><img src="img/chat.v1.0/icon.png" alt=""/></div>' +
            //' <p class="chat-list-text block">创建群聊</p>' +
            //' </a>' +
            //'<div class="clear"></div>' +
            //'</li>' +
            //'</ul>';
            var avatar = '';
            for (key in letter) {
                listHTML += '<ul class="chat-list-li">' +
                '<li class="height-1"><div class="sort">' + letter[key] + '</div></li>';
                for (kkey in dataList) {
                    if (dataList[kkey]['avatar']) {
                        avatar = dataList[kkey]['avatar'];
                    } else {
                        avatar = '/package/Web_Mobile_Static_1.1/interface/assets/imgat.v1.0/icon.png';
                    }

                    if (letter[key] == dataList[kkey]['initials']) {
                        listHTML += '<li  class="relative">' +
                        '<a href="http://' + host + '/m/chat/chatter_message?re_id=' + dataList[kkey]['contact_account_id'] + '" class="chat-list-link block js-chat-list-link">' +
                        '<div class="chat-list-img absolute"><img src="' + avatar + '" alt=""/></div>' +
                        '<p class=" chat-list-text block">' + dataList[kkey]['contact_name'] + '</p>' +
                        '</a>' +
                        '</li>';
                    }
                }
                listHTML += '</ul>';
            }
            $("#chat-list-tab1").html(listHTML);
        } else if (data.status == 0) {

            //$("#chat-list-tab1").html(listHTML);
        }
    });
}
tabActive(".chat-list-tab1", "click", function () {

    relationType(0);
    $(".chat-list-tab1").siblings().removeClass("chat-list-tab-active");
    $(".chat-list-tab1").addClass("chat-list-tab-active")
});
tabActive(".chat-list-tab2", "click", function () {
    relationType(3);
    //
    //$(".chat-list-tab2").siblings().removeClass("chat-list-tab-active");
    //$(".chat-list-tab2").addClass("chat-list-tab-active")
});
tabActive(".chat-list-tab3", "click", function () {
    relationType(5);
    $(".chat-list-tab3").siblings().removeClass("chat-list-tab-active");
    $(".chat-list-tab3").addClass("chat-list-tab-active")

});

relationType(0);