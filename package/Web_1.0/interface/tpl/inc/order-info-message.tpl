<link rel="stylesheet" type="text/css" href="css/message.css">
<div class="s_left_c mt-1 conw_s">
    <div style="position: relative; overflow:hidden; width: auto; height: 435px;" class="slimScrollDiv">
        <div class="scroller" style=" overflow-y:scroll; width: auto; height: 435px;" data-always-visible="1" data-rail-visible1="1">
            <div class="load"><img src="img/loading.gif"></div>
            <ul class="chats clearfix" id="all_message">
                {*{foreach $message as $v}*}
                {*{if $v['from_account_id']==$session['user']['fullname']}*}
                {*<li class="in">*}
                {*<img class="avatar img-responsive" alt="" src="img/avatar.png">*}

                {*<div class="message">*}
                {*<span class="arrow"></span>*}
                {*<a href="index.html#" class="name">{$v['from_account_id']}</a>*}
                {*<span class="datetime">{date('Y-m-d H:i:s',$v['send_time'])} </span>*}
                {*<span class="body">{$v['message']} </span>*}
                {*</div>*}
                {*</li>*}
                {*{else}*}
                {*<li class="out">*}
                {*<img class="avatar img-responsive" alt="" src="img/avatar.png">*}

                {*<div class="message">*}
                {*<span class="arrow"></span>*}
                {*<a href="index.html#" class="name">{$v['order_id']}</a>*}
                {*<span class="datetime">{date('Y-m-d H:i:s',$v['send_time'])} </span>*}
                {*<span class="body">{$v['message']}</span>*}
                {*</div>*}
                {*</li>*}
                {*{/if}*}
                {*{/foreach}*}


            </ul>
        </div>
        <div class="mask">
            <div class="loading">
                {*<i class="fa fa-spinner fa-spin"></i>*}
                <img src="img/loading.gif" alt=""/>
            </div>
        </div>
        <div style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: none repeat scroll 0% 0% rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;" class="slimScrollRail">
        </div>
    </div>
    <div class="chat-form">
        <div class="input-cont">
            <input class="form-control" placeholder="Type a message here..." type="text" name="message" id="message">
        </div>
        <div class="btn-cont">
            <span class="arrow"></span>
            <a href="javascript:void(0)" id="send" class="btn btn-primary1 icn-only"><i class="fa fa-check"></i></a>
        </div>
    </div>
</div>
<script>
/*
 * 加载最新消息
 * */

var buyer_id = {$orderinfo['buyer_account_id']};
var messageInterval;
function loadMessage() {
//        var lastMsgId = 0;
//        if (is_old) {
//            lastMsgId = $('#all_message>li:eq(0)').data('id');
//        } else {
//            lastMsgId = $('#all_message>li:eq(-1)').data('id');
//        }
    var isFirstTime = true;

    if (isFirstTime) {
        loadMessageFirstTime();
        isFirstTime = false;
    } else {
        loadMessageNotFirstTime();
    }

}

function loadMessageFirstTime() {
    $.ajax({
        type: 'get',
        url: '{$_root}order_message/{$orderinfo['order_no']}?action=getMessage',
        success: function (data) {
            dealMessageList(data, 'prepend');
            $('.load').hide();
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            console.log(XMLHttpRequest.status);
            console.log(textStatus);
            console.log(errorThrown);
        },
        dataType: 'json'
    })
}


