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
                    <i class="fa fa-cogs"></i>第1阶段：了解需求
                </div>
                <div class="tools">
                    <a href="javascript:;" class="collapse"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step1" style="display:block">
                    <div class="form-body">
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">场地</label>

                            <div class="col-md-4 col-xs-6">
                                {$data['space_name']}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">城市</label>

                            <div class="col-md-4 col-xs-6">
                                {$data['city']}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">联系人</label>

                            <div class="col-md-4 col-xs-6">
                                {$data['contact_name']}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">联系方式</label>
                            <div class="col-md-4 col-xs-6">
                                {$data['contact_phone']}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">所在区域</label>

                            <div class="col-md-10  col-xs-10">
                                {$data['regions']}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">所需点位</label>
                            <div class="col-md-10  col-xs-10">
                                {$data['need_point']}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">所需面积</label>
                            <div class="col-md-2 col-xs-4">
                                {$data['need_area']}m<sup>2</sup>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">活动时间</label>
                            <div class="col-md-4 col-xs-6">
                                {$data['active_start_time']}-{$data['active_end_time']}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">活动主题</label>
                            <div class="col-md-10  col-xs-10">
                                {$data['active_name']}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">推广预算</label>
                            <div class="col-md-2 col-xs-4">
                                {$data['budget']}万元
                            </div>
                        </div>
                    </div>

            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>

