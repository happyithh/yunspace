<div class="s_left_c mt-1 conw_s">
    <div class="s_title">{$orderinfo['order_title']}</div>
    {if $orderinfo['start_time']}
        <div class="s_title mt30 clearfix">需求档期</div>
        <span><font>开始时间
                : </font> {date('Y-m-d',$orderinfo['start_time'])}</span>
        <span><font>结束时间
                : </font> {date("Y-m-d",$orderinfo['end_time'])}</span>
        <div class="clearfix">
        </div>
    {/if}
    {if $orderinfo['order_detail']['event_type']}
        <div class="s_title mt30 clearfix">活动类型</div>
        <p>
            {$orderinfo['order_detail']['event_type']}
        </p>
    {/if}
    <div class="s_title mt30 clearfix">订单备注</div>
    <p>
        {nl2br($orderinfo['remark'])}
    </p>
</div>
<div class="s_left_c mt-1 conw_s">
    <div class="s_title">基本属性</div>
    <div class="clearfix">
        {foreach $orderinfo['order_detail']['attr'] as $k=>$v}
            {if strpos($k,'基本信息>')===0}
                <span><font>{tplDisplayShortAttrName($k)}
                        : </font> {$v|default:'-'}</span>
            {/if}
        {/foreach}
    </div>
    {if $orderinfo['order_detail']['des']}
        <div class="s_title mt30 clearfix">产品介绍</div>
        <p>
            {nl2br(strip_tags($orderinfo['order_detail']['des']))}
        </p>
    {/if}
</div>