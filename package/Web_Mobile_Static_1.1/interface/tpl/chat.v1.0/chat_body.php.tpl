<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body style="background: #fafafa;padding-bottom: 60px;">
<div class="top" style="background:#eee">
    <div class="top_left">
        {if $rel_id == 2}
        <a href="chat_recent">
            <i class="ion-ios-arrow-back"></i>
        </a>
        {else}
            <a href="chat_contacts">
                <i class="ion-ios-arrow-back"></i>
            </a>
        {/if}
    </div>
    <div class="top-title">{$to_account['to_account_name']}</div>
</div>
{**如果有需求的 才显示button*}
{if $to_account['demand_id']}
    <div class="demand-tab-change">
        <ul class="demand-tab-change-list">
            <li><span>
                <p class="demand-tab-change-list-click {if Core::$urls['action']=='chat_body'}demand-tab-change-list-click-active{/if}">
                    <span class="ion-android-textsms"></span>
                </p></span>
            </li>
            <li>
                <a href="{$root}chat_demand_info?demand_id={$to_account['demand_id']}">
                    <p class="demand-tab-change-list-click">
                        <span class="ion-ios-paper"></span>
                    </p>
                </a>
            </li>
            <li>
                <a href="{$root}chat_demand_recommend?demand_id={$to_account['demand_id']}">
                    <p class="demand-tab-change-list-click">
                        <span class="ion-android-calendar"></span>
                    </p>
                </a>
            </li>
        </ul>
    </div>
{/if}
<div class="hidden" id="message_tpl">
    {*接收信息*}
    <div class="receive relative receive-normal">
        <div class="avatar absolute">
            <img>
        </div>
        <div class="message-body-l relative">
            <div class="Triangle-1 fl absolute"></div>
            <div class="fl received-message">
                &nbsp;
            </div>
            <div class="clear"></div>
        </div>
    </div>
    {*接收连接*}
    <div class="receive relative receive-media">
        <div class="avatar absolute">
            <img/>
        </div>
        <div class="message-body-l relative">
            <div class="Triangle-1 fl absolute"></div>
            <div class=" received-message">
                <a href="" class="share-link" target="_blank">
                    <div class="share-title">
                        &nbsp;
                    </div>
                    <div class="share-img">
                        <img/>
                    </div>
                    <div class="share-des">
                        &nbsp;
                    </div>
                    <div class="clear"></div>
                </a>
            </div>
            <div class="clear"></div>
        </div>
    </div>

    {*发送信息*}
    <div class="send relative send-normal">
        <div class="avatar absolute">
            <img/>
        </div>
        <div class="message-body-r relative ">
            <div class="Triangle-2 fr absolute"></div>
            <div class="fr received-message">
                &nbsp;
            </div>
            <div class="clear"></div>
        </div>
    </div>

    {*发送连接*}
    <div class="send relative send-media">
        <div class="avatar absolute">
            <img/>
        </div>
        <div class="message-body-r relative">
            <div class="Triangle-2 fl absolute"></div>
            <div class="sended-message">
                <a href="" class="share-link" target="_blank">
                    <div class="share-title">
                        &nbsp; &nbsp;
                    </div>
                    <div class="share-img">
                        <img/>
                    </div>
                    <div class="share-des">
                        &nbsp; &nbsp;
                    </div>
                    <div class="clear"></div>
                </a>
            </div>
            <div class="clear"></div>
        </div>
    </div>
