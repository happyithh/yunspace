{foreach $page->getSpaceList['rows'] as $k=>$v}
    <li>
        <div class="product_img">
            <a href="{$_root}service_info/{$v['id']}.html">
                {if $v['logo']}
                    <img src="{if $v['create_by_quick']}{Page_Site_Global::displayMedia($v['logo'],275,195,0,'thc')}{else}{Page_Site_Global::displayMedia($v['logo'],275,195)}{/if}" alt="{$v['name']}">
                {else}
                    <img src="images/vendor.jpg">
                {/if}
            </a>
            {if $v['addr']}
                <div class="addr">{$v['addr']}</div>
            {/if}
        </div>
        <h1>
            <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a><br/>
            <small>
                <a href="{$_root}vendor_info/{$v['vendor_id']}.html"> {$page->vendors[$v['vendor_id']]['vendor_name']}</a>
            </small>
        </h1>
    </li>
{/foreach}