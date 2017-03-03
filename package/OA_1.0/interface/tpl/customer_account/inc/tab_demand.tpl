<div>
    <div class="tab-pane active">
        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>创建时间</th>
                <th>姓名</th>
                <th>电话</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $demandInfo['rows'] as $key=>$value}
            <tr>
                <td>{$value['create_time']}</td>
                <td>{$accountInfo['username']}</td>
                <td>{$value['phone']}</td>
                <td>
                    <a href="?action=detail&tab=demand&handle_type=demand_recommend&demand_id={$value['id']}&id={$accountInfo['id']}&recommend_type=product_set" class="btn btn-success btn-xs">推荐</a>
                    {*<a href="?action=detail&tab=demand&handle_type=demand_recommend&demand_id={$value['id']}&id={$accountInfo['id']}&recommend_type=set" class="btn btn-primary btn-xs">套餐推荐</a>
                    <a href="?action=detail&tab=demand&handle_type=demand_recommend&demand_id={$value['id']}&id={$accountInfo['id']}&recommend_type=take_look" class="btn btn-info btn-xs">带看场地</a>
               *} </td>
            </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    <div class="pull-right">
        <ul class="pagination">
            {if $demandInfo['page']['dpll']}
                <li class="prev">
                    <a href="{$demandInfo['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev">
                    <a href="{$demandInfo['page']['dup']}{$demandInfo['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {else}
                <li class="prev disabled">
                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev disabled">
                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {/if}
            {for $i=$demandInfo['page']['dpl'] to $demandInfo['page']['dpr']}
                <li{if $i==$demandInfo['page']['dp']} class="active"{/if}>
                    <a href="{$demandInfo['page']['dup']}{$i}">{$i}</a>
                </li>
            {/for}
            <li class="disabled">
                <a> {$demandInfo['page']['dtp']} ( {$demandInfo['page']['dp']*$demandInfo['page']['dn']}/{$demandInfo['page']['dt']} )</a></li>

            {if $productInfo['page']['dprr']}
                <li class="next">
                    <a href="{$demandInfo['page']['dup']}{$demandInfo['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                </li>
                <li class="next">
                    <a href="{$demandInfo['page']['dup']}{$demandInfo['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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