<div class="table-responsive">
    <table class="table table-striped table-bordered table-advance table-hover">
        <tr>
            <th style="width: 30px;" class="list_none">#ID</th>
            <th style="width: 82px;">创建时间</th>
            <th style="width: 82px;">需求级别</th>
            <th style="width: 62px;">响应</th>
            <th style="width: 82px;overflow: hidden">活动名称</th>
            <th class="list_none">需求类型</th>
            <th>联系人</th>
            <th>联系电话</th>
            <th class="list_none">城市</th>
            <th class="list_none">预算范围</th>
            <th class="list_none">活动类型</th>
            <th class="list_none">场地类型</th>
            <th class="list_none" width="100px;" height="40px;">具体要求</th>
            <th class="list_none">标记</th>

            <th>操作</th>
        </tr>
        {foreach $_data['rows'] as $k=>$v}
            <tr>
                <td>{$v['id']}{if $v['mark']}<span class="btn btn-sm btn-danger"
                                                   style="display: inline">{$v['mark']}</span>{/if}
                </td>
                <td>{Func_Time::format($v['create_time'])}</td>
                <td>
                    {if $v['demand_level']==2}
                        高级
                    {elseif $v['demand_level']==1}
                        中级
                    {else}
                        普通
                    {/if}
                </td>
                <td>{$v['response']}</td>
                <td>{$v['demand_name']}</td>
                <td>{$v['demand_type']}</td>
                {*<td>{$v['demand']['公司名称']}</td>*}
                <td class="red">{$v['demand']['联系人']}</td>
                <td>{$v['phone']}</td>
                <td>{$v['city']}</td>
                <td>{$v['price_up']}至{$v['price_down']}</td>
                <td>{if $v['demand']['业务类型']}{$v['demand']['业务类型']}{else}{$v['demand']['活动类型']}{/if}</td>
                <td>{$v['demand']['场地类型']}</td>
                <td>
                    <div style="min-height: 20px;min-width: 100px;max-width: 200px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis">
                        {$v['demand']['具体要求']}
                    </div>
                </td>
                <td>
                    {if $v['response_when']>20}
                        <span class="badge badge-important">超过20分处理</span>
                    {/if}
                    {if $v['mark_tags']}
                        {foreach $v['mark_tags'] as $key =>$val}
                            {if $key <11}
                                <span class="badge badge-important"> {$val}</span>
                            {elseif $key > 19}
                                <span class="badge badge-success"> {$val}</span>
                            {/if}
                        {/foreach}
                    {/if}
                    {if $v['source']}
                        <span class="badge badge-default"> {$v['source']}</span>
                    {/if}
                    {if !empty($v['demand_reason'])}
                        <hr>
                        拒绝理由:{$v['demand_reason'][0]}{$v['demand_reason'][1]}
                    {/if}
                </td>
                <td>
                    {*<a href="?action=detail&id={$v['id']}&type={if $_REQUEST['type']}{$_REQUEST['type']}{else}waiting{/if}"*}
                    {*class="btn btn-info btn-xs">查看详情</a>*}

                    {if $v['demand_status']==0}
                        <a href="?action=detail&id={$v['id']}&type={if $_REQUEST['type']}{$_REQUEST['type']}{else}waiting{/if}"
                           class="btn btn-xs btn-danger">审核</a>
                    {/if}
                    {if $v['demand_status']==1 || $v['demand_status']==5}
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