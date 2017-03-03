<div class="order-details">
    <div class="order-details-title clearfix">
        <div class="col-1 clearfix">
            {if $_REQUEST['type']=="B"}
                <h3 class="fl">{$data['backup_demand']['联系人']},{$data['backup_demand']['联系电话']}</h3>
                <a class="fr contact-btn" href="tel:{$data['backup_demand']['联系电话']}">联系他</a>
            {else}
                <h3>{$data['nick_username']},{$data['nick_phone']}</h3>
            {/if}
        </div>
        <div class="col-2 clearfix">
            <p class="fl">提交时间：{$data['demand_create_time']}</p>

            <p class="fr">NO.{$data['id']}</p>
        </div>
    </div>
    <!--order-details-title-end-->
    <ul class="order-details-cont clearfix">
        {if $_REQUEST['type']=="B" && !$look_offer}
            <a class="collect-quotes" href="?action=needs&id={$data['id']}">请求报价系统提供场地</a>
        {/if}
        <!-----查看报价------>
        {if $look_offer}
            <a style="position:absolute;top:12px;right: 15px;" class=" clearfix"
               href="{$_home}demand_offer.v2/customer?demand_id={Func_NumEncode::e($data['id'])}"
               target="_blank">查看报价（{$sum}）</a>
        {/if}
        <li>
            <p class="name">活动人数：</p>

            <p class="substance">{$data['demand']['活动人数']}</p>
        </li>
        <li>
            <p class="name">活动档期：</p>

            <p class="substance">{$data['schedule']}</p>
        </li>
        <li>
            <p class="name">活动预算：</p>

            <p class="substance">{$data['price']}</p>
        </li>
        <li>
            <p class="name">活动城市：</p>

            <p class="substance">{if $data['demand']['活动城市']} {$data['demand']['活动城市']}{else}{$data['demand']['城市']}{/if}</p>
        </li>
        <li>
            <p class="name">活动类型：</p>

            <p class="substance">{$data['demand']['活动类型']}</p>
        </li>
        {if $data['demand']['活动标签']}
            <li>
                <p class="name">活动标签：</p>

                <p class="substance marks">
                    {$tags=explode(',',$data['demand']['活动标签'])}
                    {if $tags}
                        {foreach $tags as $key =>$val}
                            <span>{$val}</span>
                        {/foreach}
                    {else}
                        <span>{$data['demand']['活动标签']}</span>
                    {/if}
                </p>
            </li>
        {/if}
        <li>
            <p class="name">具体要求：</p>

            <p class="substance">{$data['demand']['具体要求']}</p>
        </li>
    </ul>
</div><!--order-details-end-->