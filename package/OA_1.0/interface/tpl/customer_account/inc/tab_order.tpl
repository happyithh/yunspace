<div >
    <div class="tab-pane active">
            <form action="?">
                <input type="hidden" name="city" value="上海">
                <input type="hidden" name="PHPSESSID" value="ve5iv9e9rmolvoqr409t3uj1p5">
                <input type="hidden" name="cities" value="Array">
            </form>
        </div>
        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>订单编号</th>
                <th>产品名称</th>
                <th>供应商名称</th>
                <th>订单账户</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $orderInfo['rows'] as $key=>$value}
            <tr role="row">
                <td>
                    {$value['order_no']}
                    <span>
                        {if $value['status']==0}
                            <a class="btn-xs btn-warning">已放弃</a>
                        {elseif $value['status']==1}
                            <a class="btn-xs btn-primary">待处理</a>
                        {elseif $value['status']==3}
                            <a class="btn-xs btn-success">已处理</a>
                        {/if}
                    </span>
                </td>
                <td>{$value['product_name']}</td>
                <td>{$value['vendor_name']}</td>
                <td>{$value['username']}</td>
                <td>
                    <a href="{$_root}/{Core::$urls['host']}/{Core::$urls['package']}marketing/commission_order?action=get_order_detail&order_no={$value['order_no']}" class="btn btn-success btn-xs">查看订单</a>
                </td>
            </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    <div class="pull-right">
        <ul class="pagination">
            {if $orderInfo['page']['dpll']}
                <li class="prev">
                    <a href="{$orderInfo['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev">
                    <a href="{$orderInfo['page']['dup']}{$orderInfo['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {else}
                <li class="prev disabled">
                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev disabled">
                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {/if}
            {for $i=$orderInfo['page']['dpl'] to $orderInfo['page']['dpr']}
                <li{if $i==$orderInfo['page']['dp']} class="active"{/if}>
                    <a href="{$orderInfo['page']['dup']}{$i}">{$i}</a>
                </li>
            {/for}
            <li class="disabled">
                <a> {$orderInfo['page']['dtp']} ( {$orderInfo['page']['dp']*$orderInfo['page']['dn']}/{$orderInfo['page']['dt']} )</a></li>

            {if $productInfo['page']['dprr']}
                <li class="next">
                    <a href="{$orderInfo['page']['dup']}{$orderInfo['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                </li>
                <li class="next">
                    <a href="{$orderInfo['page']['dup']}{$orderInfo['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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