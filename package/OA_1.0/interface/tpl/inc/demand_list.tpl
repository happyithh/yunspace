<style>
    @media (max-width: 520px) {
        .list_none {
            display: none;
        }

        .table-responsive table tbody tr td {
            white-space: inherit !important;
        }
    }
</style>
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>
            (当前共<a href="#"> {$_data['page']['dt']} </a>个需求)
        </div>
    </div>

    <div class="portlet-body">
        <div class="tab-content clearfix">
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>#ID</th>
                        <th class="list_none">创建时间</th>
                        <th class="list_none">活动名称</th>
                        <th class="list_none">需求类型</th>
                        <th>联系人</th>
                        <th class="list_none">城市</th>
                        <th>预算范围</th>
                        <th>具体要求</th>
                        <th>负责人</th>
                        <th class="list_none">进度</th>
                        <th width="15%">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $_data['rows'] as $k=>$v}
                        <tr>
                            <td>#{$v['id']}</td>
                            <td class="list_none">{date('Y-m-d H:i',$v['create_time'])}</td>
                            <td class="list_none">{$v['demand_name']}</td>
                            <td class="list_none">{$v['demand_type']}</td>
                            <td class="red">{$v['username']}</td>
                            <td class="list_none">{$v['city']}</td>
                            <td >{$v['price_up']}至{$v['price_down']}</td>
                            <td width="45%">{mb_substr($v['demand']['具体要求'],0,500,'utf-8')}</td>
                            <td>{$_adminInfo[$v['admin_id']]}</td>
                            <td class="list_none">
                                <select class="form-control input-sm" onchange="customerStepUpdate(this)"
                                        data-id="{$v['id']}" {if $v['step']==100}disabled{/if}>
                                    {if $v['customer_type'] == 1}
                                        {foreach $_step_AE as $key=>$val}
                                            <option value="{$key}" {if $v['step']==$key}selected{/if}>{$val}</option>
                                        {/foreach}
                                    {else}
                                        {foreach $_step_funnel as $key=>$val}
                                            <option value="{$key}" {if $v['step']==$key}selected{/if} >{$val}</option>
                                        {/foreach}

                                    {/if}
                                </select>
                            </td>
                            <td>
                                {if $v['contact_id']}
                                    {if Core::$urls['action']=='my_demand_list'}
                                        <a href="{$_route}my_contact_list?tab=3&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=product"
                                           class="btn btn-info btn-xs">服务推荐</a>
                                        <a href="{$_route}my_contact_list?tab=3&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=set"
                                           class="btn btn-info btn-xs">套餐推荐</a>
                                        <a href="{$_route}my_contact_list?tab=3&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=take_look"
                                           class="btn btn-primary btn-xs">带看场地</a>
                                        <a href="{$_route}my_contact_list?id={$v['contact_id']}"
                                           class="btn btn-default btn-xs">联系记录</a>
                                    {else}
                                        <a href="{$_route}contact_urgent_list?tab=3&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=product"
                                           class="btn btn-info btn-xs">服务推荐</a>
                                        <a href="{$_route}contact_urgent_list?tab=3&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=set"
                                           class="btn btn-info btn-xs">套餐推荐</a>
                                        <a href="{$_route}contact_urgent_list?tab=3&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=take_look"
                                           class="btn btn-primary btn-xs">带看场地</a>
                                        <a href="{$_route}department_contact_list?id={$v['contact_id']}"
                                           class="btn btn-default btn-xs">联系记录</a>
                                    {/if}
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
                                    <a href="{$_data['page']['dup']}1" title="First"><i
                                                class="fa fa-angle-double-left"></i></a>
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
        </div>
    </div>
</div>

<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script>
    //修改客户进度
    function customerStepUpdate(o) {
        var step = $(o).find('option:selected').val();
        var id = $(o).attr('data-id');
        $.ajax({
            url: '?action=ajaxCustomerStepUpdate',
            type: 'get',
            data: {
                id: id, step: step
            },
            dataType: 'json',
            success: function (data) {
                top.alert(data.msg);
            }
        });
    }
</script>