<div class="row">
    <div class="col-md-12">
        <!-- BEGIN ALERTS PORTLET-->
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-cogs"></i>储备信息
                </div>
                <div class="tools">
                    <a href="javascript:;" class="collapse"></a>
                </div>
            </div>
            <div class="portlet-body form" style="display: {if $step==1}block{else}none{/if}">
                <input type="hidden" name="company" placeholder="请选择IP品牌" value="{$data['company']}" class="hidden-company">
                <input type="hidden" name="figure" placeholder="请选择IP人物形象" value="{$data['figure']}" class="hidden-figure">
                <div class="form-body">
                    <div class="form-group clearfix company-name">
                        <label class="col-md-2 control-label col-xs-2">IP品牌</label>
                        <div class="col-md-4 col-xs-4">
                            <div class="form-control" id="brand" data-url="http://{Core::$urls['host']}/static/api/winchance/new/company/auto/complete.jsonp">
                                <input type="text" name="company" placeholder="请选择IP品牌" value="{$data['company']}" >
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix figure-name">
                        <label class="col-md-2 control-label col-xs-2">IP形象</label>
                        <div class="col-md-4 col-xs-4">
                            <div class="form-control" id="figure" data-url="http://{Core::$urls['host']}/static/api/winchance/new/figure/auto/complete.jsonp">
                                <input type="text" name="figure" placeholder="请选择IP人物形象" value="{$data['figure']}">
                            </div>
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">IP名称</label>

                        <div class="col-md-4 col-xs-4">
                            <input type="text" name="ip_name" class="form-control " placeholder="请输入IP名称" required value="{$data['ip_name']}">
                        </div>
                    </div>
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">来源国家</label>
                        <div class="col-md-10  col-xs-10">
                            <div class="radio-list">
                                {foreach $country as $k=>$v}
                                    <label class="radio-inline">
                                        <input type="radio" name="country" value="{$v}"{if !isset($data) && $v=='中国'}checked{elseif $data['country']==$v}checked{/if}>
                                        {$v}
                                    </label>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                    {if $step==1}
                    <div class="form-group clearfix">
                        <label class="col-md-2 control-label col-xs-2">备注</label>
                        <div class="col-md-4  col-xs-4">
                            <textarea class="form-control" name="note" rows="10"
                                      placeholder="此处可以输入关于此IP的备注信息，1000字以内">{$data['note']}</textarea>
                        </div>
                    </div>
                    {/if}
                </div>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>