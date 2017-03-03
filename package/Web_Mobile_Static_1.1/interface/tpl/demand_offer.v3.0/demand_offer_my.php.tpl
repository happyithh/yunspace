<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v3.0/demand_tender_my.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>

    <link rel="stylesheet" href="plugins/fullcalendar/fullcalendar.css"/>
    {static "index.v2.0/data-picker.css"}

    {*<script type="text/javascript" src="plugins/moment/moment.min.js"></script>*}
    <script type="text/javascript" src="plugins/fullcalendar/fullcalendar.js"></script>
</head>
<body>
<!--我的活动需求-->

<div class="dmd-tend-my">


    <table >
        <tr>
            <td width="30%">您的称呼</td>
            <td width="69%"><input name="name_c" class="td-txt" value="{$data['demand']['联系人']}"/></td>
        </tr>
        <tr>
            <td>手机号码</td>
            <td><input name="phone_c" class="td-txt" type="number" value="{$data['demand']['联系电话']}"/></td>
        </tr>
        <tr>
            <td>活动城市</td>
            <td>
                <select name="city" class="td-txt">
                    {foreach $_REQUEST['cities'] as $val}
                        <option {if $val==$data['city']} selected{/if}>{$val}</option>
                    {/foreach}
                </select></td>
        </tr>
        <tr>
            <td>活动人数</td>
            <td>
                <select class="td-slt td-txt" name="people">
                    {foreach $option['people'] as $key =>$val}
                        <option {if $data['demand']['活动人数']==$val}selected{/if}>{$val}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>活动类型</td>
            <td><select class="td-slt td-txt" name="activity_type">
                    {foreach $option['活动类型'] as $val}
                        <option>{$val}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>预算范围</td>

            <td>
                <div class="d-s-input">
                    <input class="td-txt fl" type="number" value="{$data['price_up']}" name="price_up">

                    <div style="width:10%;float:left;line-height:30px;text-align:center">至</div>

                    <input class="td-txt fr" style="width:45%;float:left" type="number" value="{$data['price_down']}"
                           name="price_down">
                </div>
            </td>
        </tr>
        <tr>
            <td style="float: left;padding-top: 10px;">活动日期</td>
            <td>
                <div class="d-s-input">
                    <input type="text" id="datepicker" readonly name="act_date_start"
                           class="datePicker act_date_start td-txt fl"
                           placeholder="开始日期" style="width:45%;float:left" value="{$data['demand']['开始时间']}"/>

                    <div style="width:10%;float:left;line-height:30px;text-align:center">至</div>
                    <input type="text" id="datepicker" readonly name="act_date_end"
                           class="datePicker act_date_end td-txt fr"
                           placeholder="结束日期" style="width:45%;float:left" value="{$data['demand']['结束时间']}"/>

                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">
            <div style="line-height: 30px;font-size: 13px;color:#aaabae;clear: both">请在下方选择日期</div>

                <div yun="data-picker/js/date-picker.js::initPlugin" class=" date-picker" yun-input=".datePicker"
                     style="top:60px;width:261px;min-width: 100%"
                     yun-with-input="false"></div>
                <div class="clear"></div></td>
        </tr>
        <tr>
            <td>活动标签</td>
            <td class="td-mark">
                {foreach $data['tags'] as $key=>$val}
                    <p>{$val}<span class="icon-close-d" data-value="{$key}"></span></p>
                {/foreach}
            </td>
        </tr>
    </table>
</div>

<button class="dmd-my-submit" onclick="operation.MyEditSubmit(this)" demand-id="{$data['demand_id']}"
        offer-id="{$data['id']}">确定
</button>
</body>
{static "core/yunspace.js"}
{static 'demand_offer.v3.0/demand_offer_operation.js'}
{static "demand_offer.v3.0/pop.js"}

</html>