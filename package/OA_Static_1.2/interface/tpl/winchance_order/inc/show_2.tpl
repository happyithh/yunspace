<style>
    .ps p{
        font-size:13px;
        color:#666;
    }
</style>
<div class="row">
    <div class="col-md-12">
        <!-- BEGIN ALERTS PORTLET-->
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-cogs"></i>第2阶段：明确需求
                </div>
                <div class="tools">
                    <a href="javascript:;" class="collapse"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step1" style="display: block">

                    <div class="form-body">
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">最终确认IP</label>
                            <div class="col-md-4 col-xs-6">
                               {$data['final_ip']}
                            </div>
                        </div>
                        {if count($data['ip_info'])>1}
                        <div class="form-group clearfix">
                            <div class="portlet-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                        <tr>
                                            <th width="10%">
                                                未使用IP
                                            </th>
                                            <th width="10%">
                                                备注
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {if $data['ip_info']}
                                            {foreach $data['ip_info'] as $k=>$v}
                                                {if $v['name']!=$data['final_ip']}
                                                <tr>
                                                    <td>
                                                        {$v['name']}
                                                    </td>
                                                    <td>
                                                      {$v['remarks']}
                                                    </td>
                                                </tr>
                                                {/if}
                                            {/foreach}
                                        {/if}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        {/if}
                    </div>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>

