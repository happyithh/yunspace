{if $data}
    {foreach $data as $key=>$val}
        <!--正在等待商家报价-->
        <div class="wait-inq">
            <div class="wait-inq-tit clearfix">
                <div class="h-100 clearfix">

                    {if $_REQUEST['status'] ==''}
                        <h2 class="fl">等待报价{if $val['status'] <0 }(已关闭){/if}</h2>
                        <p class="fr"><span>{$val['sum']}</span>个场地已报价</p>
                    {else}
                        {if  is_numeric(mb_strpos($_REQUEST['status'],'reported'))}
                            {if $val['change_phone_time'] >0}
                                有意向
                            {else}
                                待确认
                            {/if}
                        {/if}
                    {/if}

                </div>
                <div class="nmtm clearfix">
                    <span class="fl numbs">No.{$val['demand_id']}</span>
                    <span class="fr time">{$val['create_time']}</span>
                </div>

            </div>
            <a class="wait-inq-cont clearfix"
               href="{$_root}m/demand_offer.v2/vendor?action=home&demand_id={$val['demand_id']}&result_id={$val['result_id']}">
                <div class="act-list">
                    <p>活动人数：{$val['demand']['活动人数']}</p>

                    <p>活动档期：{if $val['day'] > 0}({$val['day']})天 ,{/if}{$val['demand']['开始时间']}
                        &nbsp;-&nbsp;{$val['demand']['结束时间']}</p>

                    <p>活动预算： {if $val['price_up']>100}
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
            您还没有记录！
        </div>
    </div>
{/if}