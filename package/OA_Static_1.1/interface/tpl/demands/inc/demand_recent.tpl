<div class="portlet widthset">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>该联系人最近需求
        </div>
    </div>
    {if $recent_demand}
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row">
                <table class="table  table table-striped table-bordered table-advance table-hover">
                    <thead>
                    <tr>
                        <td>状态：</td>
                        <td>创建时间：</td>
                        <td>责任人：</td>
                        <td>联系人：</td>
                        <td>公司名称：</td>
                        <td>活动城市：</td>
                        <td>需求类型：</td>
                        <td>预算范围：</td>
                        <td>具体要求：</td>
                        <td>其他信息：</td>

                    </tr>
                    </thead>
                    <tbody>
                    {foreach $recent_demand as $key =>$val}
                        <tr>
                            <td>{if $val['demand_status'] ==0}未处理{/if}
                                {if $val['demand_status'] ==5}测试{/if}
                                {if $val['demand_status'] ==-1}已放弃{/if}
                                {if $val['demand_status'] ==-2}重复{/if}
                                {if $val['demand_status'] ==-3}自动放弃{/if}
                                {if $val['demand_status'] ==1}已处理{/if}
                            </td>
                            <td>{Date('Y-m-d H:i:s',$val['create_time'])}</td>
                            <td>{if $val['person_liable']}{$val['person_liable']['fullname']}{else}没有负责人{/if}</td>
                            <td>{$val['demand']['联系人']}</td>
                            <td>{$val['city']}</td>
                            <td>{$val['demand_name']}</td>
                            <td>{$val['demand_type']}</td>
                            <td>{$val['price_up']}至{$val['price_down']}</td>
                            <td>{if $val['demand']['product_id']}
                                    <p><a target="_blank"
                                          href="{$_root}service_info/{$val['demand']['product_id']}.html">点此查看产品链接</a>
                                    </p>
                                {/if}
                                {if $val['demand']['set_id']}
                                    <p><a target="_blank"
                                          href="{$_root}set_info/{$val['demand']['set_id']}.html">点此查看产品链接</a>
                                    </p>
                                {/if}

                                {if $val['demand']['vendor_id']}
                                    <p><a target="_blank"
                                          href="{$_root}vendor_info/{$val['demand']['vendor_id']}.html">点此查看详情</a>
                                    </p>
                                {/if}
                                <p>{$val['demand']['具体要求']}</p>
                            </td>
                            <td>
                                <a href="#show-reason_{$val['id']}" data-toggle="modal" class="btn btn-success">查看其它信息</a>
                                <div class="modal fade" id="show-reason_{$val['id']}" tabindex="-1" role="basic" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                {foreach $val['demand'] as $k=>$v}
                                                    <p>{$k}：&nbsp;&nbsp;&nbsp;{$v}</p>
                                                {/foreach}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>

                    {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
        {else}
        <div class="container-fluid">
            <div class="row">
                没有最近需求
            </div>
        </div>
        {/if}
    </div>