<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::chat.v1.0/inc.chat_head.tpl"}

    <link rel="stylesheet" href="plugins/zebra-datepicker/css/metallic.css" type="text/css">
</head>
<body>
{include "Web_Mobile_Static::chat.v1.0/inc.chat_demand_info_head.tpl"}

<div class="demand-info-tab">
    <div class="chat-demand-info-header" style="margin-top:88px">
        <p class="chat-demand-title">{$data['demand_name']}</p>
{if $data['response_account_id']==$data['account_id']}
        <a href="javascript:;"
           yun="chatBar/chat_demand_delete.js::demandDeleteDemo@click"
           yun-demand-id="{$_REQUEST['demand_id']}">
          删除</a>
        {else}
    <p class="chat-demand-header-icon js-more-make-click" style="margin-right:25px;right:0px;top:0px;"
       onclick="myDemandDelete(this)" data-id="{$_REQUEST['demand_id']}">删除</p>
        {/if}
    </div>

    {*需求表格*}
    <div class="demand-form">
        <input type="hidden" name="submit" value="1">
        <input type="hidden" name="demand_id" value="{$_REQUEST['demand_id']}">

        <div class="demand-input">
            <div class="demand-name">活动名称</div>
            <input type="text" name='activity_name' placeholder="请填写活动名称" value="{$data['demand']['活动名称']}">
        </div>
        <div class="demand-input">
            <div class="demand-name">活动人数</div>
            <select name=activity_people>
                {foreach $option['people'] as $k=>$val}
                    <option value="{$val}"  {if $data['demand']['活动人数']==$val} selected {/if}>{$val}</option>
                {/foreach}
            </select>
        </div>
        <div class="demand-input">
            <div class="demand-name">活动类型</div>
            <input type="text" name='activity_type' placeholder="请填写活动类型" value="{$data['demand']['活动类型']}">
        </div>
        <div class="demand-input">
            <div class="demand-name">开始时间</div>

            <input id="datepicker-example1" name="activity_time" type="text" value="{$data['demand']['开始时间']}">

        </div>
        <div class="demand-input">
            <div class="demand-name">活动预算</div>
            <select name="activity_budget">
                {foreach $option['budget'] as $k=>$val}
                    <option value="{$val}" {if $data['demand']['活动预算']==$val} selected {/if}>{$val}</option>
                {/foreach}
            </select>
        </div>
        <div class="demand-input">
            <div class="demand-name">具体要求</div>
            <textarea type="text" class="activity_demand" name="data[具体要求]"
                      placeholder="请填写活动需求">{if $data['demand']['具体要求']}
                    {$data['demand']['具体要求']} {else} {$data['demand']['咨询内容']} {/if}
            </textarea>
        </div>
        <div class="demand-submit demandsubmit">
            <button>立即提交</button>
        </div>
    </div>
</div>


{*删除*}
<div class="demand-take-look fixed  block">
    <p style="margin:0px;" class="search-recommend-title block ">
        删除理由</p>

    <div class="demand-take-look-time">
        <span>拒绝理由：</span>
        <select name="take-look-month">
            <option value="0">请选择理由</option>
            <option value="1">联系不到</option>
            <option value="2">恶意提交</option>
            <option value="3">客户手机输入错误</option>
            <option value="4">其他原因</option>
        </select>
    </div>
    <div style="padding-left: 40px;">
        <span style="float: left">备注：</span>
        <textarea placeholder="填写备注" class="take-look-remark"></textarea>
    </div>
    <div class="demand-submit">
        <button yun="chatBar/chat_demand_delete.js::demandDeleteDemoSubmit@click">提交</button>
    </div>
    <p class="block absolute close-reset js-close" yun="chatBar/chat_demand.js::closeRecommendModal@click"><span
                class="icon ion-close-round"></span></p>
</div>
{static "core/yunspace.js"}
<script type="text/javascript" src="plugins/zebra-datepicker/javascript/zebra_datepicker.src.js"></script>
<script>
    $(document).ready(function () {
        $('#datepicker-example1').Zebra_DatePicker({
            months:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
            days:["日","一","二","三","四","五","六"],
            default_position:"below",
            show_icon:false
        });
        $(".dp_today").html("今天");
        $(".dp_clear").html("清除").css({
            color:"#000"
        });
    })
    $(".demandsubmit").click(function () {
        YunSpace.api('demand/edit.jsonp', {
                    demand_id: $("input[name=demand_id]").val(),
                    demand: {
                        活动名称: $("input[name=activity_name]").val(),
                        活动人数: $("select[name=activity_people]").find("option:selected").val(),
                        开始时间: $("input[name=activity_time]").val(),
                        活动类型: $("input[name=activity_type]").val(),
                        活动预算: $("select[name=activity_budget]").find("option:selected").val(),
                        具体要求: $(".activity_demand").text()
                    }
                },
                function (data) {
                    if (data.status == 1) {
                        location.href = 'chat_demand_info?demand_id=' + $("input[name=demand_id]").val();
                    } else {
                        alert(data.msg);
                    }
                }
        )
        ;
    })
    //删除
    function myDemandDelete(e) {
        var demand_id = $(e).attr('data-id');
        YunSpace.api('demand/delete.jsonp', {
            demand_id: demand_id
        }, function (data) {
            if (data.status == 1) {
                location.href = 'chat_demand';
            } else {
                alert(data.msg);
            }
        });
    }

</script>
</body>
</html>