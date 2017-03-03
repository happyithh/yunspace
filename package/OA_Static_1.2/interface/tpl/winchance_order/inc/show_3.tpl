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
                    <a href="javascript:;" class="collapse"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step1" style="display: block">
                <form action="?action=edit_submit" class="form_add_step4" method="post">
                    <div class="form-body">
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">协议内容制定</label>
                            <div class="col-md-4 col-xs-6">
                               已完成
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">授权资质</label>
                            <div class="col-md-4 col-xs-6">
                               已完成
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">对方法务审核</label>
                            <div class="col-md-4 col-xs-6">
                                已完成
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">协议发回</label>
                            <div class="col-md-4 col-xs-6">
                               已完成
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">签订完成</label>
                            <div class="col-md-4 col-xs-6">
                               已完成
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">协议附件</label>
                            <div class="col-md-4 col-xs-6">
                               {foreach $data['agreement_files'] as $k=>$v}
                                   <a href="{$v['path']}">{$v['name']}</a><br/>
                               {/foreach}
                            </div>
                        </div>
                        {include "OA_Static::winchance_order/inc/log.tpl"}
                    </div>

                    <input type="hidden" name="step" value="4">
                    <input type="hidden" name="id" value="{$data['id']}">
                    <input type="hidden" class="confirm_step" name="confirm_step" value="">
                    {if $data['status']<1}
                        <div class="form-actions" >
                            <div style="float: left;margin-left: 50px;"> <a href="javascript:;" class="show-modal-a cancel_order3"  data-value="{$data['id']}">取消订单</a></div>
                            <div style="float:left;margin-left: 200px;">
                                <button type="button" class="btn btn-info save_data_step4" >保存</button>
                                <button type="button" class="btn btn-success complete_data_step4" style="margin-left: 80px;">活动结束，完成订单</button>
                                {*<a class="btn btn-success show-modal show-modal-a" data-toggle="modal" href="#modal-two" data-title="a" data-text="b"   data-url="c">完成此阶段</a>*}
                            </div>
                        </div>
                    {else}
                        <div class="form-actions" >
                            <div style="float:left;margin-left: 200px;">
                                <div class="alert alert-success">
                                    <strong>订单已完成!</strong>
                                </div>
                            </div>
                        </div>
                    {/if}
                </form>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $('.save_data_step4').click(function(){
            $('.form_add_step4').submit();
        });
        $('.complete_data_step4').click(function(){
            var r=confirm("确认该订单的活动已经结束 结束此订单？");
            if(r){
                $('.confirm_step').val(1);
                $('.form_add_step4').submit();
            }else{
                return false;
            }
        });
        $('.cancel_order3').click(function(){
            var r=confirm("请确认场地方已经终止了意向，订单无法继续订单取消后不可恢复，请慎重选择？");
            if(r){
                var order_id = $(this).attr('data-value');
                location.href="?action=cancel&order_id="+order_id;
            }else{
                return false;
            }
        });
    });
</script>