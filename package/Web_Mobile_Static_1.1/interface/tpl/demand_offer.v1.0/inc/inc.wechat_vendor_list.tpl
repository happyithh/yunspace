{if $data}
    {foreach $data as $key=>$val}
        <div class="wait-inq">
            <div class="wait-inq-tit clearfix">
                <p>No.{$val['demand_id']}</p>
                <span class="time">{$val['create_time']}</span>
                <h2>客户已收到<span>{$val['sum']}</span>份场地报价<br></h2>
            </div>
            <a class="wait-inq-cont clearfix" target="_blank"
               href="{$_root}m/demand_offer/vendor?action=home&demand_id={$val['demand_id']}&result_id={$val['result_id']}">
                <div class="act-list">
                    <p>活动城市：{$val['demand']['活动城市']}</p>

                    <p>活动类型：{$val['demand']['活动类型']}</p>

                    <p>活动人数：{$val['demand']['活动人数']}</p>
                </div>
                <p>查看详情 &gt;</p>
            </a>
        </div>
    {/foreach}
{else}
    <div class="wait-inq">
        <div class="wait-inq-tit clearfix" style="text-align: center">
            您还没有记录！
        </div>
    </div>
{/if}