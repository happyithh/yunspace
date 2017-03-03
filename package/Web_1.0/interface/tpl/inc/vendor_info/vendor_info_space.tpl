<div class="supplier_all">
<h4 class="brief_title">服务内容</h4>
{foreach $page->productInfo as $k=>$v}
<div class="se_li_list">
    <div class="fl img_list">
        <a href="{$_root}service_info/{$v['id']}.html">
            {if $v['logo']}
                <img src="{Page_Site_Global::displayMedia($v['logo'],275,195)}">
            {else}
                <img src="images/vendor.jpg">
            {/if}
        </a>
    </div>
    <div class="tw clearfix">
        <div class="fl wz">
            <h3>
                <a href="{$_root}service_info/{$v['id']}.html">{$v['product_name']}</a>
            </h3>
            {if $v['addr']}
                <span>
                        <font>地址: </font>
                    {$v['attr_new_tags']['地理位置']['城市']}市{$v['addr']}
                        </span>
            {/if}
            {if $v['product_size']}
                <span class="space"><font>空间大小 : </font>
                    {$v['product_size']}
                    平方米</span>
            {/if}
            {if $v['attr_index'][$page->tagsName['适合活动类型']]}
                <span class="type"><font>适合活动类型
                        : </font>
                    {$v['attr_new_tags']['通用信息']['活动类型']}</span>
            {else}
            {/if}
        </div>
        <div class="fr mene">
            <span class="mena_m">
                {if $v['price']>100}
                    {if $_COOKIE['look_price_phone']}
                         ¥ {$v['price']}
                         {if $v['attr_new']['起价']}起{/if}
                         {if $v['attr_new']['计价单位']}/{$v['attr_new']['计价单位']}{/if}
                    {else}
                        <a class="look-price js-look-price" data-name="{$v['product_name']}" data-city="{$v['attr_new'][46]|default:$smarty.cookies.city}" href="javascript:;">查看参考价</a>
                        <div class="hide ref-price">
                            ¥ {$v['price']}
                            {if $v['attr_new']['起价']}起{/if}
                            {if $v['attr_new']['计价单位']}/{$v['attr_new']['计价单位']}{/if}
                        </div>
                    {/if}
                {else}
                    面议
                {/if}

                {*{if $v['price']>100}￥{$v['price']}{else}面议{/if}*}
            </span>
        </div>
    </div>
</div>
{/foreach}
</div>