{if $data}
    <!--正在等待商家报价-->
    {foreach $data as $key =>$val}
        <div class="wait-inq">
            <div class="wait-inq-tit clearfix">
                <h2 class="h-100"> {if $val['status'] < 0}已关闭{elseif $val['num'] > 0 || !$val['isThirty']}
                        <span>已收到{$val['sum']}份场地报价</span>
                    {else}等待商家报价{/if}</h2>

                <div class="nmtm clearfix">
                    <span class="fl numbs">NO.{$val['demand_id']}</span>
                    <span class="fr time">{$val['create_time']}</span>
                </div>
            </div>
            <a class="wait-inq-cont clearfix" href="?action=detail&demand_id={$val['demand_id']}" target="_blank">
                <div class="act-list">
                    <p>活动人数：{$val['demand']['活动人数']}</p>

                    <p>活动档期：{if $val['day'] > 0}({$val['day']})天 ,{/if}{$val['demand']['开始时间']}
                        &nbsp;-&nbsp;{$val['demand']['结束时间']}</p>

                    <p>活动预算：{if $val['price_up']>100}
                        ￥{$val['price_up']}
                        -￥{$val['price_down']}
                        {else}
                        面议
                        {/if}</p>
                </div>
                <p>查看详情 &gt;</p>
            </a>
        </div>
    {/foreach}
{else}
    <div class="wait-inq">
        <div class="wait-inq-tit clearfix" style="text-align: center">
            抱歉~没有记录
        </div>
    </div>
{/if}