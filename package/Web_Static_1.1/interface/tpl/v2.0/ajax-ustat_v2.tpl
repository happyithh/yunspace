{if $__user}
    <link rel="stylesheet" href="{$_root}yun/plugins/tabChange/css/tabChange.css"/>
    <link rel="stylesheet" href="{$_root}yun/plugins/chatBar/css/chat_bar.css"/>
    <link rel="stylesheet" href="{$_root}yun/plugins/chatBar/css/ionicons.min.css"/>
    <div id="user_stat" data-username="{$__user['username']}" data-fullname="{$__user['fullname']}" data-phone="{$__user['phone']}">
        <ul class="log" data-username="{$__user['username']}" data-fullname="{$__user['fullname']}"
            data-phone="{$__user['phone']}">
            <li>
                <a href="{$_root}user_center/" title="{$__user['username']}">{mb_substr($__user['username'],0,5,'utf-8')}</a>|
            </li>
            <li>
                <a href="javascript:;" onclick="yun('chatBar/index.js::open', '.chat-bar');">消息({$message_num})
                    <i class="fa fa-caret-down"></i></a>
            </li>
            <div class="clear"></div>
        </ul>
        <ul class="log-operate" id="log_li">
            <li>
                <a href="{$_root}user_center/user_admin/order">采购管理</a>
            </li>
            {if $__user['vendor_id']}
                <li>
                    <a href="{$_root}vendor_center/vendor_admin/order">商户管理</a>
                </li>
            {/if}
            {if !$__user['sub_account']}
                <li>
                    <a href="{$_root}user_center/user_admin/account">账户管理</a>
                </li>
            {/if}
            <li>
                <a href="{$_root}user_center/user_admin/logout">退出</a>
            </li>
        </ul>
    </div>
    <script>
        $(".order_and_collect").show();
        $('#user_stat').hover(function () {
            $('#log_li').slideDown('fast');
        }, function () {
            $('#log_li').hide();
        });
    </script>
    <div class="chat-bar">
        <div class="chat-bar-con">
            <div class="chat-bar-body relative">
                <div class="tab-change" style="height:570px">
                    <div class="close-bar " onclick="yun('chatBar/index.js::close', '.chat-bar');">关闭</div>
                    <div>
                        <div class="tab-cont">
                            <div class="tab cle tab-active">
                                <iframe src="javascript:;" scrolling="yes" frameborder="0"></iframe>
                            </div>
                            <div class="tab cle">
                                <iframe src="javascript:;" scrolling="yes" frameborder="0"></iframe>
                            </div>
                            <div class="tab cle">
                                <iframe src="javascript:;" scrolling="yes" frameborder="0"></iframe>
                            </div>
                            <div class="tab cle">
                                <iframe src="javascript:;" scrolling="yes" frameborder="0"></iframe>
                            </div>
                        </div>
                        <ul class="tab-nav cle relative">
                            <li class="col-4 fl">
                                <a href="javascript:;" title="信息" class="nav-click nav-active" data-id="1" data-src="{$_root}m/chat/chat_recent"><span class="ion-chatbox-working tab-icon"></span></a>
                            </li>
                            <li class="col-4 fl">
                                <a href="javascript:;" title="联系人" class="nav-click" data-id="2" data-src="{$_root}m/chat/chat_contacts"><span class="ion-person-stalker tab-icon"></span></a>
                            </li>
                            <li class="col-4 fl">
                                <a href="javascript:;" title="活动需求" class="nav-click" data-id="3" data-src="{$_root}m/chat/chat_demand"><span class="ion-ios-paper tab-icon"></span></a>
                            </li>
                            <li class="col-4 fl">
                                <a href="javascript:;" title="收藏" class="nav-click" data-id="4" data-src="{$_root}m/chat/chat_collect"><span class="ion-heart tab-icon"></span></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="read">
                <div class="code-img">
                    关注云·Space服务号，第一时间掌握您的活动需求动态。
                    <img src="{$_root}package/Web_Static_1.1/interface/assets/img/home.v2.0/weixin2.jpg" alt="云·Space服务号"/>
                </div>
            </div>
        </div>
    </div>
    <div class="chat-bar-open" onclick="yun('chatBar/index.js::open', '.chat-bar');">
        <div class="relative">
            {if $message_num}
                <p class="absolute yet-read" style="margin:0px;">
                    {$message_num}
                </p>
            {/if}
        </div>
        <span class="ion-chatbox-working"></span>
    </div>
{else}
    <ul class="log">
        <li>
            <a href="{$_root}user_center/login" class="login">登录</a>|
        </li>
        <li>
            <a href="{$_root}user_center/register" class="register">注册</a>
        </li>
        <div class="clear"></div>
    </ul>
{/if}


