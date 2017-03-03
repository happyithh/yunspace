<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body>
<div class="top" style="background:#f5f5f5">
    <div class="top_left">
        <a href="javascript:;">
            {*<i class="ion-ios-arrow-back"></i>*}
        </a>
    </div>
    <div class="top-title">最新消息</div>
</div>
<ul class="chat-recent" style="padding-top: 42px;">
    {foreach $data['data'] as $v}
        <li class="recent-item relative">
            <a href="chat_body?to_account_id={$v['from_account_id']}&rel_id=2">
                <div class="recent-person absolute">
                    {if $v['total']}
                        <span class="recent-no-read">{$v['total']}</span>
                    {/if}
                    <img src="{$_root}user_center/avatar/{$v['from_account_id']}.jpg">
                </div>
                <div class="recent-body">
                    <p class="recent-name">{$v['from_name']|default:'-'}</p>

                    <p class="recent-message">{mb_substr($v['message'],0,100,'utf-8')}</p>
                </div>
                <div class="recent-code absolute">
                    <span class="recent-time">{if $v['update_time']>$today}{date('H:i', $v['update_time'])}{else}{date('m-d', $v['update_time'])}{/if}</span>
                </div>
            </a>
        </li>
    {/foreach}
</ul>
{static "core/yunspace.js"}
</body>
</html>