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
    供应商信息审核页
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>

<div class="clear"></div>
<div class="portlet">
    <div class="portlet-body">
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row form-horizontal">
                <form action="?action=check_vendor&handle_type=pass&id={$data['id']}&admin_name={$_REQUEST['admin_name']}" method="post" id="myform">
                    <div class="form-group">
                        <label class="col-md-3 control-label">服务分类:</label>
                        <div class="col-md-6">
                            <select multiple="multiple" class="multi-select" name="categories_id[]" id="my_multi_select2" data-placeholder="Select...">
                                {function show_category level=0}
                                    {foreach $_categories[$id] as $k=>$v}
                                        {if $v}
                                        <option value="{$k}" {if in_array($k,$data['categories_id'])} selected="selected" {/if}>{str_repeat(' . . ', $lv)}
                                            {$k}
                                            . {$v}
                                        </option>
                                        {/if}
                                        {if $_categories[$k]}
                                            {show_category id=$k lv=$lv+1}
                                        {/if}
                                    {/foreach}
                                {/function}
                                {show_category id=0 lv=1}
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-md-3 control-label">请输入拒绝理由:</label>
                        <div class="col-md-6">
                            {*<textarea id="refuseReason" name="reason" class="form-control" rows="2"></textarea>*}
                            <input type="text" placeholder="请输入或选择拒绝原因" class="form-control input-sm select2 tags_select2" value="" name="reason"   data-values="{implode(',',$rejectreason)}" id="refuseReason">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-actions text-center">
                            <button type="submit" class="btn btn-success" onclick="passandup()"> 通过并上线</button>
                            <button type="submit" class="btn btn-primary"> 通过</button>
                            <button type="button" class="btn btn-danger" onclick="refuse()">拒绝</button>
                            <a target="_blank" href="http://{Core::$urls['host']}/vendor_info/{md5($data['id'])}/{$data['id']}.html" class="btn btn-default">新窗口预览</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div style="border: 1px solid #ddd">
            <iframe width=100% height=900 frameborder="no" border=0 scrolling=auto src='http://{Core::$urls['host']}/vendor_info/{md5($data['id'])}/{$data['id']}.html'></iframe>
        </div>
    </div>

    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/_page.js"></script>
    <script>
        $('#my_multi_select2').multiSelect({
            selectableOptgroup: true
        });
        function refuse() {
            $('#myform').attr('action', '?action=check_vendor&handle_type=refuse&id={$data["id"]}&admin_name={$_REQUEST['admin_name']}');
            $('#myform').submit();
        }
        function passandup() {
            $('#myform').attr('action', '?action=check_vendor&handle_type=pass&id={$data["id"]}&admin_name={$_REQUEST['admin_name']}&upstatus=1');
            $('#myform').submit();
        };
        $(document).ready(function(){
            $(".tags_select2").each(function () {
                $(this).select2({
                    tags: $(this).data('values').split(',')
                })
            });
        })
    </script>
</body>
<!-- END BODY -->
</html>