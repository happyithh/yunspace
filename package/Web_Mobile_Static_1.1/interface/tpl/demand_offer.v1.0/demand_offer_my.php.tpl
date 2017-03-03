<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/demand_off.v1.0/demand_tender_my.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
</head>
<body>
<!--我的活动需求-->
<div class="dmd-tend-my">
    <table>
        <tr>
            <td width="28%">您的称呼</td>
            <td width="72%">{$data['demand']['联系人']}</td>
        </tr>
        <tr>
            <td>手机号码</td>
            <td>{$data['nick_phone']}</td>
        </tr>
        <tr>
            <td>活动城市</td>
            <td>{$data['demand']['活动城市']}</td>
        </tr>
        <tr>
            <td>活动人数</td>
            <td>
                <select class="td-slt" name="people">
                    {foreach $option['people'] as $key =>$val}
                        <option {if $data['demand']['活动人数']==$val}selected{/if}>{$val}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>活动类型</td>
            <td><select class="td-slt" name="activity_type">
                    {foreach $option['活动类型'] as $val}
                        <option>{$val}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr>
            <td>预算范围</td>
            <td><input class="td-txt fl" type="number" value="{$data['price_up']}" name="price_up">
                <span class="span-txt">至</span>
                <input class="td-txt fr" type="number" value="{$data['price_down']}" name="price_down">
            </td>
        </tr>
        <tr>
            <td>活动日期</td>
            <td>
                <input class="td-txt fl" type="text" placeholder="2015/10/26" value="{$data['demand']['开始时间']}"
                       readonly>
                <span class="span-txt">至</span>
                <input class="td-txt fr" type="text" placeholder="2015/10/26" value="{$data['demand']['开始时间']}"
                       readonly>
            </td>
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
        offer-id="{$data['id']}">提交并等待报价
</button>
</body>
{static "core/yunspace.js"}
{static 'demand_offer.v1.0/demand_offer_operation.js'}
{static "demand_offer.v1.0/pop.js"}

</html>