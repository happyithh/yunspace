<ul>
    {foreach $page->getSpaceList['rows'] as $k=>$v}
        <li>
            <a href="{$_home}service_info/{$v['id']}.html">
                <div class="list-item-left">
                        {if $v['logo']}
                            <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
                        {else}
                            <img src="images/vendor.jpg">
                        {/if}
                </div>
                <div class="list-item-right">
                    <p class="name">{$v['product_name']}</p>
                    <p class="address">
                        {if Core::$urls['route'] =="space/"}
                        地址:  {$v['attr_index'][$page->tagsName['城市']]}市{$v['addr']}</p>
                    {else}
                    供应商：{$v['vendor_name']}
                    {/if}
                    <p class="price">参考价格:&nbsp;
                        <span>{if $v['price']>100}
                                <span1>¥&nbsp;</span1>
                                {$v['price']}{else}面议{/if}</span>
                    </p>
                </div>
                <div class="clear"></div>
            </a>
        </li>
    {/foreach}
</ul>
