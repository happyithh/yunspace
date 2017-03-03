<div class="top" style="background:#f5f5f5;z-index:15000">
    <div class="top_left">
        <a href="javascript:;" onclick="window.history.go(-1)"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">{$title}</div>
</div>
<div class="cover fixed" yun="chatBar/chat_demand.js::closeRecommendModal@click"></div>
{*消息页面*}
{*<div class="chat-demand-message-info  none demand-tab">*}
{*<iframe src="{$_home}chat/chat_body" id="demand_group_chat_body" width="100%" height="505" scrolling="no"*}
{*frameborder="0"></iframe>*}
{*</div>*}

<div class="demand-tab-change">
    <ul class="demand-tab-change-list">
        <li><span onclick="demand_group(this)" demand_id="{$_REQUEST['demand_id']}">
                <p class="demand-tab-change-list-click">
                    <span class="ion-android-textsms"></span>
                </p></span>
        </li>
        <li>
            <a href="{$root}chat_demand_info?demand_id={$_REQUEST['demand_id']}">
                <p class="demand-tab-change-list-click {if Core::$urls['action']=='chat_demand_info'||Core::$urls['action']=='chat_demand_edit'}demand-tab-change-list-click-active{/if}">
                    <span class="ion-ios-paper"></span></p>
            </a>
        </li>
        <li>
            <a href="{$root}chat_demand_recommend?demand_id={$_REQUEST['demand_id']}">
                <p class="demand-tab-change-list-click {if Core::$urls['action']=='chat_demand_recommend'|| Core::$urls['action']=='chat_demand_remark'}demand-tab-change-list-click-active{/if}">
                    <span class="ion-android-calendar"></span>
                </p>
            </a>
        </li>
    </ul>
</div>
<script>
    function demand_group(e) {
        var demand_id = $(e).attr('demand_id');
        $.ajax({
            type: 'get',
            url: '{$root}chat_demand_group?demand_id=' + demand_id,
            success: function (data) {
                if (data.status == 1) {
                    window.location.href = data.data;
//                    $('#demand_group_chat_body').attr('src', data.data);
//                    $(".chat-demand-message-info").show();
                } else {
                    alert(data.msg);
                }
            }
        })
    }
</script>