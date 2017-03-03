<div class="quote-title clearfix">


    {if $data['change_phone_time'] > 0 }
        <p class="fl state">客户有意向，联系他吧{if $demand_offer['demand_type']=='档期咨询'}({$demand_offer['demand_type']}){/if}</p>
        {if $demand_offer['status'] < 0}
            <div style="float: right;overflow: auto;padding-top: 5px;color: rgb(153, 153, 153)">
                报价已经结束
            </div>
        {/if}
    {elseif $data['change_phone_time'] <0 }
        {if $demand_offer['status'] < 0}
            <p class="fl state">
                客户无意向{if $demand_offer['demand_type']=='档期咨询'}({$demand_offer['demand_type']}){/if}</p>
            <div style="float: right;overflow: auto;padding-top: 5px; color: rgb(153, 153, 153);">
                报价已经结束
            </div>
        {else}
            <p class="fl state">
                客户无意向，重新报个价吧{if $demand_offer['demand_type']=='档期咨询'}({$demand_offer['demand_type']}){/if}</p>
        {/if}
    {elseif $data['offer_time'] }
        <p class="fl state">已报价，待确认意向{if $demand_offer['demand_type']=='档期咨询'}({$demand_offer['demand_type']}){/if}</p>
        {if $data['countdown']>0}
            <div style="float: right;overflow: auto;padding-top: 6px;">还剩
                <span style="color: rgb(254, 106, 58)" id="countdown" data-time="{$data['countdown']}"></span>
            </div>
        {/if}
    {else}
        <p class="fl state">等待报价</p>
    {/if}

</div>
<script>
    $(function () {
        var _endTime = $("#countdown").attr('data-time');
        addTimer("countdown", _endTime);
    });
</script>