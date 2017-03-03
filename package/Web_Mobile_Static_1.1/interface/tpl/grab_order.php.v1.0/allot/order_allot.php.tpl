<!DOCTYPE html>
<html>
<head lang="en">
    <title>需求单分配</title>
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
    {static "core/yunspace.js"}
</head>
<body>
<div class="wrapper padding-bottom-68" id="allot">
    {if $list}
        {foreach $list as $val}
            <div class="grab-comn clearfix">
                <div class="grab-comn-title clearfix">
                    <div class="co-t clearfix">
                        <p class="fl" style="color: rgb(16, 115, 214)">等待分配</p>

                        {*<div style="overflow: auto; width: 100px; float: left;  margin-top: 4px; margin-left: 20%;"><i*}
                        {*class="icon_time"></i>*}
                        {*<span id="time{$val['id']}" data-time="{$val['end_allot_time']}"></span>*}
                        {*</div>*}
                        <p class="fr ">
                            <select style="border-radius:3px;padding: 1px;" onchange="operation.allotOrderSubmit(this)"
                                    data-value="{$val['id']}">
                                <option>请分配</option>
                                <option value="-9">报价系统</option>
                                {foreach $sale_people as $v}
                                    <option value="{$v['phone']}">{$v['fullname']}</option>
                                {/foreach}
                            </select>
                        </p>
                    </div>
                    <div class="co-b clearfix">
                        <p class="fl">NO.{$val['id']}</p>

                        <div class="fr progress"></div>
                    </div>
                </div>
                <a href="javascript:void(0)" class="grab-comn-cont clearfix">
                    <div class="fl text clearfix">
                        <p>创建时间：{Date("Y-m-d H:i ",$val['create_time'])}</p>

                        <p>活动人数：{$val['demand']['活动人数']}</p>

                        <p>活动档期：{$val['schedule']}</p>

                        <p>活动预算：{$val['price']}</p>
                    </div>
                </a>
            </div>
        {/foreach}
    {/if}
    <!--刷新按钮-->
    <div class="reload" style="display: block" onclick="window.location.reload()"></div>
    <!--回到顶部按钮-->
    <div class="upward js-upward js-upward-btn"></div>


</div>
<!--wrapper-end-->
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "grab_order.v1.0/grab.js"}
{static "grab_order.v1.0/operation.js"}
<script>
    $(function () {

        $("#allot span").each(function () {
            var _id = $(this).attr('id');
            var _endTime = $(this).attr('data-time');
            addTimer(_id, _endTime);
        });
    })
</script>
</body>
</html>