<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<head>
    {include 'Web_User_Center::inc/html_head.tpl' theme='blue'}
</head>
<body>
{include 'Web_User_Center::inc/header_top.tpl' color='#0b679e'}
<div class="clearfix"></div>
<div class="page-container">
{include 'inc/header_nav.tpl' index=0}

<div class="page-content-wrapper">
<div class="page-content">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title">
    供应商编辑/查看
    {if $vendor_status['status']==1 || $vendor_status['status']==4}
        <a href="{$_route}product_edit?vendor_id={$_data['id']}" class="btn btn-success">添加空间/服务</a>
        <a href="{$_route}set_edit?vendor_id={$_data['id']}" class="btn btn-primary">添加套餐</a>
    {else}
        <a href="javascript::void(0)" onclick="alert('供应商信息审核通过后才能操作~')" class="btn btn-success">添加空间/服务</a>
        <a href="javascript::void(0)" onclick="alert('供应商信息审核通过后才能操作~')" class="btn btn-primary">添加套餐</a>
    {/if}
    {if $_data['status']==2}
        <small class="label label-warning">您在({date('Y-m-d H:i',$_data['update_time'])})提交的修改正在审核中</small>
    {/if}

</h3>
{if $vendor_status['is_first_check']}
    <div class="label label-warning">
        <span style="font-size: 15px;">先完善下供应商、商品信息吧，先把亮点介绍下嘛~</span> <br>
        &nbsp;ps：完善的信息提交审核通过后，信息才能出现在云space哦~
    </div>
{/if}
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
<div class="portlet-body">
    <div>
        <div class="service_content">
            <form action="{$_route}vendor_edit/submit" method="post" enctype="multipart/form-data">
                <input type="hidden" name="url_to" value="{$_REQUEST['url_to']}">
                <input type="hidden" name="vendor_id" value="{$_REQUEST['vendor_id']}">

                <div class="container-fluid">
                    <div class="row form-horizontal">
                        <div class="col-md-12" style=" background-color: #f8f8f8; padding-top: 20px">
                            <div class="form-group">
                                <label class="col-md-2 control-label"><b>供应商名称：</b><span
                                            class="required" aria-required="true">*</span></label>

                                <div class="col-md-7">
                                    <input name="data[vendor_name]" class="form-control input-lg"
                                           placeholder="请输入服务名称" type="text"
                                           value="{$_data['vendor_name']}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">品牌名称</label>

                                <div class="col-md-6 col-sm-12">
                                    <input name="data[base_info][品牌名称]" class="form-control input-lg"
                                           placeholder="请输入品牌名称" type="text"
                                           value="{$_data['base_info']['品牌名称']}">
                                </div>
                            </div>
                            {*<div class="form-group">*}
                            {*<label class="col-md-2 control-label">服务分类</label>*}
                            {*<div class="col-md-6 col-sm-12">*}
                            {*<select multiple="multiple" class="multi-select" name="data[categories_id][]" id="my_multi_select2" data-placeholder="Select...">*}
                            {*{function show_category level=0}*}
                            {*{foreach $_categories[$id] as $k=>$v}*}
                            {*<option value="{$k}" {if in_array($k,$_data['categories_id'])}selected="selected" {/if}>{str_repeat(' . . ', $lv)}*}
                            {*{$k}. {$v}*}
                            {*</option>*}
                            {*{if $_categories[$k]}*}
                            {*{show_category data=$_categories id=$k lv=$lv+1}*}
                            {*{/if}*}
                            {*{/foreach}*}
                            {*{/function}*}
                            {*{show_category data=$_categories id=0 lv=1}*}
                            {*</select>*}
                            {*</div>*}
                            {*</div>*}
                            {foreach $_vendor_attr as $k=>$v}
                                {if $k=='资质认证'}
                                    <input type="hidden" class="form-control" name="data[attr][{$k}]"
                                           value="{$_data['attr'][$k]}">
                                {else}
                                    <div class="form-group">
                                        <label class="col-md-2 control-label">{$k}<span class="required"
                                                                                        aria-required="true">*</span></label>

                                        <div class="col-md-6 col-sm-12">
                                            {if $v}
                                                <input type="text" class="form-control tags_select2"
                                                       name="data[attr][{$k}]"
                                                       value="{$_data['attr'][$k]}"
                                                       data-values="{implode(',',$v)}">
                                            {else}
                                                <input type="text" class="form-control"
                                                       name="data[attr][{$k}]"
                                                       value="{$_data['attr'][$k]}">
                                            {/if}
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                            <div class="form-group">
                                <label class="col-md-2 control-label">业务性质</label>

                                <div class="col-md-6 col-sm-12">
                                    <textarea class="form-control" rows="3"
                                              name="data[base_info][业务性质]">{$_data['base_info']['业务性质']}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">业务范围</label>

                                <div class="col-md-6 col-sm-12">
                                    <textarea class="form-control" rows="3"
                                              name="data[base_info][业务范围]">{$_data['base_info']['业务范围']}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">团队简介</label>

                                <div class="col-md-6 col-sm-12">
                                    <textarea class="form-control" rows="3"
                                              name="data[base_info][团队简介]">{$_data['base_info']['团队简介']}</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">供应商介绍<span class="required"
                                                                                 aria-required="true">*</span></label>

                                <div class="col-md-6 col-sm-12">
                                    {include "Admin::inc/html_umeditor.tpl" name="data[des]" value=$_data['des'] height=200}
                                    {*<textarea name="data[des]" class="form-control wysihtml5" rows="5">{$_data['des']}</textarea>*}
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-2 control-label">公司LOGO</label>

                                <div class="col-md-6 col-sm-12">
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="fileinput-new thumbnail"
                                             style="width: 200px; height: 150px;">
                                            {if $_data['logo']}
                                                <img src="{$_data['logo']}" alt=""/>
                                            {else}
                                                <img src="http://www.placehold.it/200x150/EFEFEF/AAAAAA&amp;text=no+image"
                                                     alt=""/>
                                            {/if}
                                        </div>
                                        <div class="fileinput-preview fileinput-exists thumbnail"
                                             style="max-width: 200px; max-height: 150px;"></div>
                                        <div>
                        <span class="btn btn-default btn-file">
                            <span class="fileinput-new">选择图片</span>
                            <span class="fileinput-exists">重新选择</span>
                            <input type="file" name="公司LOGO" accept="image/jpeg,image/png,image/gif">
                        </span>
                                            <a href="form_component.html#"
                                               class="btn btn-danger fileinput-exists"
                                               data-dismiss="fileinput">移除</a>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-6">
                            <h5><b>空间场地</b>
                            </h5>
                            <table class="table table-striped table-bordered table-advance table-hover table-service">
                                <thead>
                                <tr>
                                    <th>
                                        空间场地名称
                                    </th>
                                    <th style="text-align: center;">
                                        <i class="fa fa-plus"></i>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $productInfo as $pk=>$pv}
                                    <tr>
                                        <td colspan="2">{$pv['product_name']}</td>

                                        {*<td class="table_service_list"><i class="fa fa-minus"></i></td>*}
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-6">
                            <h5><b>配套服务</b>
                            </h5>
                            <table class="table table-striped table-bordered table-advance table-hover table-service">
                                <thead>
                                <tr>
                                    <th>
                                        配套服务名称
                                    </th>
                                    <th style="text-align: center;">
                                        <i class="fa fa-plus"></i>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $serviceInfo as $ck=>$cv}
                                    <tr>
                                        <td colspan="2">{$cv['product_name']}</td>

                                        {*<td class="table_service_list"><i class="fa fa-minus"></i></td>*}
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>


                    </div>
                </div>
                <div class="form-actions text-center">
                    <button type="reset" class="btn btn-default">
                        重置
                    </button>
                    <button type="submit" class="btn btn-success">
                        提交
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- END BUTTONS PORTLET-->
</div>
</div>


</div>
</div>
</div>
{include 'Web_User_Center::inc/footer_inbox.tpl'}
{include 'Web_User_Center::inc/footer_script.tpl'}
{include 'Web_User_Center::inc/html_form.tpl'}
<script>
    jQuery(document).ready(function () {
        $('.tags').tagsInput({
            width: 'auto'
        });
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
        $('#my_multi_select2').multiSelect({
            selectableOptgroup: true
        });
        $('.wysihtml5').wysihtml5();
    });
</script>


</body>
</html>