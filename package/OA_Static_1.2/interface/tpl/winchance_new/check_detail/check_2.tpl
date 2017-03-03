<div class="row">
    <div class="col-md-12">
        <!-- BEGIN ALERTS PORTLET-->
        <div class="portlet">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-cogs"></i>审核上线信息
                </div>
                <div class="tools">
                    <a href="javascript:;" class="{if $step==2}collapse{else}expand{/if}"></a>
                </div>
            </div>
            <div class="portlet-body form shou"  id="step2" style="display:{if $step==2}block{else}none{/if}">
                    <div class="form-body">
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">上线活动名称</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="active_name" class=" form-control " value="{$data['active_name']}" placeholder="请填写上线名称" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">一句介绍简介</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="ip_des" class=" form-control " value="{$data['ip_des']}" placeholder="概括ip的一句话不超过100字" required>
                            </div>
                            <div class="col-md-3 col-xs-3">
                                <span style="color:red">100字之内</span>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">符合人群</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="conform_crowd"  id="persons" class="form-control select2" value="{$data['conform_crowd']}"  required>
                            </div>
                            <div class="col-md-3 col-xs-3">
                                <span style="color:red">写完请按回车确认，可添加多个标签！！</span>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">特色标签</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="feature_tag"  id="feature_tag" class="form-control select2" value="{$data['feature_tag']}"  required>
                            </div>
                            <div class="col-md-3 col-xs-3">
                                <span style="color:red">写完请按回车确认，可添加多个标签！！</span>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">年龄段</label>
                            <div class="col-md-10  col-xs-10">
                                <div class="checkbox-list">
                                   <label class="checkbox-inline">
                                        <input type="checkbox" name="age[]" id="inlineCheckbox2"  value="0-3" {if in_array('0-3',$data['age'])} checked {/if}> 0-3 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="age[]" id="inlineCheckbox2" value="4-6" {if in_array('4-6',$data['age'])} checked {/if}> 4-6 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="age[]" id="inlineCheckbox2" value="7-12" {if in_array('7-12',$data['age'])} checked {/if}> 7-12  </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="age[]" id="inlineCheckbox2" value="13-17" {if in_array('13-17',$data['age'])} checked {/if}> 13-17 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="age[]" id="inlineCheckbox2" value="18-35" {if in_array('18-35',$data['age'])} checked {/if}> 18-35 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="age[]" id="inlineCheckbox2" value="36-45" {if in_array('36-45',$data['age'])} checked {/if}> 36-45 </label>
                                    <label class="checkbox-inline">
                                        <input type="checkbox" name="age[]" id="inlineCheckbox2" value="35以上" {if in_array('35以上',$data['age'])} checked {/if}> 45以上 </label>
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">分类</label>
                            <div class="col-md-10  col-xs-10">
                                <div class="checkbox-list">
                                    {foreach $category as $k=>$v}
                                        <label class="checkbox-inline">
                                            <input type="checkbox" name="category[]" id="inlineCheckbox2" value="{$v}" {if strstr($data['category'],$v)} checked {/if}> {$v} </label>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">预算</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="budget" class=" form-control " value="{$data['budget']}" placeholder="请自己填写完整预算 例如：80000元/天 等 空缺填写：暂无" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">层高</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="storey" class=" form-control " value="{$data['storey']}" placeholder="请自己填写所需层高 空缺填写：暂无" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">室内/室外</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="indoor_outdoor" class=" form-control " value="{$data['indoor_outdoor']}" placeholder="填写IP所需室内还是室外 空缺填写：暂无" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">配套</label>
                            <div class="col-md-4 col-xs-6">
                                <input type="text" name="supporting" class=" form-control " value="{$data['supporting']}" placeholder="请相关的配套设施，服务等 空缺填写：暂无" required>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">封面图片</label>
                            <div class="col-md-4 col-xs-6">
                                {include file="winchance_new/inc/public_upload_img.tpl"}
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">ip简介</label>
                            <div class="col-md-4 col-xs-6">
                                <textarea id="draft_add_two" class="form-control" name="ip_brief_introduction"  rows="10" placeholder="此处可以输入关于此IP的简介，1000字以内">{$data['ip_brief_introduction']}</textarea>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">录入类型</label>
                            <div class="col-md-4 col-xs-6">
                                <select class="form-control" name="online_status">
                                    <option value="0" {if $data['online_status']==0 || !isset($data['online_status'])}selected{/if}>下线</option>
                                    <option value="1" {if $data['online_status']==1}selected{/if} >上线</option>
                                </select>
                            </div>
                            <div class="col-md-3 col-xs-3">
                                <span style="color:red">*请确保信息完整性</span>
                            </div>
                        </div>
                        {if $step==2}
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2">备注</label>
                            <div class="col-md-4 col-xs-6">
                                <textarea class="form-control" name="note"  rows="10" placeholder="此处可以输入关于此IP的备注信息，1000字以内">{$data['note']}</textarea>
                            </div>
                        </div>
                        {/if}
                    </div>
            </div>

        </div>
        <!-- END ALERTS PORTLET-->
    </div>
</div>