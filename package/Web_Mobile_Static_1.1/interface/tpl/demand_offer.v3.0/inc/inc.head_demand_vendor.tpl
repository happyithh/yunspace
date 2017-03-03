<div class="quote-title clearfix">

    {if $data['change_phone_time']}
        <p class="fl state">客户有意向</p>
        {*<a class="fr phone" href="tel:{$demand_offer['demand']['联系电话']}"><img*}
        {*src="img/demand_tender.v1.0/icon-phone-org.png"></a>*}
    {else}
        {if $demand_offer['status'] < 0}
            <p class="fl state" style="color: #999">报价已结束</p>
        {else}
            {if $data['offer_time'] }
                <p class="fl state">已报价，待确认意向</p>
            {else}
                <p class="fl state"><i class="fl icon-c icon-xjz"></i><span class="fl">等待报价（咨询）</span></p>
            {/if}
        {/if}
    {/if}

</div>
<div class="quote-needs-list bd-tpbm quote-p clearfix js-data-offer" data-demand-id="{$demand_offer['demand_id']}"
     data-result-id="{$result_id}" data-offer-id="{$demand_offer['id']}">
    <div class="demand-tit clearfix">

        <div class="numb-phone clearfix">
            {if $data['change_phone_time']}
                <h2 class="fl">{$demand_offer['demand']['联系人']},&nbsp; {$demand_offer['demand']['联系电话']}</h2>
                <a style="cursor: pointer" onclick="operation.callPhone(this)" data-type="vendor" data-phone="{$demand_offer['demand']['联系电话']}" class="fr contact js-phone">联系他</a>
            {else}
                <h2>{$demand_offer['nick_username']},{$demand_offer['nick_phone']}</h2>
            {/if}
        </div>
        <p class="fl time">提交时间：{$demand_offer['create_time']}</p>

        <p class="fr code">NO.{$demand_offer['demand_id']}</p>
    </div>
    <p><span class="tit">活动档期：</span><span
                class="ct">{if $demand_offer['day'] > 0}({$demand_offer['day']})天 ,{/if}{$demand_offer['demand']['开始时间']}
            &nbsp;-&nbsp;{$demand_offer['demand']['结束时间']}</span></p>
    <p><span class="tit">具体要求：</span><span
                    class="ct">  {if $demand_offer['demand']['具体要求']}{$demand_offer['demand']['具体要求']}{else}暂无{/if}</span></p>
    <p><span class="tit">咨询场地：</span><span class="ct">奢居会-8楼露台</span></p>
</div>

<script>
    localStorage.clear();
</script>
