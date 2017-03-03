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
                    <a href="javascript:;" class="{if $data['step']==0}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step1" style="display: {if $data['step']==0}block{else}none{/if}">
                <form action="?action=edit_submit" class="form_add_step1" method="post">
                    <input type="hidden" name="step" value="1">
                    <input type="hidden" name="id" value="{$data['id']}">
                    <input type="hidden" class="confirm_step" name="confirm_step" value="">
                    <div class="form-body">
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">场地</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="space_name" class="form-control " placeholder="请填写场地名" required value="{$data['space_name']}">
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">城市</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="city" class="form-control " placeholder="请填写城市" required value="{$data['city']}">
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">联系人</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="contact_name" class="form-control " placeholder="请填写联系人姓名" required value="{$data['contact_name']}">
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">联系方式</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="contact_phone" class="form-control " placeholder="联系人的联系方式，电话、邮箱等" required value="{$data['contact_phone']}">
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">所在区域</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="regions" class="form-control " placeholder="请填写所在区域，如室内、室外，20字以内" required value="{$data['regions']}">
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">所需点位</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="need_point" class="form-control " placeholder="请填写所需点位，如一层中厅、二层、三层，50字以内"" required value="{$data['need_point']}">
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">所需面积</label>
                            <div class="col-md-4 col-xs-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="need_area" required="" value="{$data['need_area']}" placeholder="请填写所需面积的数字，注意面积单位为㎡">
											<span class="input-group-addon">
											<span class="">m<sup>2</sup></span>
											</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">活动时间</label>
                            <div class="col-md-4 col-xs-6">
                                <div class="input-group input-large date-picker input-daterange" data-date="10/11/2012" data-date-format="mm/dd/yyyy">
                                    <input type="text" class="form-control date" name="active_start_time"  value="{$data['active_start_time']}" readonly="" placeholder="开始时间">
												<span class="input-group-addon">
												--</span>
                                    <input type="text" class="form-control date" name="active_end_time" value="{$data['active_end_time']}"  readonly="" placeholder="结束时间">
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">活动主题</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="active_name" class="form-control " placeholder="请填写活动主题，例如圣诞节冰雪主题；星球大战…50字内"" required value="{$data['active_name']}">
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">推广预算</label>
                            <div class="col-md-4 col-xs-4">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="budget" value="{$data['budget']}" required="" placeholder="请填写预算数字，注意预算单位是万元" >
											<span class="input-group-addon">
											<span class="">万元</span>
											</span>
                                </div>
                            </div>
                        </div>
                        {include "OA_Static::winchance_order/inc/log.tpl"}
                        {*<div class="portlet-body">*}
                            {*<ul class="nav nav-tabs">*}
                                {*<li class="active">*}
                                    {*<a href="#tab_1_1" data-toggle="tab">工作日志（请查看订单日志）</a>*}
                                {*</li>*}
                            {*</ul>*}
                            {*<div class="tab-pane fade active in" id="tab_1_1">*}

                                {*{if $log_data}*}
                                     {*{foreach $log_data as $k=>$v}*}
                                            {*{if $k==$weeks['week_num']}*}
                                                {*<div class="form-group clearfix">*}
                                                    {*<label class="col-md-2 control-label col-xs-2" id="current-week">{$weeks['week_num']}计划<br/>（{$weeks['start']}--{$weeks['end']}）</label>*}
                                                    {*<div class="col-md-4 col-xs-6">*}
                                                        {*<textarea class="form-control" name="log_data[{$weeks['week_num']}][plan]" rows="10" placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字"  maxlength="1000">{$v['plan']}</textarea>*}
                                                    {*</div>*}
                                                {*</div>*}
                                                {*<div class="form-group clearfix">*}
                                                    {*<label class="col-md-2 control-label col-xs-2" id="current-week">{$weeks['week_num']}小结<br/>（{$weeks['start']}--{$weeks['end']}）</label>*}
                                                    {*<div class="col-md-4 col-xs-6">*}
                                                        {*<textarea class="form-control" name="log_data[{$weeks['week_num']}][summary]" rows="10" placeholder="请填写本周小结，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000">{$v['summary']}</textarea>*}
                                                    {*</div>*}
                                                {*</div>*}
                                                {*<input type="hidden" name="log_data[{$weeks['week_num']}][s_e]" value="{$weeks['start']}--{$weeks['end']}">*}
                                            {*{else}*}
                                                {*<div class="form-group clearfix">*}
                                                    {*<label class="col-md-2 control-label col-xs-2" id="current-week">{$k}计划<br/>（{$v['s_e']}）</label>*}
                                                    {*<div class="col-md-4 col-xs-6">*}
                                                        {*<textarea class="form-control"  rows="10" readonly placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字"  maxlength="1000">{$v['plan']}</textarea>*}
                                                    {*</div>*}
                                                {*</div>*}
                                                {*<div class="form-group clearfix">*}
                                                    {*<label class="col-md-2 control-label col-xs-2" id="current-week">{$k}小结<br/>（{$v['s_e']}）</label>*}
                                                    {*<div class="col-md-4 col-xs-6">*}
                                                        {*<textarea class="form-control"  rows="10" readonly placeholder="请填写本周小结，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000">{$v['summary']}</textarea>*}
                                                    {*</div>*}
                                                {*</div>*}
                                            {*{/if}*}
                                     {*{/foreach}*}
                                {*{else}*}
                                    {*<div class="form-group clearfix">*}
                                        {*<label class="col-md-2 control-label col-xs-2" id="current-week">{$weeks['week_num']}计划<br/>（{$weeks['start']}--{$weeks['end']}）</label>*}
                                        {*<div class="col-md-4 col-xs-6">*}
                                            {*<textarea class="form-control" name="log_data[{$weeks['week_num']}][plan]" rows="10" placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字"  maxlength="1000">{$data['note']}</textarea>*}
                                        {*</div>*}
                                    {*</div>*}
                                    {*<div class="form-group clearfix">*}
                                        {*<label class="col-md-2 control-label col-xs-2" id="current-week">{$weeks['week_num']}小结<br/>（{$weeks['start']}--{$weeks['end']}）</label>*}
                                        {*<div class="col-md-4 col-xs-6">*}
                                            {*<textarea class="form-control" name="log_data[{$weeks['week_num']}][summary]" rows="10" placeholder="请填写本周小结，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000">{$data['note']}</textarea>*}
                                        {*</div>*}
                                    {*</div>*}
                                    {*<input type="hidden" name="log_data[{$weeks['week_num']}][s_e]" value="{$weeks['start']}--{$weeks['end']}">*}
                                {*{/if}*}
                                {*<div class="form-group clearfix">*}
                                    {*<div class="col-md-6 col-xs-8 ps">*}
                                        {*<p>说明：</p>*}
                                        {*<p>1、周小结与计划请在周日23:59前完成，周一00:00系统会自动将小结跳转到下一周；</p>*}
                                        {*<p>2、周小结与计划可以修改在每周跳转前可以在修改。</p>*}
                                    {*</div>*}
                                {*</div>*}
                            {*</div>*}

                            {*<div class="form-group clearfix">*}
                            {*<label class="col-md-2 control-label col-xs-2" id="next-week">备注</label>*}
                            {*<div class="col-md-4 col-xs-6">*}
                            {*<textarea class="form-control" name="note"  rows="10" placeholder="此处可以输入关于此IP的备注信息，1000字以内"  maxlength="1000" >{$data['note']}</textarea>*}
                            {*</div>*}
                            {*</div>*}
                        {*</div>*}
                        {*<div class="form-group clearfix">*}
                            {*<label class="col-md-2 control-label col-xs-2" id="next-week">备注</label>*}
                            {*<div class="col-md-4 col-xs-6">*}
                                {*<textarea class="form-control" name="remarks"  rows="10" placeholder="此处可以输入关于此订单的备注信息，1000字以内"  maxlength="1000" >{$data['remarks']}</textarea>*}
                            {*</div>*}
                        {*</div>*}

                    </div>
                    <div class="form-actions" >
                        <div style="float: left;margin-left: 50px;"> <a href="javascript:;" class="show-modal-a cancel_order"  data-value="{$data['id']}">取消订单</a></div>
                        <div style="float:left;margin-left: 200px;">
                            <button type="button" class="btn btn-info save_data" >保存</button>
                            <button type="button" class="btn btn-success complete_data" style="margin-left: 80px;">完成此阶段</button>
                            {*<a class="btn btn-success show-modal show-modal-a" data-toggle="modal" href="#modal-two" data-title="a" data-text="b"   data-url="c">完成此阶段</a>*}
                        </div>
                    </div>
                </form>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $('.save_data').click(function(){
            $('.form_add_step1').submit();
        });
        $('.complete_data').click(function(){
            var r=confirm("确认该订单的“了解需求”阶段已经完成进入到“明确需求”阶段？");
            if(r){
                $('.confirm_step').val(1);
                $('.form_add_step1').submit();
            }else{
                return false;
            }
        });
    });
</script>
