{if $data}
    {foreach $data as $key=>$val}
        <div class="chat-demand-info-month">{$key}月</div>
        <ul class="cander-record">
            {foreach $val as $kk=>$vv}
                <li>
                    <div class="record-message" style="position:relative">
                        <div class="circle-stroke">
                            <div class="circle-fill"></div>
                        </div>

                        <div class="person-record-img" style="float:left;width:22%">
                            <img src="{$_root}user_center/avatar/{$vv['recommend_account_id']}.jpg" alt="头像">

                            <div class="record-message-rtg"></div>

                        </div>
                        <div style="overflow: hidden;*zoom:1">
                            <div class="record-time-more" data-demand-id="{$vv['demand_id']}">
                                <p class="record-time">{Date("y-m-d H:i:s",$vv['create_time'])}</p>
                                <input class="more_id" type="hidden" value="{$vv['id']}">

                                <p class="record-icon" yun="chatBar/chat_demand.js::showState@click"><span
                                            class="ion-chevron-down"></span></p>
                            </div>
                        </div>
                        <div class="record-message-box">
                            <div class="record-message-info">
                                <ul class="record-state">
                                    {*<li>*}
                                    {*{if $vv['set_id']}*}
                                    {*<a target="_blank"*}
                                    {*href="{$_root}order_booking?id={$vv['set_id']}&type=2">创建订单</a>*}
                                    {*{else}*}
                                    {*<a target="_blank"*}
                                    {*href="{$_root}order_booking?id={$vv['product_id']}&type=1">创建订单</a>*}
                                    {*{/if}*}
                                    {*</li>*}
                                    <li>
                                        <a href="javascript:;" yun="chatBar/chat_demand.js::stateActive@click"
                                           yun-feedback="3" yun-demand-id="{$_REQUEST['demand_id']}"
                                           yun-recommend-id="{$vv['id']}">我有意向</a>
                                    </li>
                                    <li>
                                        <a href="javascript:;"
                                           yun="chatBar/chat_demand.js::demandTakeLook@click" yun-feedback="5"
                                           yun-demand-id="{$_REQUEST['demand_id']}"
                                           yun-recommend-id="{$vv['id']}">我想带看场地</a>
                                    </li>

                                    <li>
                                        <a href="{$root}chat_demand_remark?demand_id={$_REQUEST['demand_id']}&recommend_id={$vv['id']}">备注</a>
                                    </li>

                                    <li><a href="javascript:;" yun="chatBar/chat_demand.js::stateActive@click"
                                           yun-feedback="-1" yun-demand-id="{$_REQUEST['demand_id']}"
                                           yun-recommend-id="{$vv['id']}">我没意向</a>
                                    </li>
                                </ul>
                                {*******名称在这里显示的*****}
                                <a target="_blank" href="{$vv['link']}">
                                    <p>{*{$vv['demo']}*}
                                        <span class="demand-show-name">{if $vv['set_name']}[套餐]{$vv['set_name']}{else}[产品]{$vv['product_name']}{/if} </span>
                                        <span class="record-code">{$customer_feedback[$vv['customer_feedback']]}</span>
                                    </p>
                                </a>
                            </div>
                            {if {$vv['demo']}}
                                <div class="memo">{$vv['demo']}</div>
                            {/if}
                            <a href="{$vv['link']}" target="_blank"
                               style="overflow: hidden;*zoom:1;background: #dddddd">
                                {if $vv['set_media']}
                                    <ul class="record-img">
                                        {foreach $vv['set_media'] as $k =>$vvv}
                                            {if $k <3}
                                                <li>
                                                    <img src="{Page_Site_Global::displayMedia($vvv['path'],275,195)}"
                                                         alt="{$vvv['name']}"></li>
                                            {/if}
                                        {/foreach}
                                    </ul>
                                {/if}
                                {if $vv['product_media']}
                                    <ul class="record-img">
                                        {foreach $vv['product_media'] as $k =>$vvv}
                                            {if $k <3}
                                                <li>
                                                    <img src="{Page_Site_Global::displayMedia($vvv['path'],275,195)}"
                                                         alt="{$vvv['name']}"></li>
                                            {/if}
                                        {/foreach}
                                    </ul>
                                {/if}
                            </a>
                        </div>
                    </div>

                </li>
            {/foreach}
            <div class="clear"></div>
        </ul>
    {/foreach}
{/if}
