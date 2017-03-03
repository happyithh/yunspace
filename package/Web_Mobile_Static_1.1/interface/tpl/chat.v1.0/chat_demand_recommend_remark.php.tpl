<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}
</head>
<body>
{include "Web_Mobile_Static::chat.v1.0/inc.chat_demand_info_head.tpl"}
<div class="demand-info-tab">
    <div class="chat-demand-info-header" style="margin-top:88px">
    </div>

    <div class="demand-form">
        <div class="demand-input">
            <span class="demand-name">备注:</span>

            <div class="demand-recommend-look-remark" style="border: none;padding: 0px;word-wrap: break-word;">
                {foreach $data['clientele_remark'] as $k=>$val}
                    {$k}:{$val}
                    <br/>
                {/foreach}
            </div>
        </div>
    </div>
    <div id="addRemark" style="display: none">
        <div class="demand-form">
            <div style="text-align: center">
                <textarea type="text" placeholder="填写您的备注" style="height: 100px;width: 60%;"
                          class="demand_recommend_remark">
                    {$data['clientele_remark']['备注']}
                </textarea>
            </div>
        </div>
        <div class="demand-submit">
            <button yun="chatBar/chat_demand.js::demandRecommendRemarkSubmit@click"
                    yun-demand-id="{$_REQUEST['demand_id']}" yun-recommend-id="{$_REQUEST['recommend_id']}">提交
            </button>
        </div>
    </div>
    <div class="demand-submit">
        <button yun="chatBar/chat_demand.js::demandRecommendRemarkShow@click"
                yun-show="#addRemark">编辑备注
        </button>
    </div>

</div>
{static "core/yunspace.js"}
<script>

</script>
</body>
</html>