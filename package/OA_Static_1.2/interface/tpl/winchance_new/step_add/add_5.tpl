<div class="row">
    <div class="col-md-12">
        <!-- BEGIN ALERTS PORTLET-->
        <div class="portlet">
            <div class="portlet-title drop-step">
                <div class="caption">
                    <i class="fa fa-cogs"></i>签订协议
                </div>
                <div class="tools">
                    <a href="javascript:;" class="{if $step==5}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou"  id="step5" style="display:{if $step==5}block{else}none{/if}">
                <form action="?action=dataSubmit" class="submit-add-five" method="post">
                    <input type="hidden" name="step" value="5">
                    <input type="hidden" name="id" value="{$data['id']}">
                    <input type="hidden" name="admin_id" value="{$data['admin_id']}">
                    <input type="hidden" name="submit_type" value="">
                    {******审核列表搜索时使用到的字段***开始****}
                    <input type="hidden" name="ip_name" value="{$data['ip_name']}">
                    <input type="hidden" name="conform_crowd" value="{$data['conform_crowd']}">
                    <input type="hidden" name="category" value="{$data['category']}">
                    <input type="hidden" name="city" value="{$data['city']}">
                    <input type="hidden" name="manifestation" value="{$data['manifestation']}">
                    <input type="hidden" name="min_area" value="{$data['min_area']}">
                    <input type="hidden" name="max_area" value="{$data['max_area']}">
                    <input type="hidden" name="cooperating_mode" value="{$data['cooperating_mode']}">
                    {******审核列表搜索时使用到的字段***结束****}
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
                                <textarea class="form-control" id="draft_add_five" name="note" rows="10"  placeholder="此处可以输入关于此IP的备注信息，1000字以内">{$data['note']}</textarea>
                            </div>
                        </div>
                    </div>
                    {if $step==5}
                    <div class="form-actions">
                        <button type="button" data-re-url="{$_home}winchance_new/winchance_list?action=list" class="btn btn-info draft_submit_five">保存</button>
                        <button type="submit" class="btn btn-success add-five">提交审核</button>
                    </div>
                    {/if}
                </form>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>

<script>
    $(".add-five").click(function(){
        if(confirm('确定【签订协议】已填写完整并提交到审核阶段吗？')){
            $(".submit-add-five").submit();
        }else{
            return false;
        }
    });
    $(".draft_submit_five").click(function () {
        $("input[name='submit_type']").val('draft');
        $(".submit-add-five").submit();
    });
</script>