<link rel="stylesheet" href="{$_root}yun/plugins/tabChange/css/tabChange.css"/>
<link rel="stylesheet" href="{$_root}yun/plugins/chatBar/css/chat_bar.css"/>
<link rel="stylesheet" href="{$_root}yun/plugins/chatBar/css/ionicons.min.css"/>
<style>
.chat-bar  li{ list-style-type: none; float: left}
</style>
<div class="chat-bar">
    <div class="chat-bar-con">
        <div class="chat-bar-body relative">
            <div class="tab-change">
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