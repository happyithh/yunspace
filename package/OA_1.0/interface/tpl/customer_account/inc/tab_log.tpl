<div>
    <div class="tab-pane active">
        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>操作时间</th>
                <th>操作类型</th>
                <th>操作内容</th>
                <th>操作对象ID</th>
                <th>操作人</th>
            </tr>
            </thead>
            <tbody>
            {foreach $logInfo['rows'] as $key=>$value}
            <tr role="row">
                <td>{date('Y-m-d H:i:s',$value['create_time'])}</td>
                <td>{$value['operate_type']}</td>
                <td>{$value['operate_message']}</td>
                <td>{$value['object_id']}</td>
                <td>{if $value['username']}{$value['username']}&nbsp;(管理员){else}{$accountInfo['username']}{/if}</td>
            </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    <div class="pull-right">
        <ul class="pagination">
            {if $logInfo['page']['dpll']}
                <li class="prev">
                    <a href="{$logInfo['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev">
                    <a href="{$logInfo['page']['dup']}{$logInfo['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {else}
                <li class="prev disabled">
                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev disabled">
                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {/if}
            {for $i=$logInfo['page']['dpl'] to $logInfo['page']['dpr']}
                <li{if $i==$logInfo['page']['dp']} class="active"{/if}>
                    <a href="{$logInfo['page']['dup']}{$i}">{$i}</a>
                </li>
            {/for}
            <li class="disabled">
                <a> {$logInfo['page']['dtp']} ( {$logInfo['page']['dp']*$logInfo['page']['dn']}/{$logInfo['page']['dt']} )</a></li>

            {if $productInfo['page']['dprr']}
                <li class="next">
                    <a href="{$logInfo['page']['dup']}{$logInfo['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                </li>
                <li class="next">
                    <a href="{$logInfo['page']['dup']}{$logInfo['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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