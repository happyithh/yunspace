{foreach $list['rows'] as $k=>$v}
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
                        {$v['attr']['城市']}市{$v['addr']}
                            </span>
                {else}
                    <span class="supplier0">
                            <font>供应商: </font>
                                <a href="{$_root}vendor_info/{$v['vendor_id']}.html"> {$vendors[$v['vendor_id']]['vendor_name']}</a>
                            </span>
                {/if}
                {if $v['attr']['基本信息>面积']}
                    <span class="space"><font>空间大小 : </font>
                        {$v['attr']['基本信息>面积']}
                        平方米</span>
                {/if}
                {if $v['attr']['基本信息>适合活动类型']}
                    <span class="type"><font>适合活动类型 : </font>
                        {$v['attr']['基本信息>适合活动类型']}</span>
                {else}
                {/if}
            </div>

            <div class="fr mene">
                <span class="mena_m">{if $v['price']>100}￥{$v['price']}{else}面议{/if}</span>
                {*<span class="mena_m">面议</span>*}
                <div class="dbl">
                    {*<span class="s_btn inline-block bgc2"><a href="#">保证金用户</a></span>*}
                    {*<span class="s_btn inline-block bgc2"><a href="#">五星推荐</a></span>*}
                </div>
            </div>
        </div>
    </div>
{/foreach}