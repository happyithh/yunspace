<div class="table-responsive">
    <table class="table table-striped table-bordered table-advance table-hover">
        <thead>
        <tr>
            <th style="width: 30px;" class="td-mbl-hide">#ID</th>
            <th class="td-mbl-hide">创建时间</th>
            <th class="td-mbl-hide">需求类型</th>
            <th>账户名</th>
            <th>联系人</th>
            <th>联系电话</th>
            <th class="td-mbl-hide">城市</th>
            <th class="td-mbl-hide">业务类型</th>
            <th class="td-mbl-hide">具体要求</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        {foreach $_data['rows'] as $k=>$v}
            <tr>
                <td class="td-mbl-hide">{$v['id']}

                </td>
                <td class="td-mbl-hide">{Func_Time::format($v['create_time'])}</td>
                <td class="td-mbl-hide">{$v['demand_type']}</td>
                <td class="">#{$v['username']}</td>
                <td class="red">{$v['demand']['联系人']}</td>
                <td>{$v['phone']}</td>
                <td class="td-mbl-hide">{$v['city']}</td>
                <td class="td-mbl-hide">{if $v['demand']['业务类型']}{$v['demand']['业务类型']}{else}{$v['demand']['活动类型']}{/if}</td>
                <td class="td-mbl-hide">{$v['demand']['具体要求']}</td>
                <td>
                    {*<a href="?action=detail&id={$v['id']}&type={if $_REQUEST['type']}{$_REQUEST['type']}{else}waiting{/if}"*}
                    {*class="btn btn-info btn-xs">查看详情</a>*}

                    {if $v['demand_status']==0}
                        <a href="?action=detail&id={$v['id']}&type={if $_REQUEST['type']}{$_REQUEST['type']}{else}waiting{/if}"
                           class="btn btn-xs btn-danger">审核</a>
                    {/if}
                    {if $v['demand_status']==1}
                        <a href="?action=detail&id={$v['id']}&type={if $_REQUEST['type']}{$_REQUEST['type']}{else}waiting{/if}"
                           class="btn btn-xs btn-info">查看</a>
                    {/if}
                    {if $v['demand_status']< 0}
                        <a href="?action=detail&id={$v['id']}&type={if $_REQUEST['type']}{$_REQUEST['type']}{else}waiting{/if}"
                           class="btn btn-xs btn-default" style="background-color: rgba(238, 238, 238,0.8);">已放弃</a>
                    {/if}
                </td>

            </tr>
        {/foreach}
        </tbody>
    </table>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12" style="padding: 0px;">
            <ul class="pagination">
                {if $_data['page']['dpll']}
                    <li class="prev">
                        <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i
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
                {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                    <li{if $i==$_data['page']['dp']} class="active"{/if}>
                        <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$_data['page']['dtp']}
                        ( {$_data['page']['dp']*$_data['page']['dn']}
                        /{$_data['page']['dt']}
                        )</a></li>

                {if $_data['page']['dprr']}
                    <li class="next">
                        <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                    class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
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