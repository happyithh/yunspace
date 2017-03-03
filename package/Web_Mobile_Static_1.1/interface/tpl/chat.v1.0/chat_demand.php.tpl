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
    <div class="top-title">我的活动需求</div>
</div>
<div class="demand-change" style="margin-top: 44px;">

    <a href="?type=1">
        <p class="change-click change  {if $_REQUEST['type']==1 || !$_REQUEST['type']} change-click-active {/if}">
            处理中</p></a>
    <a href="?type=2">
        <p class="change-click change {if $_REQUEST['type']==2} change-click-active {/if}">
            已完成</p></a>

    <a href="?type=-1">
        <p class="demand-delete change {if $_REQUEST['type']=='-1'} change-click-active {/if}"><span
                    class="ion-trash-a"></span></p></a>
</div>
{*列表*}
{if $data}
    <div>
        <ul class="load-more">
            {include "Web_Mobile_Static::chat.v1.0/inc/inc.chat_demand.php.tpl"}
        </ul>
    </div>
    {*加载更多按钮*}
    {if $total > 1}
        <div class="show-more-record">
            <p class="morerecord"><em>点击加载更多</em>&nbsp;<span
                        class="ion-ios-refresh-outline"></span></p>
        </div>
    {/if}
{/if}
{if $_REQUEST['type']==1 && !$data}
    {*默认状态下显示*}
    <div class="chat-collect-prompt" style="margin: 0">
        <div class="chat-collect-prompt-title">
            <p><span class="ion-document-text"></span>&nbsp;&nbsp;您还提交过活动需求，快去<a href="{$_home}requirement"
                                                                                 class="collect-link">提交</a>吧
            </p>
        </div>
        <div class="chat-collect-prompt-content">
            <h4>什么是活动需求?</h4>

            <p>活动需求是指您对将要举办活动的一个想法、要求以及云SPACE的服务</p>
            <h4>如何提交活动需求?</h4>

            <p>1、云SPACE网站上找“我要办活动板块”；</p>

            <p>
                2、拨打云SPACE服务热线<a href="tel:400-056-0599" class="collect-link">400-056-0599</a>；
            </p>

            <p>3、在商品详情页内右上角找到“预约咨询”。</p>
        </div>
    </div>
{/if}
{if   $_REQUEST['type'] !=1 && !$data}
    <ul>
        <li style="line-height:50px;text-align: center;color: #666;font-size: 12px;">
            暂无数据
        </li>
    </ul>
{/if}
</body>
{static "core/yunspace.js"}
<script>
    $('.morerecord').click(function () {
        var last_id = $(".load-more li").last().find('input').val();
        $.ajax({
            type: 'get',
            url: '?load_more=1',
            data: {
                last_id: last_id
            },
            success: function (data) {
               
                if (data.length > 0) {
                    $(data).appendTo(".load-more");
                } else {
                    $(this).hide();
                }
            }
        });
    });
</script>
</html>