function loadMessageNotFirstTime() {
    var lastId = $('#all_message li').last().data('id');
    msIntervalFinish();//结束消息请求
    $.ajax({
        type: 'post',
        url: '{$_root}order_message/{$orderinfo['order_no']}?action=getMessageNotFirstTime',
        data: {
            lastId: lastId
        },
        success: function (data) {
            dealMessageList(data, 'append');
            msIntervalStart();//请求成功继续请求
//                 console.log(data);
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            msIntervalStart();//请求失败继续请求
            console.log(XMLHttpRequest.status);
            console.log(textStatus);
            console.log(errorThrown);
        },
        dataType: 'json'
    })

}
function dealMessageList(data, way) {
    for (i in data) {
//            console.log(data);
        if (data[i]['from_account_id'] == buyer_id) {
            var text = '<li class="out" data-id="' + data[i]['id'] + '">'
                    + '<img class="avatar img-responsive" src="{$_root}user_center/avatar/' + data[i]['from_account_id'] + '.jpg">'
                    + '<div class="message clearfix">'
                    + '<span class="arrow"></span>'
                    + '<a href="index.html#" class="name">' + data[i]['from_username'] + '</a>'
                    + '<span class="datetime">' + data[i]['send_time'] + '</span>'
                    + '<span class="body">' + data[i]['message'] + '</span>'
                    + '</div>'
                    + '</li>';
            if (way == 'prepend') {
                $('#all_message').prepend(text);
            } else {
                $('#all_message').append(text);
            }

        } else {
            var text = '<li class="in" data-id="' + data[i]['id'] + '">'
                    + '<img class="avatar img-responsive" src="{$_root}user_center/avatar/' + data[i]['from_account_id'] + '.jpg">'
                    + '<div class="message clearfix">'
                    + '<span class="arrow"></span>'
                    + '<a href="index.html#" class="name">' + data[i]['from_username'] + '</a>'
                    + '<span class="datetime">' + data[i]['send_time'] + '</span>'
                    + '<span class="body">' + data[i]['message'] + '</span>'
                    + '</div>'
                    + '</li>';
            if (way == 'prepend') {
                $('#all_message').prepend(text);
            } else {
                $('#all_message').append(text);
            }
        }
    }
    if (data.length >= 1) {
        scrollToBottom()
    }
}
function submitMessage() {
    var content = $("input[name='message']").val();
    if (!content) {
        alert('消息不能为空');
        return false;
    }
    $('.mask').show();
    sendBtnUnbindClick();
    $.ajax({
        type: 'post',
        url: '{$_root}order_message/{$orderinfo['order_no']}?action=postMessage',
        data: {
            message: content,
            from_name: '{$__user['username']}'
        },
        success: function (data) {
            if (data) {
//                    console.log(data);
                if (data['from_account_id'] == buyer_id) {
                    var text = '<li class="out" data-id="' + data['id'] + '">'
                            + '<img class="avatar img-responsive" src="{$_root}user_center/avatar/' + data['from_account_id'] + '.jpg">'
                            + '<div class="message clearfix">'
                            + '<span class="arrow"></span>'
                            + '<a href="index.html#" class="name">' + data['from_username'] + '</a>'
                            + '<span class="datetime">' + data['send_time'] + '</span>'
                            + '<span class="body">' + data['message'] + '</span>'
                            + '</div>'
                            + '</li>';
                    $('#all_message').append(text);
                } else {
                    var text = '<li class="in" data-id="' + data['id'] + '">'
                            + '<img class="avatar img-responsive" src="{$_root}user_center/avatar/' + data['from_account_id'] + '.jpg">'
                            + '<div class="message clearfix">'
                            + '<span class="arrow"></span>'
                            + '<a href="index.html#" class="name">' + data['from_username'] + '</a>'
                            + '<span class="datetime">' + data['send_time'] + '</span>'
                            + '<span class="body">' + data['message'] + '</span>'
                            + '</div>'
                            + '</li>';
                    $('#all_message').append(text);
                }
                scrollToBottom();
                $('#message').val("");
            }

            $('.mask').hide();
            sendBtnBindClick()
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            $('.mask').hide();
            sendBtnBindClick()
            console.log(XMLHttpRequest.status);
            console.log(textStatus);
            console.log(errorThrown);
        },
        dataType: 'json'

    })
}

function scrollToBottom() {
    $('.scroller').scrollTop(999999);
}

function msIntervalStart() {
    messageInterval = setInterval(function () {
        loadMessageNotFirstTime();
    }, 4000)
}

function msIntervalFinish() {
    clearInterval(messageInterval);
}

function sendBtnBindClick() {
    $('#send').bind('click', function () {
        submitMessage();
    })
    document.onkeydown = function () {
        if (13 == event.keyCode) {
            submitMessage();
        }
    }
}
function sendBtnUnbindClick() {
    $('#send').unbind('click');
    document.onkeydown = function () {

    }

}
$(document).ready(function () {
    loadMessage();
    msIntervalStart();
    sendBtnBindClick();

});


</script>