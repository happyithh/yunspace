{if $list}
    <ul class="mcont-list-cont">
        {foreach $list as  $val}
            <li class="clearfix"
                data-id="{$val['id']}" {if $_REQUEST['id']==$val['id']} style="background-color: #f4f4f4" {/if}>
                <a target="_blank" href="{$_root}service_info/{$val['id']}.html">
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
{else}
    {include "Web_Static::map_search.v1.0/inc/no_result.tpl"}
{/if}