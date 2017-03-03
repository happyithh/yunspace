{if $page->vendorInfo['base_info']['业务性质'] || $page->vendorInfo['base_info']['业务范围'] || $page->vendorInfo['base_info']['团队简介']}
    <div class="supplier_left">
{else}
    <div class="supplier_all">
{/if}
    {if $page->productInfo}
        <h4 class="brief_title">服务内容</h4>
        <ul class="list">
            {foreach $page->productInfo as $k=>$v}
                <li>
                    <div class="supplier_img">
                        <a href="{$_root}service_info/{$v['id']}.html">
                            {if $v['logo']}
                                <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
                            {else}
                                <img src="images/vendor.jpg">
                            {/if}
                        </a>
                    </div>
                    <h4>
                        <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>
                    </h4>
                    <small>
                        地址：{$v['attr_new_tags']['地理位置']['城市']}市{$v['addr']}
                    </small>
                </li>
            {/foreach}
        </ul>
    {/if}
</div>

{if $page->vendorInfo['base_info']['业务性质'] || $page->vendorInfo['base_info']['业务范围'] || $page->vendorInfo['base_info']['团队简介']}

<div class="supplier_right">
    <h4 class="brief_title">业务简介</h4>
    {if $page->vendorInfo['base_info']['业务性质']}
        <div class="brief">
            <h5><strong>业务性质</strong></h5>
            {$page->vendorInfo['base_info']['业务性质']}
        </div>
    {/if}
    {if $page->vendorInfo['base_info']['业务范围']}
        <div class="brief">
            <h5><strong>业务范围</strong></h5>
            {$page->vendorInfo['base_info']['业务范围']}
        </div>
    {/if}
    {if $page->vendorInfo['base_info']['团队简介']}
        <div class="brief">
            <h5><strong>团队简介</strong></h5>
            {$page->vendorInfo['base_info']['团队简介']}
        </div>
    {/if}
</div>
{/if}