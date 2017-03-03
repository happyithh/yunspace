
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>时间表
        </div>
    </div>
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row">
                <table class="table  table table-striped table-bordered table-advance table-hover">
                    <thead>
                    <tr>
                        <td>创建时间：</td>
                        <td>更新时间：</td>
                        <td>接收时间：</td>
                        <td>响应时间：</td>
                    </tr>
                    </thead>
                    <tbody>

                        <tr>
                            <td>{if empty($_demand['create_time'])}
                                {$_demand['create_time']}
                                {else}
                                {Date('Y-m-d H:i:s',$_demand['create_time'])}

                            {/if}</td>
                            <td>{if empty($_demand['update_time'])}
                                {$_demand['update_time']}
                                {else}
                                {Date('Y-m-d H:i:s',$_demand['update_time'])}
                            {/if}</td>
                            <td>
                                {if empty($_demand['resolve_time'])}
                                    {$_demand['resolve_time']}
                                    {else}
                                {Date('Y-m-d H:i:s',$_demand['resolve_time'])}

                            {/if}</td>
                            <td>

                                    {foreach $_demand['response'] as $k => $v}
{$v}
{/foreach}
                            </td>

                        </tr>
                        <div class="modal fade" id="show-reason" tabindex="-1" role="basic" aria-hidden="true">
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

                    </tbody>
                </table>
            </div>
        </div>

    </div>