</div>
<div class="cover fixed"></div>
<div class="message-content js-message-content relative" id="message_list"
     style="background: #fafafa; padding-top: 42px;">
    {if $data&&count($data)>=10}
        <div yun="livechat/index.js::loadMore@click"
             style="height: 35;line-height: 35px; text-align: center;font-size: 14px;margin: 10px;background: #eee;cursor: pointer;">
            加载更多
        </div>
    {/if}
    {if $data}
        {foreach $data as $key=>$val}

            {*判断发送这是否为自己*}
            {if !$val['is_sender']}

                {*接收信息*}
                {if $val['message']}
                    <div class="receive relative" id="message_ii{$val['id']}" data-time="{$val['create_time']}">
                        <div class="avatar absolute">
                            <img src="{$_root}user_center/avatar/{$val['from_account_id']}.jpg" alt="头像">
                        </div>
                        <div class="message-body-l relative">
                            <div class="Triangle-1 fl absolute"></div>
                            <div class="fl received-message">
                                {$val['message']}
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                {/if}
                {*接收链接*}
                {if $val['media']!=''}
                    <div class="receive relative" id="message_ii{$val['id']}" data-time="{$val['create_time']}">
                        <div class="avatar absolute">
                            <img src="{$_root}user_center/avatar/{$val['from_account_id']}.jpg" alt="头像"/>
                        </div>
                        <div class="message-body-l relative">
                            <div class="Triangle-1 fl absolute"></div>
                            <div class=" received-message">
                                <a href="{$val['media']['url']}" class="share-link" target="_blank">
                                    <div class="share-title">
                                        {$val['media']['title']}
                                    </div>
                                    <div class="share-img">
                                        <img src="{$val['media']['pic']}"/>
                                    </div>
                                    <div class="share-des">
                                        {$val['media']['des']}
                                    </div>
                                    <div class="clear"></div>
                                </a>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                {/if}

            {else}

                {*发送者是自己 start*}

                {*发送信息*}
                {if $val['message']}
                    <div class="send relative" id="message_ii{$val['id']}" data-time="{$val['create_time']}">
                        <div class="avatar absolute">
                            <img src="{$_root}user_center/avatar/{$val['from_account_id']}.jpg"/>
                        </div>
                        <div class="message-body-r relative ">
                            <div class="Triangle-2 fr absolute"></div>
                            <div class="fr sended-message">
                                {$val['message']}
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                {/if}
                {*发送连接*}
                {if $val['media']}
                    <div class="send relative" id="message_ii{$val['id']}" data-time="{$val['create_time']}">
                        <div class="avatar absolute">
                            <img src="{$_root}user_center/avatar/{$val['from_account_id']}.jpg"/>
                        </div>
                        <div class="message-body-r relative">
                            <div class="Triangle-2 fl absolute"></div>
                            <div class="sended-message">
                                <a href="{$val['media']['url']}" class="share-link" target="_blank">
                                    <div class="share-title">
                                        {$val['media']['title']}
                                    </div>
                                    <div class="share-img">
                                        <img src="{$val['media']['pic']}" alt="logo"/>
                                    </div>
                                    <div class="share-des">
                                        {$val['media']['des']}
                                    </div>
                                    <div class="clear"></div>
                                </a>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                {/if}
                {*发送者是自己 end*}
            {/if}

        {/foreach}
    {/if}
</div>
<a name="to_bottom"></a>

<div class="footer-block fixed"
     yun="livechat/index.js::init" yun-target="#message_list" yun-tpl="#message_tpl" yun-send="#send"
     yun-from_account_id="{$__user['id']}" yun-send_input="#send-message-content" yun-recommend=".recommend-submit"
     yun-time_after="{$val['create_time']}" yun-avatar_pre="{$_root}user_center/avatar/"
     yun-to_account_id="{$_REQUEST['to_account_id']}" yun-demand_id="{$to_account['demand_id']}">
    <a href="javascript:;" class="send-phone js-message-more" yun="livechat/recommend.js::showRecommend@click">
        <p class="message-icon">
            <span class="ion-plus-circled js-message-icon"></span>
        </p>
    </a>
    <a href="javascript:;" class="write-message send_message" id="send">
        <p class="message-icon">
            发送</p>
    </a>

    <div class="send-input">
        <input type="text" class="message_content" id="send-message-content"/>
    </div>

</div>

<div class="message-body-more fixed js-message-body-more">
    <div class="message-body-more-list relative">
        <ul class="message-body-more-list-li ">
            <li>
                <a href="javascript:;" class="message-more-choose block js-recommend"
                   yun="livechat/recommend.js::showSearch@click" yun-id="set">推荐套餐</a>
            </li>
            <li>
                <a href="javascript:;" class="message-more-choose block js-recommend "
                   yun="livechat/recommend.js::showSearch@click" yun-id="space">推荐场地</a>
            </li>
            <li>
                <a href="javascript:;" class="message-more-choose block js-recommend"
                   yun="livechat/recommend.js::showSearch@click" yun-id="service">推荐配套服务</a>
            </li>
            <li>
                <div class="clear"></div>
            </li>
        </ul>
        <div class="Triangle-3 absolute"></div>
    </div>
</div>

<div class="recommend-search fixed js-recommend-search">
    <p style="margin:0px;" class="search-recommend-title block js-search-recommend-title ">
        请搜索推荐服务</p>

    <div class="search-recommend ">
        <input type="text" class="search-input js-search-input"  placeholder="请输入ID号" />
    </div>
    <ul class="search-result js-search-result">
        <li class="hidden"><p class="result-title">-</p>

            <p class="recommend-submit" data-pic="" data-title="" data-des="" data-url="">
                推荐</p>

            <div class="clear"></div>
        </li>
    </ul>
    <p class="block absolute close-reset js-close">
        <span class="icon ion-close-round"></span></p>
</div>
{static "core/yunspace.js"}
</body>
</html>