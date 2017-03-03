<ul>
    {foreach $page->getSetList['rows']  as $k=>$val}
        <li>
            <a href="{$_home}set_info/{$val->id}.html">
                <div class="list-item-left">
                    {if $val->logo}
                        <img src="{Page_Site_Global::displayMedia($val->logo,275,195)}">
                    {else}
                        <img src="images/vendor.jpg">
                    {/if}
                </div>
                <div class="list-item-right">
                    <p class="name">{$val->set_name}</p>

                    <p class="address">地址:  {$val->addr}</p>

                    <p class="price">参考价格:&nbsp;
                            <span>{if $val->detail['套餐价']}
                            ￥{$val->detail['套餐价']}
                            {if $val->detail['计价单位']}
                                    /{$val->detail['计价单位']}
                                {/if}
                        {else}
                            面议
                        {/if}</span></p>
                </div>
                <div class="clear"></div>
            </a>
        </li>
    {/foreach}
</ul>