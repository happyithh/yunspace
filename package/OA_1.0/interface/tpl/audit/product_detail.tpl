<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<!-- BEGIN PAGE HEADER-->
<h3 class="page-title" style="float: left;">
   产品信息介绍页
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
<div class="portlet-body">
<div>
<div class="service_content">
<div class="container-fluid">
    <div class="row form-horizontal">
        <div class="col-md-12" style=" background-color: #f8f8f8; padding-top: 20px">
            <div class="form-group">
                <label class="col-md-2 control-label"><b>产品名称：</b></label>

                <div class="col-md-9">
                    <input class="form-control input-lg"  type="text" value="{$data['product_name']}" disabled>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label"><b>所属供应商：</b></label>

                <div class="col-md-9">
                    <input class="form-control input-lg"  type="text" value="{$data['vendor_name']}" disabled>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label"><b>分类：</b></label>

                <div class="col-md-9">
                    <input class="form-control input-lg"  type="text" value="{$data['category_name']}" disabled>
                </div>
            </div>
            <div class="form-group">
                {foreach $_tags_info as $key=>$value}
                    <label class="control-label col-md-2"><b>{$key}</b></label>
                    <div class="col-md-9">
                        <div class="form-group">
                            <div class="col-md-12">
                                {foreach $value as $ik=>$iv}
                                    <div class="input-group">
                                <span class="input-group-addon">
                                    {$iv['tags_name']}:
                                </span>
                                        <input type="text" class="form-control select2 tags_select2" name="data[attr_new][{$ik}]" value="{$data['attr_new'][{$ik}]}" data-values="{implode(',',$iv['tags_value'])}">
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                {/foreach}
                {*<label class="col-md-2 control-label"><b>服务标准：</b></label>*}
                {*<div class="col-md-9">*}
                    {*{if $data['tags_info']}*}
                        {*{foreach $data['tags_info'] as $key=>$value}*}
                            {*{foreach $_tags_info as $ik=>$iv}*}
                                {*{if $iv['id'] == $key}*}
                                    {*<div class="input-group">*}
                                        {*<span class="input-group-addon">{$_tags_tree[0][$iv['parent_id']]}>{$iv['tags_name']}:</span>*}
                                        {*<input type="text" class="form-control select2 tags_select2" value="{$data['attr_new'][{$iv['id']}]}" disabled>*}
                                    {*</div>*}
                                {*{/if}*}
                            {*{/foreach}*}
                        {*{/foreach}*}
                    {*{/if}*}
                    {*<div id="product_attr">*}
                        {*{if  $data['attr']}*}
                            {*{foreach $data['attr'] as $ak=>$av}*}
                                {*<div class="input-group">*}
                                    {*<span class="input-group-addon">{$ak}:  </span>*}
                                    {*<input class="form-control input-lg"  type="text" value="{$av}" disabled>*}
                                {*</div>*}
                            {*{/foreach}*}
                        {*{/if}*}
                    {*</div>*}
                {*</div>*}
            </div>
                <div class="form-group">
                    <label class="control-label col-md-2"><b>搜索排序优先级</b></label>

                    <div class="col-md-10">
                        <label class="radio-inline">
                            <input type="radio" name="data[order_lv]" value="2" {if $data['order_lv']==2}checked="checked" {/if}>
                            高
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="data[order_lv]" value="1" {if $data['order_lv']==1}checked="checked" {/if}>
                            中
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="data[order_lv]" value="0" {if $data['order_lv']==0}checked="checked" {/if}>
                            低
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="data[order_lv]" value="-1" {if $data['order_lv']==-1}checked="checked" {/if}>
                            低-
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="data[order_lv]" value="-2" {if $data['order_lv']==-2}checked="checked" {/if}>
                            低--
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="data[order_lv]" value="-3" {if $data['order_lv']==-3}checked="checked" {/if}>
                            低---
                        </label>
                    </div>
                </div>
            <div class="form-group">
                <label class="col-md-2 control-label"><b>价格：</b></label>

                <div class="col-md-9">
                    <input class="form-control"  type="text" value="{abs($data['price'])}" disabled>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label"><b>面积：</b></label>

                <div class="col-md-9">
                    <input class="form-control"  type="text" value="{$data['product_size']}" disabled>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label"><b>地址：</b></label>

                <div class="col-md-9">
                    <input class="form-control "  type="text" value="{$data['addr']}" disabled>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label"><b>服务介绍：</b></label>

                <div class="col-md-9 col-sm-12">
                    <textarea disabled name="data[des]" class="form-control" rows="5">{$data['des']}</textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-2 control-label"><b>相关图片/视频：</b></label>

                <div class="col-md-9 col-sm-12">
                    <table class="table table-hover">
                        <thead>
                        <tr>
                            <th width="80">缩略图</th>
                            <th>名称</th>
                            <th width="50%">标签</th>
                        </tr>
                        </thead>
                        <tbody id="upload_files">
                        {foreach $data['media'] as $k=>$v}
                            <tr>
                                <td>
                                    <img src="{$v['path']}" style="height: 80px; width: 80px; ">
                                </td>
                                <td>
                                    <input disabled class="form-control" type="text" name="data[media][{$k}][name]" value="{$v['name']}">
                                </td>
                                <td>
                                    <input disabled class="form-control select2 tags_select3" type="text" name="data[media][{$k}][tags]" value="{$v['tags']}">
                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
            {if $_REQUEST['handle_type']=='reject'}
            <div class="form-group">
                <label class="col-md-2 control-label"><b>拒绝理由：</b></label>

                <div class="col-md-9 col-sm-12">
                    <textarea disabled class="form-control" rows="5">{$data['reject_reason']}</textarea>
                </div>
            </div>
            {/if}
            {if $_REQUEST['handle_type']=='waiting'}
            <form action="?action=refuse&id={$data['id']}" method="post">
                <div class="form-group">
                    <label class="col-md-2 control-label"><b>请输入拒绝理由：</b></label>

                    <div class="col-md-9 col-sm-12">
                        <textarea id="refuseReason" name="reason" class="form-control" rows="3"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <div class="form-actions text-center">
                        <a href="?action=pass&id={$data['id']}" class="btn btn-primary">通过</a>
                        <button type="submit" class="btn btn-danger">拒绝</button>
                    </div>
                </div>
            </form>
           {/if}
        </div>
    </div>
</div>
</div>
</div>
</div>

<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js"
        type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
        type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/_page.js"></script>
</body>
<!-- END BODY -->
</html>