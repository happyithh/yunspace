<div class="row">
    <div class="col-md-12">
        <!-- BEGIN ALERTS PORTLET-->
        <div class="portlet">
            <div class="portlet-title drop-step">
                <div class="caption">
                    <i class="fa fa-cogs"></i>拜访或电话
                </div>
                <div class="tools">
                    <a href="javascript:;" class="{if $step==3}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou" id="step3" style="display: {if $step==3}block{else}none{/if}">
                <form action="?action=dataSubmit" class="submit-add-three" method="post">
                    <input type="hidden" name="step" value="3">
                    <input type="hidden" name="id" value="{$data['id']}">
                    <input type="hidden" name="admin_id" value="{$data['admin_id']}">
                    <input type="hidden" name="submit_type" value="">
                    {******审核列表搜索时使用到的字段***开始****}
                    <input type="hidden" name="ip_name" value="{$data['ip_name']}">
                    <input type="hidden" name="conform_crowd" value="{$data['conform_crowd']}">
                    <input type="hidden" name="category" value="{$data['category']}">
                    <input type="hidden" name="cooperating_mode" value="{$data['cooperating_mode']}">
                    {******审核列表搜索时使用到的字段***结束****}
                    <div class="form-body">
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">授权代理公司</label>

                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="agent[授权代理公司]" class=" form-control " placeholder="请填写授权代理公司" value="{$data['agent']['授权代理公司']}" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">联系人</label>

                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="agent[联系人]" class=" form-control " placeholder="请填写联系人" value="{$data['agent']['联系人']}" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">职务</label>

                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="agent[职务]" class=" form-control " placeholder="请填写职务" value="{$data['agent']['职务']}" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">电话</label>

                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="agent[电话]" class=" form-control " placeholder="请填写电话" value="{$data['agent']['电话']}" required >
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">邮箱</label>

                            <div class="col-md-4 col-xs-6">
                                <input type="email" name="agent[邮箱]"
                                       class=" form-control " placeholder="请填写邮箱" value="{$data['agent']['邮箱']}" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">运营范围</label>
                            <div class="col-md-10  col-xs-10">
                                <div class="checkbox-list">
                                    <label class="checkbox-inline">
                                    {foreach $city as $k=>$v}
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="city[]" id="optionsRadios4"
                                                   value="{$v}" {if strstr($data['city'],$v)}checked{/if}>
                                            {$v} </label>
                                    {/foreach}

                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">IP年龄（年）</label>
                            <div class="col-md-2 col-xs-4">
                                <div class="input-group">
                                    <input type="text" name="ip_age" class="form-control" required  value="{$data['ip_age']}">
											<span class="input-group-addon">
											<span class="">年</span>
											</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">表现形式</label>
                            <div class="col-md-10  col-xs-10">
                                <div class="radio-list">
                                    {foreach $manifestation as $k=>$v}
                                        <label class="radio-inline">
                                            <input type="radio" name="manifestation" id="optionsRadios4"
                                                   value="{$v}"{if $data['manifestation']==$v || (empty($data['manifestation']) && $k==0)}checked{/if}>
                                            {$v} </label>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">授权期限（月）</label>
                            <div class="col-md-2 col-xs-4">
                                <div class="input-group">
                                    <input type="text" name="mandate_expire" value="{$data['mandate_expire']}" class="form-control mandate_expire" required min="0">
											<span class="input-group-addon">
											<span class="">月</span>
											</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">场地面积</label>
                            <div class="col-md-4 col-xs-6 clearfix">
                                <div class="input-group pull-left col-md-5 col-xs-5">
                                    <input type="text" class="form-control" name="min_area" value="{$data['min_area']}" required min="0">
											<span class="input-group-addon">
											<span class="">m<sup>2</sup></span>
											</span>
                                </div>
                                <div class="col-md-2 col-xs-2" style="line-height:34px;text-align: center">—</div>
                                <div class="input-group pull-left col-md-5 col-xs-5" required min="0">
                                    <input type="text" class="form-control" name="max_area" value="{$data['max_area']}" >
											<span class="input-group-addon">
											<span class="">m<sup>2</sup></span>
											</span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">备注</label>
                            <div class="col-md-4 col-xs-6">
                                <textarea id="draft_add_three" name="note" class="form-control" rows="10"  placeholder="此处可以输入关于此IP的备注信息，1000字以内">{$data['note']}</textarea>
                            </div>
                        </div>
                    </div>
                    {if $step>=3}
                    <div class="form-actions">
                        <button type="button" data-re-url="{$_home}winchance_new/winchance_list?action=list" class="btn btn-info draft_submit_three">保存</button>
                        <button type="button" class="btn btn-success add-three">提交审核</button>
                    </div>
                    {/if}
                </form>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>
<script>
    $(".add-three").click(function(){
        if(confirm('确定【拜访或电话】已填写完整并提交到审核阶段吗？   注：此阶段审核通过后才可以进行下一步操作哦！')){
            $(".submit-add-three").submit();
        }else{
            return false;
        }
    });
    $(".draft_submit_three").click(function () {
        $("input[name='submit_type']").val('draft');
        $(".submit-add-three").submit();
    });
</script>