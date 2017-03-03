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
                    <i class="fa fa-cogs"></i>第3阶段：合同流程
                </div>
                <div class="tools">
                    <a href="javascript:;" class="{if $data['step']>=2}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step1" style="display: {if $data['step']==2}block{else}none{/if}">
                <form action="?action=edit_submit" class="form_add_step3" method="post">
                    <input type="hidden" name="step" value="3">
                    <input type="hidden" name="id" value="{$data['id']}">
                    <input type="hidden" class="confirm_step" name="confirm_step" value="">
                    <div class="form-body">
                        <div class="form-group clearfix">
                            <div class="form-group clearfix">
                                <label class="col-md-2 control-label col-xs-2" style="min-width: 150px;">协议内容制定</label>
                                <div class="col-md-4 col-xs-6">
                                    <label><input type="radio" name="protocol_content"  value="1" {if $data['protocol_content']==1}checked="checked"{/if}>已完成</label>
                                    <label> <input type="radio" name="protocol_content"  value="0" {if $data['protocol_content']==0}checked="checked"{/if}>未完成</label>
                                    {*<div class="radio-list">*}
                                        {*<label class="radio-inline">*}
                                            {*<div class="radio" id="uniform-optionsRadios4"><span class=""><input type="radio" name="optionsRadios" id="optionsRadios4" value="1" checked=""></span></div>*}
                                            {*已完成 </label>*}
                                        {*<label class="radio-inline">*}
                                            {*<div class="radio" id="uniform-optionsRadios5"><span class="checked"><input type="radio" name="optionsRadios" id="optionsRadios5" value="0"></span></div> 未完成*}
                                        {*</label>*}
                                    {*</div>*}
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <label class="col-md-2 control-label col-xs-2" style="min-width: 150px;">授权资质</label>
                                <div class="col-md-4 col-xs-6">
                                    <label><input type="radio" name="authorization_qualification"  value="1" {if $data['authorization_qualification']==1}checked="checked"{/if}>已完成</label>
                                    <label> <input type="radio" name="authorization_qualification"  value="0" {if $data['authorization_qualification']==0}checked="checked"{/if}>未完成</label>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <label class="col-md-2 control-label col-xs-2" style="min-width: 150px;">对方法务审核</label>
                                <div class="col-md-4 col-xs-6">
                                    <label><input type="radio" name="legal_audit"  value="1" {if $data['legal_audit']==1}checked="checked"{/if}>已完成</label>
                                    <label> <input type="radio" name="legal_audit"  value="0" {if $data['legal_audit']==0}checked="checked"{/if}>未完成</label>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <label class="col-md-2 control-label col-xs-2" style="min-width: 150px;">协议发回</label>
                                <div class="col-md-4 col-xs-6">
                                    <label><input type="radio" name="protocol_back"  value="1" {if $data['protocol_back']==1}checked="checked"{/if}>已完成</label>
                                    <label> <input type="radio" name="protocol_back"  value="0" {if $data['protocol_back']==0}checked="checked"{/if}>未完成</label>
                                </div>
                            </div>
                            <div class="form-group clearfix">
                                <label class="col-md-2 control-label col-xs-2" style="min-width: 150px;">签订完成</label>
                                <div class="col-md-4 col-xs-6">
                                    <label><input type="radio" name="sign_completion"  value="1" {if $data['sign_completion']==1}checked="checked"{/if}>已完成</label>
                                    <label> <input type="radio" name="sign_completion"  value="0" {if $data['sign_completion']==0}checked="checked"{/if}>未完成</label>
                                </div>
                            </div>
                            {include file="winchance_order/inc/public_upload_order.tpl"}
                            {*<label class="col-md-2 control-label col-xs-2">添加意向</label>*}
                            {*<div class="col-md-4 col-xs-6">*}
                                {*<div class="form-control" id="pre_ip" data-url="http://{Core::$urls['host']}/static/api/winchance/new/company/auto/complete.jsonp">*}
                                    {*<input type="text" name="company" placeholder="请选择IP品牌" value="{$data['company']}" >*}
                                {*</div>*}
                            {*</div>*}
                            {*<div class="col-md-2 col-xs-4">*}
                                {*<button class="btn btn-info" id="add-pre-ip" type="button">添加到意向IP</button>*}
                            {*</div>*}
                        </div>
                        {include "OA_Static::winchance_order/inc/log.tpl"}
                        {*<div class="portlet-body">*}
                            {*<ul class="nav nav-tabs">*}
                                {*<li class="active">*}
                                    {*<a href="#tab_1_1" data-toggle="tab">工作日志（请查看订单日志）</a>*}
                                {*</li>*}
                            {*</ul>*}
                            {*<div class="tab-pane fade active in" id="tab_1_1">*}
                                {*<div class="form-group clearfix">*}
                                    {*<label class="col-md-2 control-label col-xs-2" id="current-week">2016年第16周计划（4/18-4/24）</label>*}
                                    {*<div class="col-md-4 col-xs-6">*}
                                        {*<textarea class="form-control" name="note"  rows="10" placeholder="此处只展示上周写的计划，不可修改，只做展示，第一周时不展示" readonly maxlength="1000">{$data['note']}</textarea>*}
                                    {*</div>*}
                                {*</div>*}
                                {*<div class="form-group clearfix">*}
                                    {*<label class="col-md-2 control-label col-xs-2" id="current-week">2016年第16周小结（4/18-4/24）</label>*}
                                    {*<div class="col-md-4 col-xs-6">*}
                                        {*<textarea class="form-control" name="note"  rows="10" placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000">{$data['note']}</textarea>*}
                                    {*</div>*}
                                {*</div>*}
                                {*<div class="form-group clearfix">*}
                                    {*<label class="col-md-2 control-label col-xs-2" id="next-week">2016年第17周小结（4/25-5/1）</label>*}
                                    {*<div class="col-md-4 col-xs-6">*}
                                        {*<textarea class="form-control" name="note"  rows="10" placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000">{$data['note']}</textarea>*}
                                    {*</div>*}
                                {*</div>*}

                                {*<div class="form-group clearfix">*}
                                    {*<div class="col-md-6 col-xs-8 ps">*}
                                        {*<p>说明：</p>*}
                                        {*<p>1、周小结与计划请在周日23:59前完成，周一00:00系统会自动将小结跳转到下一周；</p>*}
                                        {*<p>2、周小结与计划可以修改在每周跳转钱可以在修改。</p>*}
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
                            {*<div class="col-md-4 col-xs-6">*}
                                {*<a class="btn btn-danger show-modal-a" data-toggle="modal" href="#modal-two">取消订单</a>*}
                            {*</div>*}
                        {*</div>*}
                    </div>
                    <div class="form-actions" >
                        <div style="float: left;margin-left: 50px;"> <a href="javascript:;" class="show-modal-a cancel_order"  data-value="{$data['id']}">取消订单</a></div>
                        <div style="float:left;margin-left: 200px;">
                            <button type="button" class="btn btn-info save_data_step3" >保存</button>
                            <button type="button" class="btn btn-success complete_data_step3" style="margin-left: 80px;">完成此阶段</button>
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
        $('.save_data_step3').click(function(){
            $('.form_add_step3').submit();
        });
        $('.complete_data_step3').click(function(){
            var r=confirm("确认该订单的“合同流程”阶段已经完成进入到“签约完成、活动待进行”阶段？");
            if(r){
                $('.confirm_step').val(1);
                $('.form_add_step3').submit();
            }else{
                return false;
            }
        });
    });
</script>
