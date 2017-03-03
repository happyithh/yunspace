<!--报价需求列表-->
{if $isCustomer}
    <div class="quote-title clearfix">
        {if $demand_offer['status'] <0}
            <p class="fl state" style="color: #999">报价已结束</p>
        {else}
            <p class="fl state">询价中</p>
            <a class="fr end-quote js-endquote" href="JavaScript:;">结束报价</a>
        {/if}
    </div>
{/if}
<div class="quote-needs-list bd-tpbm quote-p clearfix js-data-offer" data-demand-id="{$demand_offer['demand_id']}"
     data-result-id="{$result_id}" data-offer-id="{$demand_offer['id']}">
    <div class="demand-tit clearfix">
        <p class="fl time">提交时间：{$demand_offer['create_time']}</p>

        <p class="fr code">NO.{$demand_offer['demand_id']}</p>
    </div>

    {if $isCustomer && !$demand_offer['isThirty']}
        {if $demand_offer['status'] >=0}
            <a href="{$_root}m/demand_offer.v2/customer?action=demand_edit&demand_id={$demand_offer['demand_id']}"
               class="edit hide" target="_blank"><span>

                    </span>编辑</a>
        {/if}
    {/if}

    <p><span class="tit">活动人数：</span><span class="ct">{$demand_offer['demand']['活动人数']}</span></p>

    <p><span class="tit">活动档期：</span><span
                class="ct">{if $demand_offer['day'] > 0}({$demand_offer['day']})天 ,{/if}{$demand_offer['demand']['开始时间']}
            &nbsp;-&nbsp;{$demand_offer['demand']['结束时间']}</span></p>

    <p><span class="tit">活动预算：</span><span class="ct">
            {if $demand_offer['price_up']>100}
                ￥{$demand_offer['price_up']}
                -￥{$demand_offer['price_down']}
            {else}
                面议
            {/if}
    </span></p>

    <div class="list-hide hide">
        <p><span class="tit">活动城市：</span><span
                    class="ct">{if $demand_offer['demand']['活动城市']}{$demand_offer['demand']['活动城市']}{else}{$demand_offer['demand']['城市']}{/if}</span>
        </p>

        <p><span class="tit">活动类型：</span><span class="ct">{$demand_offer['demand']['活动类型']}</span></p>

        <p><span class="tit">活动标签：</span>
            <span class="ct">
                 {foreach $demand_offer['tags'] as $k=>$val}
                     <span class="bq">{$val}</span>
                 {/foreach}
            </span>
        </p>

        <p><span class="tit">具体要求：</span><span
                    class="ct">  {if $demand_offer['demand']['具体要求']}{$demand_offer['demand']['具体要求']}{else}暂无{/if}</span>
        </p>
    </div>
    <div class="slide-onoff js-slide-onoff">展开</div>
</div>

<!--报价数量-->
{if !$demand_offer['isThirty'] || !$isCustomer}
    <div class="quote-numbs">
        <p>
            <img src="img/demand_tender.v1.0/icon_quote_numbs.png">
            <span>{$sum}个场地已报价</span>
        </p>
    </div>
{/if}

<script>
    localStorage.clear();
</script>
