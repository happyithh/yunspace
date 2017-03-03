{if $data}
    <!--正在等待商家报价-->
    {foreach $data as $key =>$val}
        <div class="wait-inq">
            <div class="wait-inq-tit clearfix">

                <p>No.{$val['demand_id']}</p>
                <span class="time">{$val['create_time']}</span>

                <h2 class="orange">{if $val['status'] < 0}已关闭{elseif $val['num'] > 0 || !$val['isThirty']}
                        <span style="color: rgb(102, 102, 102);font-weight: normal">已收到<i
                                    style="color: rgb(254, 106, 58);font-style: normal">{$val['sum']}</i>份场地报价</span>
                    {else}等待商家报价{/if}</h2>
            </div>
            <a class="wait-inq-cont clearfix" href="?action=detail&demand_id={$val['demand_id']}" target="_blank">
                <div class="act-list">
                    <p>活动城市：{if $val['demand']['活动城市']} {$val['demand']['活动城市']}{else}{$val['demand']['城市']}{/if}</p>

                    <p>活动类型：{$val['demand']['活动类型']}</p>

                    <p>活动人数：{$val['demand']['活动人数']}</p>
                </div>
                <p>查看报价 &gt;</p>
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