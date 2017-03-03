<div class="quote-needs-list bd-tpbm quote-p clearfix js-data-tender-id" data-tender-id="{$demand_tender['id']}">
    <div class="demand-tit">
        <h3>No.{Func_NumEncode::e($demand_tender['id'])}
            <br/>
            ({$demand_tender['nick_username']} ,手机号:{$demand_tender['nick_phone']})</h3>

        <p>提交时间：{$demand_tender['create_time']}</p>
    </div>
    <p><span class="tit">活动城市：</span><span class="ct">{$demand_tender['city']}</span></p>

    <p><span class="tit">活动类型：</span><span class="ct">{$demand_tender['demand']['活动类型']}</span></p>

    <p><span class="tit">活动档期：</span><span class="ct">({$demand_tender['day']})天 ,{$demand_tender['demand']['开始时间']}
            &nbsp;-&nbsp;{$demand_tender['demand']['结束时间']}</span></p>

    <p><span class="tit">活动人数：</span><span class="ct">{$demand_tender['demand']['活动人数']}</span></p>

    <p><span class="tit">活动预算：</span><span class="ct">
￥{$demand_tender['price_up']}
            -￥{$demand_tender['price_down']}
</span></p>

    <p><span class="tit">其他要求：</span><span class="ct">
{$demand_tender['demand']['具体要求']}
</span></p>
    <!--报价数量-->
    <div class="quote-numbs">
        <p>
            <img src="img/demand_tender.v1.0/icon_quote_numbs.png">
            {if $demand_tender['account_id']==$__user['id']}
                <span>您已经收到{$demand_tender['scheme_sum']}份场地报价</span>
            {else}
                <span>客户已经收到{$demand_tender['scheme_sum']}份场地报价</span>
            {/if}
        </p>
    </div>
</div>