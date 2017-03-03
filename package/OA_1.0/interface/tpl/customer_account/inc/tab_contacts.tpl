<div >
    <div class="tab-pane active">
        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>联系人名称</th>
                <th>手机号</th>
                <th>公司</th>
                <th>职位</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $contactInfo['rows'] as $key=>$value}
            <tr role="row">
                <td>{$value['username']}</td>
                <td>{$value['phone']}</td>
                <td>{$value['company']}</td>
                <td>{$value['position']}</td>
                <td><a class="btn btn-info btn-xs" href="contact_detail?id={$value['id']}">查看</a></td>
            </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    <div class="pull-right">
        <ul class="pagination">
            {if $contactInfo['page']['dpll']}
                <li class="prev">
                    <a href="{$contactInfo['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev">
                    <a href="{$contactInfo['page']['dup']}{$contactInfo['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {else}
                <li class="prev disabled">
                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                </li>
                <li class="prev disabled">
                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                </li>
            {/if}
            {for $i=$contactInfo['page']['dpl'] to $contactInfo['page']['dpr']}
                <li{if $i==$contactInfo['page']['dp']} class="active"{/if}>
                    <a href="{$contactInfo['page']['dup']}{$i}">{$i}</a>
                </li>
            {/for}
            <li class="disabled">
                <a> {$contactInfo['page']['dtp']} ( {$contactInfo['page']['dp']*$contactInfo['page']['dn']}/{$contactInfo['page']['dt']} )</a></li>

            {if $productInfo['page']['dprr']}
                <li class="next">
                    <a href="{$contactInfo['page']['dup']}{$contactInfo['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                </li>
                <li class="next">
                    <a href="{$contactInfo['page']['dup']}{$contactInfo['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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