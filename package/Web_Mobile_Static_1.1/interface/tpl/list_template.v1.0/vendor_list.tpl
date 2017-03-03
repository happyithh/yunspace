<ul>
    {foreach $page->getVendorList['rows'] as $k=>$v}
        <li>
            <a href="{$_home}vendor_info/{$v['id']}.html">
                <div class="list-item-left">
                    {if $v['logo']}
                        <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
                    {else}
                        {*<img src="images/vendor.jpg">*}
                        <img src="img/v1.0/vendor.jpg">
                    {/if}
                </div>
                <div class="list-item-right">
                    <p class="name">{$v['vendor_name']}</p>
                    <p class="address">
                        {*{if Core::$urls['route'] =="space/"}*}
                        {*地址:  {$v['attr_index'][$page->tagsName['城市']]}市{$v['addr']}*}
                        地址:  {$v['addr']}</p>
                    {if $v['vendor_remarks']['签约状态']==2}
                    <p class="pag"><img src="img/vendor_info.v1.0/pag.png"> </p>
                    {/if}
                    {*{else}*}
                    {*供应商：{$v['vendor_name']}*}
                    {*{/if}*}
                </div>
                <div class="clear"></div>
            </a>
        </li>
    {/foreach}
</ul>
