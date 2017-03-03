<div class="portlet"  >
    <div class="portlet-title" >
        <div class="caption">
            <i class="fa fa-database"></i>匹配信息
        </div>
    </div>
    {if $product_all['rows']}
    <div class="portlet-body" >
        <div class="container-fluid">
            <div class="row">
                <table class="table  table table-striped table-bordered table-advance table-hover">
                    <thead>
                    <tr>
                       {* <td>匹配次数：</td>*}
                        <td>产品id：</td>
                        <td>产品名称：</td>
                        <td>供应商id：</td>
                        <td>供应商名称：</td>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $product_ids as $key =>$val}
                    {foreach $val as $k =>$v}
                    {foreach $product_all['rows'] as $kk => $vv}
                        <tr>
                           {* <td>第{$key}次</td>*}
                            {if $v == $vv['id']}
                                <td>{$vv['id']}</td>
                             <td>
                                 <a href="{$_root}service_info/{md5($vv['id'])}/{$vv['id']}.html" style="text-decoration: none" target="_blank">{$vv['product_name']}</a>
                             </td>

                            <td>{$vv['vendor_id']}</td>
                            <td>{$vv['vendor_name']}</td>
                           {/if}
                        </tr>
                    {/foreach}
                    {/foreach}
                    {/foreach}


                    </tbody>
                </table>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12" style="padding: 0px;">
                    <ul class="pagination">
                        {if $product_all['page']['dpll']}
                            <li class="prev">
                                <a href="{$product_all['page']['dup']}1" title="First"><i
                                            class="fa fa-angle-double-left"></i></a>
                            </li>
                            <li class="prev">
                                <a href="{$product_all['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i
                                            class="fa fa-angle-left"></i></a>
                            </li>
                        {else}
                            <li class="prev disabled">
                                <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                            </li>
                            <li class="prev disabled">
                                <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                            </li>
                        {/if}
                        {for $i=$product_all['page']['dpl'] to $product_all['page']['dpr']}
                            <li{if $i==$product_all['page']['dp']} class="active"{/if}>
                                <a href="{$product_all['page']['dup']}{$i}">{$i}</a>
                            </li>
                        {/for}
                        <li class="disabled">
                            <a> {$product_all['page']['dtp']}
                                ( {$product_all['page']['dp']*$product_all['page']['dn']}
                                /{$product_all['page']['dt']}
                                )</a></li>

                        {if $_data['page']['dprr']}
                            <li class="next">
                                <a href="{$product_all['page']['dup']}{$product_all['page']['dp']+1}" title="Next"><i
                                            class="fa fa-angle-right"></i></a>
                            </li>
                            <li class="next">
                                <a href="{$product_all['page']['dup']}{$product_all['page']['dtp']}" title="Last"><i
                                            class="fa fa-angle-double-right"></i></a>
                            </li>
                        {else}
                            <li class="next disabled">
                                <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                            </li>
                            <li class="next disabled">
                                <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                            </li>
                        {/if}
                    </ul>
                </div>
            </div>
        </div>
        {else}
        <div class="container-fluid">
            <div class="row">
                没有匹配的信息
            </div>
        </div>

    </div>
{/if}
</div>
