<div class="portlet" style="border: none">
    <div class="portlet-title" >
        <div class="caption">
            <i class="fa fa-database"></i>方案列表
        </div>
    </div>
    {if $product}
        <div class="portlet-body">
            <div class="container-fluid">
                <div class="row">
                    <table class="table  table table-striped table-bordered table-advance table-hover">
                        <thead>
                        <tr>
                            <td>方案：</td>
                            <td>产品名称：</td>
                            <td>产品地址：</td>
                            <td>联系人：</td>
                            <td>联系电话：</td>
                            <td>报价：</td>
                            <td>状态：</td>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data as $key => $val}
                            {foreach $product as $k => $v}
                                {if $val['product_id'] == $v['id']}
                                    <tr>
                                        <td>方案{$key+1}</td>
                                        <td><a href="{$_root}service_info/{md5($v['id'])}/{$v['item_id']}.html"
                                               style="text-decoration: none" target="_blank">{$v['product_name']}</a>
                                        </td>
                                        <td>{$v['addr']}</td>
                                        <td>{$val['scheme']['联系人']}</td>
                                        <td>{$val['scheme']['联系电话']}</td>
                                        <td>{$val['quote']}</td>
                                        <td>
                                        {foreach $status as $kk => $vv}
                                           {if $val['status'] == $kk}
                                                    {$vv}
                                                {/if}
                                        {/foreach}
                                        </td>
                                    </tr>
                                {/if}
                            {/foreach}
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
            {else}
            <div class="container-fluid">
                <div class="row">
                    没有匹配的方案
                </div>
            </div>
        </div>
    {/if}
</div>