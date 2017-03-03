{if $data}
    {foreach $data as $key=>$val}
        <li class="demand-month">{$key}月</li>
        {foreach $val as $k=>$v}
            {if $_REQUEST['type']==-1}
                <li class="datalist">
                    <span class="demand-list">
                        <span class="ion-clock demand-icon-1"></span>
                        <span class="demand-title">{$v['demand_name']}</span>
                        <span yun="chatBar/chat_demand.js::demandRenew@click" yun-demand_id="{$v['id']}"
                              class="chat-demand-renew">恢复</span>
                        <input type="hidden" value="{$v['id']}">
                    </span>
                </li>
            {else}
                <li class="datalist">

                    <a href="{$root}chat_demand_info?demand_id={$v['id']}" class="demand-list">
                        <span class="ion-clock demand-icon-1"></span>
                        <span class="demand-title">{$v['demand_name']}</span>
                        <span class="ion-chevron-right demand-icon-2"></span>
                        <input type="hidden" value="{$v['id']}">
                    </a>
                </li>
            {/if}
        {/foreach}
        <div class="clear"></div>
    {/foreach}
{/if}