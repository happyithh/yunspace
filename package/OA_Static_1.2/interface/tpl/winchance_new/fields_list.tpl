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
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/ip/ip.css" rel="stylesheet" type="text/css"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

{*<style>*}
{*.step_content {*}
{*height: auto;*}
{*overflow: hidden;*}
{*background-color: #eee;*}
{*padding: 2%;*}
{*width: 96%;*}
{*margin-top: 5px;*}
{*display: none;*}
{*word-break: break-all;*}
{*}*}
{*</style>*}
<div class="portlet">

    <div class="portlet-title clearfix">
    </div>
    <div class="portlet-body">
        {*<div class="portlet-body"  style="padding:10px;margin:0 -10px;">*}
            {*<div class="row clearfix">*}
                {*<!-- /.col-md-6 -->*}
                {*<div class="col-md-4  col-xs-6">*}
                    {*<div class="input-group">*}
                        {*<input type="text" class="form-control">*}
                                                {*<span class="input-group-btn">*}
                                                {*<button class="btn btn-info" type="button"><i class="fa fa-search" aria-hidden="true"></i></button>*}
                                                {*</span>*}
                    {*</div>*}
                    {*<!-- /input-group -->*}
                {*</div>*}
            {*</div>*}
        {*</div>*}
        <div class="portlet-body">

            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th width="20%">字段名</th>
                            <th width="70%">选项内容</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $data as $k=>$v}
                        <tr>
                            <td class="name">{$v['name']}</td>
                            <td class="c-arr">{foreach $v['content'] as $kk=>$vv}{$vv},{/foreach}</td>
                            <td>
                                <a class="btn btn-info btn-xs edit-one" data-name="{$v['name']}" data-toggle="modal" href="#modal-one">字段编辑</a>
                            </td>
                        </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modal-one" tabindex="-1" role="basic" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                    <h4 class="modal-title field-name">编辑字段-</h4>
                </div>
                <div class="modal-body">
                    <div class="form-body">
                        <div class="form-group clearfix">
                            <label class="col-md-4 control-label col-xs-4">选项内容</label>
                            <div class="col-md-8 col-xs-8">
                                {*<input type="text" id="content" class="form-control select2"  required>*}
                                <input type="hidden" id="url" class="" value="{$_home}winchance_new/fields_manage"  required>
                                <input type="text" name="content"  id="persons" class="form-control select2 conform_crowd" value="" placeholder="请添加字段内容"  required>
                                <div style="margin-top: 10px;">
                                    <span style="color:red">注：请按回车确认，可添加多项内容！！</span>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info field_submit">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            type="text/javascript"></script>
    {static "core/yunspace.js"}
    {*<script src="js/demands/demands_change_select.js" type="text/javascript"></script>*}
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>

    {*<script src="js/select2_res/select2.js"></script>*}
    <script type="text/javascript" src="js/winchance_ip/company_create.js"></script>
    <script>
        $(function(){
            var c_arr;
            $(".edit-one").on('click',function() {
                c_arr=$(this).parents('tr').find('.c-arr').text();
                c_arr=c_arr.replace(/\s+/g,"");
            });
            $("#modal-one").on('show.bs.modal',function() {
                $(this).find(".select2-choices .select2-search-choice").remove();
                $(".conform_crowd").val(c_arr);
                c_arr=c_arr.split(',');
                c_arr.pop();
            });
            $("#modal-one").on('shown.bs.modal',function() {
                console.log(c_arr);
                $("#persons").select2({
                    tags:c_arr
                });
                $(".select2-choices").find(".select2-search-choice:last").remove();
            })
        })

    </script>
</body>
<!-- END BODY -->
</html>