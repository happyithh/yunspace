{*********场地列表***********}
<ul class="mcont-list-cont">
    {foreach $list['rows'] as  $val}
        <li class="clearfix" data-id="{$val['id']}">
            <a target="_blank" href="{$_root}service_info/{$val['id']}.html" class="clearfix">
            <div class="mcont-img">

                    <img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}">

            </div>
            <div class="mcont-details">
                <h2>{$val['product_name']}</h2>

                <p>{$val['attr_index']['特色标签']}</p>

                <div class="m-tag">
                    {foreach $val['activity_type'] as $vv}
                        <span>{$vv}</span>
                    {/foreach}
                </div>
                <p>
                    {if $val['order_people_number']}
                        {$val['order_people_number']}人|
                    {/if}
                    {if $val['order_product_size']}
                        {$val['order_product_size']}㎡ |
                    {/if}
                    {if $val['addr']}
                        {$val['addr']}
                    {/if}
                    &nbsp;</p>
            </div>
            <!--mcont-details-end-->
            <div class="mcont-price">
                {if $val['price'] > 100}
                    <strong>{$val['price']}</strong>
                    <span>/元</span>
                {else}
                    <strong></strong>
                    <span>面议</span>
                {/if}
            </div>
            </a>
        </li>
    {/foreach}
</ul>
{if $list['rows']}
    <div class="pagers" id="pagers">
        {if $list['page']['dpll']}
            <a href="javascript:;" data-value="1" title="First">第一页</a>
            <a href="javascript:;" data-value="{$list['page']['dp']-1}"
               title="Prev">上一页</a>
        {else}
            <a href="javascript:;" data-value="1" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
            <a href="javascript:;" data-value="" class="prev gray">&lt;&nbsp;上一页</a>
        {/if}
        {for $i=$list['page']['dpl'] to $list['page']['dpr']}
            <a href="javascript:;" data-value="{$i}"{if $i==$list['page']['dp']} class="active"{/if}>{$i}</a>
        {/for}

        {if $list['page']['dprr']}
            <a href="javascript:;" data-value="{$list['page']['dp']+1}"
               title="Next">下一页&nbsp;&gt;</a>
            <a href="javascript:;" data-value="{$list['page']['dtp']}"
               title="Last">最后页&nbsp;&raquo;</a>
        {else}
            <a href="javascript:;" data-value="" class="next gray">下一页&nbsp;&gt;</a>
            <a href="javascript:;" data-value="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
        {/if}

        <div class="clearfix"></div>
    </div>
{/if}