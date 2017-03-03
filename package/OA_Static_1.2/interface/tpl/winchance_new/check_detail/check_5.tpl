<div class="row">
    <div class="col-md-12">
        <!-- BEGIN ALERTS PORTLET-->
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-cogs"></i>签订协议
                </div>
                <div class="tools">
                    <a href="javascript:;" class="{if $step==5}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou"  id="step5" style="display:{if $step==5}block{else}none{/if}">
                    <div class="form-body">
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">协议内容制定</label>
                            <div class="col-md-4 col-xs-6">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[协议内容制定]" id="optionsRadios4" value="1" {if $data['agreement']['协议内容制定']==1}checked{/if}>
                                        已完成 </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[协议内容制定]" id="optionsRadios5" value="0" {if empty($data['agreement']['协议内容制定'])}checked{/if}> 未完成
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">授权资质</label>
                            <div class="col-md-4 col-xs-6">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[授权资质]" id="optionsRadios4" value="1" {if $data['agreement']['授权资质']==1}checked{/if}>
                                        已完成 </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[授权资质]" id="optionsRadios5" value="0" {if empty($data['agreement']['授权资质'])}checked{/if}> 未完成
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">对方法务审核</label>
                            <div class="col-md-4 col-xs-6">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[对方法务审核]" id="optionsRadios4" value="1" {if $data['agreement']['对方法务审核']==1}checked{/if}>
                                        已完成 </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[对方法务审核]" id="optionsRadios5" value="0" {if empty($data['agreement']['对方法务审核'])}checked{/if}> 未完成
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">协议发回</label>
                            <div class="col-md-4 col-xs-6">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[协议发回]" id="optionsRadios4" value="1" {if $data['agreement']['协议发回']==1}checked{/if}>
                                        已完成 </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[协议发回]" id="optionsRadios5" value="0" {if empty($data['agreement']['协议发回'])}checked{/if}> 未完成
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">签订完成</label>
                            <div class="col-md-4 col-xs-6">
                                <div class="radio-list">
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[签订完成]" id="optionsRadios4" value="1" {if $data['agreement']['签订完成']==1}checked{/if}>
                                        已完成 </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="agreement[签订完成]" id="optionsRadios5" value="0" {if empty($data['agreement']['签订完成'])}checked{/if}> 未完成
                                    </label>
                                </div>
                            </div>
                        </div>
                        {include file="winchance_new/inc/public_upload.tpl"}
                        <div class="form-group clearfix clearfix">
                            <label class="col-md-2 control-label col-xs-2">备注</label>
                            <div class="col-md-4 col-xs-6">
                                <textarea class="form-control" name="note" rows="10"  placeholder="此处可以输入关于此IP的备注信息，1000字以内">{$data['note']}</textarea>
                            </div>
                        </div>
                    </div>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>