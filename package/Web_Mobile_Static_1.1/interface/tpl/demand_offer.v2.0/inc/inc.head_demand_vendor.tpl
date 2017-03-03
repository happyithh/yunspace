<div class="quote-needs-list bd-tpbm quote-p clearfix js-data-offer " data-demand-id="{$demand_offer['demand_id']}"
     data-result-id="{$result_id}" data-offer-id="{$demand_offer['id']}">
    <div class="demand-tit clearfix">

        <div class="numb-phone clearfix">
            {if $data['change_phone_time']}
                <h2 class="fl">{$demand_offer['demand']['联系人']},&nbsp; {$demand_offer['demand']['联系电话']}</h2>
                <a style="cursor: pointer" onclick="operation.callPhone(this)" data-type="vendor"
                   data-phone="{$demand_offer['demand']['联系电话']}" class="fr contact js-phone">联系他</a>
            {else}
                <h2>{$demand_offer['nick_username']},{$demand_offer['nick_phone']}</h2>
            {/if}
        </div>
        <p class="fl time">提交时间：{$demand_offer['create_time']}</p>

        <p class="fr code">NO.{$demand_offer['demand_id']}</p>
    </div>
    {if $demand_offer['demand']['活动人数']}
        <p><span class="tit">活动人数：</span><span class="ct">{$demand_offer['demand']['活动人数']}</span></p>
    {/if}
    {if $demand_offer['demand']['开始时间']}
        <p><span class="tit">活动档期：</span><span
                    class="ct">{if $demand_offer['day'] > 0}({$demand_offer['day']})天 ,{/if}{$demand_offer['demand']['开始时间']}
                &nbsp;-&nbsp;{$demand_offer['demand']['结束时间']}</span></p>
    {/if}
    {if $demand_offer['price_up'] || $demand_offer['price_down']}
        <p><span class="tit">活动预算：</span><span class="ct">
            {if $demand_offer['price_up']>100}
                ￥{$demand_offer['price_up']}
                -￥{$demand_offer['price_down']}
            {else}
                面议
            {/if}
    </span></p>
    {/if}
    <div class="list-hide ">
        {if $demand_offer['demand']['活动城市']}
            <p><span class="tit">活动城市：</span><span
                        class="ct">{if $demand_offer['demand']['活动城市']}{$demand_offer['demand']['活动城市']}{else}{$demand_offer['demand']['城市']}{/if}</span>
            </p>
        {/if}
        {if $demand_offer['demand']['活动类型']}
            <p><span class="tit">活动类型：</span><span class="ct">{$demand_offer['demand']['活动类型']}</span></p>
        {/if}
        {if $demand_offer['tags']}
            <p><span class="tit">活动标签：</span>
            <span class="ct">
                 {foreach $demand_offer['tags'] as $k=>$val}
                     <span class="bq">{$val}</span>
                 {/foreach}
            </span>
            </p>
        {/if}
        {if $demand_offer['demand']['具体要求']}
            <p><span class="tit">具体要求：</span><span
                        class="ct">  {if $demand_offer['demand']['具体要求']}{$demand_offer['demand']['具体要求']}{else}暂无{/if}</span>
            </p>
        {/if}
    </div>
    {*<div class="slide-onoff js-slide-onoff up">收起</div>*}
</div>
{if $demand_offer['status'] > -1}

    {if $data['vendor_close_time']==0 && $data['change_phone_time']!='-1'}
        <div class="quote-numbs">
            <p>
                <img src="img/demand_tender.v1.0/icon_quote_numbs.png">
                <span>{$sum}个场地已报价</span>
            </p>
        </div>
    {/if}
{/if}
<script>
    localStorage.clear();
</script>
