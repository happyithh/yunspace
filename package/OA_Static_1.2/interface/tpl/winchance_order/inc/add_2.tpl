<script>
    $(document).ready(function(){

           $(".add-pre-IP").find(".select2-chosen").text("请输入意向");

        if($(".add-pre-IP").find(".select2-chosen").text()=="请输入意向"){
            $(".add-pre-IP").find(".select2-chosen").css("color","#909090");
        }
        $('#pre_ip').on('change',function(){
            $("#s2id_pre_ip").find('.select2-chosen').css("color","#222");
        });
    });
</script>
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
                    <a href="javascript:;" class="{if $data['step']==1}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step1" style="display: {if $data['step']==1}block{else}none{/if}">
                <form action="?action=edit_submit" class="form_add_step2" method="post">
                    <input type="hidden" name="step" value="2">
                    <input type="hidden" name="id" value="{$data['id']}">
                    <input type="hidden" class="confirm_step" name="confirm_step" value="">
                    <input type="hidden" name="final_ip" id="final_ip" value="{$data['final_ip']}"/>
                    <div class="form-body">
                        {*{if !$data['final_ip']}*}
                        <div class="form-group clearfix add-pre-IP">
                            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">添加意向</label>
                            <div class="col-md-6 col-xs-6">
                                <div class="form-control" id="pre_ip" data-url="http://{Core::$urls['host']}/static/api/winchance/new/ip/list/for/order.jsonp">
                                    <input type="text" name="ip_name" placeholder="请选择IP品牌" value="" >
                                </div>
                            </div>

                            <div class="col-md-2 col-xs-4">
                                <button class="btn btn-info" id="add-pre-ip" type="button">添加到意向IP</button>
                            </div>
                        </div>
                        {*{/if}*}
                        <div id="all-IP" class="col-md-12">
                            {if $data['ip_info']}
                                {foreach $data['ip_info'] as $k=>$v}
                                    <div class="form-group clearfix ip_num col-md-12">
                                        <input type="hidden" name="ip_info[{$k}][name]" value="{$v['name']}">
                                        <label class="col-md-1 control-label col-xs-2">意向IP{$k}</label>
                                        <div class="col-md-3 col-xs-4">
                                            <div class="alert alert-success title" style="padding:7px;">{$v['name']}{if $data['final_ip']&&$v['name']==$data['final_ip']}<code style="float: right">最终IP</code>{/if}</div>
                                        </div>
                                        {if !$data['final_ip']}
                                            <div class="col-md-1 col-xs-3">
                                                <button class="btn btn-success show-modal show-modal-btn2" type="button" data-value="{$v['name']}" data-toggle="modal" data-title="确认最终IP" data-text="确认选择{$v['name']}作为该订单的最终IP吗？选择后不可更改哦！">
                                                    选为最终IP
                                                </button>
                                            </div>
                                        {/if}
                                        <div class="col-md-2 col-xs-6" style="margin-left: 25px;">
                                            <input type="text" name="ip_info[{$k}][remarks]" class="form-control " placeholder="这里可以填写此IP的备注" value="{$v['remarks']}">
                                        </div>
                                    </div>
                                {/foreach}
                            {/if}
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
                                    {*<textarea class="form-control" name="remarks"  rows="10" placeholder="此处可以输入关于此IP的备注信息，1000字以内"  maxlength="1000" >{$data['remarks']}</textarea>*}
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
                            <button type="button" class="btn btn-info save_data_step2" >保存</button>
                            <button type="button" class="btn btn-success complete_data_step2" style="margin-left: 80px;">完成此阶段</button>
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
        $('.save_data_step2').click(function(){
            $('.form_add_step2').submit();
        });
        $('.complete_data_step2').click(function(){
            var r=confirm("确认该订单的“明确需求”阶段已经完成 进入到“合同流程”阶段？");
            if(r){
                $('.confirm_step').val(1);
                $('.form_add_step2').submit();
            }else{
                return false;
            }
        });
    });
</script>