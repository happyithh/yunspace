<style>
    @media (max-width: 520px) {
        .list_none{
            display: none;
        }
        .table-responsive table tbody tr td {
            white-space: inherit!important;
        }
    }
</style>
<div class="tab-content clearfix">
    <h5>
        <i class="fa fa-database"></i>该联系人共<a href="#"> {$contact_demand['page']['dt']} </a>个需求
    </h5>

    <div class="table-responsive">
        <table class="table table-striped table-bordered table-advance table-hover">
            <thead>
            <tr>
                <th width="100px">#ID</th>
                <th class="list_none">创建时间</th>
                <th class="list_none">需求类型</th>
                <th class="list_none">城市</th>
                <th>电话</th>
                <th>具体要求</th>
                {*<th>需求状态</th>*}
                <th>查看详情</th>
            </tr>
            </thead>
            <tbody>
            {foreach $contact_demand['rows'] as $k=>$v}
                <tr>
                    <td>
                        <span>{$v['id']}</span>
                    </td>
                    <td class="list_none">{Func_Time::format($v['create_time'])}
                        <span style="margin-left:10px;">
                            {if $v['demand_status']==0}
                                <button class="btn btn-xs btn-warning">
                                    待处理
                                </button>


                                                                                                    {elseif $v['demand_status']==1}


                                <button class="btn btn-xs btn-success">
                                    已处理
                                </button>


                                                                                                    {elseif $v['demand_status']==-1}


                                <button class="btn btn-xs btn-danger">
                                    已放弃
                                </button>
                            {/if}
                        </span>
                    </td>
                    <td class="list_none">{$v['demand_type']}</td>
                    <td class="list_none">{$v['city']}</td>
                    <td>{$v['phone']}</td>
                    <td>{$v['demand']['具体要求']}</td>
                    <td>
                        <a href="?tab=3&demand_id={$v['id']}&id={$data['id']}&recommend_type=product" class="btn btn-xs btn-success">服务推荐</a>
                        <a href="?tab=3&demand_id={$v['id']}&id={$data['id']}&recommend_type=set" class="btn btn-xs btn-primary">套餐推荐</a>
                        <a href="?tab=3&demand_id={$v['id']}&id={$data['id']}&recommend_type=take_look" class="btn btn-xs btn-info">带看场地</a>
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
                    {if $contact_demand['page']['dpll']}
                        <li class="prev">
                            <a href="{$contact_demand['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$contact_demand['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {else}
                        <li class="prev disabled">
                            <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev disabled">
                            <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                        </li>
                    {/if}
                    {for $i=$contact_demand['page']['dpl'] to $contact_demand['page']['dpr']}
                        <li{if $i==$contact_demand['page']['dp']} class="active"{/if}>
                            <a href="{$contact_demand['page']['dup']}{$i}">{$i}</a>
                        </li>
                    {/for}
                    <li class="disabled">
                        <a> {$contact_demand['page']['dtp']}
                            ( {$contact_demand['page']['dp']*$contact_demand['page']['dn']}
                            /{$contact_demand['page']['dt']}
                            )</a></li>

                    {if $contact_demand['page']['dprr']}
                        <li class="next">
                            <a href="{$contact_demand['page']['dup']}{$contact_demand['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$contact_demand['page']['dup']}{$contact_demand['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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


