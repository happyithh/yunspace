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
   套餐信息预览和审核
</h3>
<a href="javascript:history.go(-1)" class="back"><
    <返回
</a>
<div class="clear"></div>
<div class="portlet">
    <div class="portlet-body">
        <div class="container-fluid">
            <div class="row form-horizontal">

                <form action="?action=check_set&handle_type=refuse&id={$data['id']}&vendor_id={$_REQUEST['vendor_id']}&admin_name={$_REQUEST['admin_name']}" method="post">
                    <div class="form-group">
                        <label class="col-md-3 control-label">请输入拒绝理由:</label>
                        <div class="col-md-9">
                            {*<textarea id="refuseReason" name="reason" class="form-control" rows="2" placeholder="如果拒绝请输入拒绝理由"></textarea>*}
                            <input type="text" placeholder="请输入或选择拒绝原因" class="form-control input-sm select2 tags_select2" value="" name="reason"   data-values="{implode(',',$rejectreason)}" id="refuseReason">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="form-actions text-center">
                            <a href="?action=check_set&handle_type=pass&id={$data['id']}&vendor_id={$_REQUEST['vendor_id']}&admin_name={$_REQUEST['admin_name']}&upstatus=1" class="btn btn-success">通过并上线</a>
                            <a href="?action=check_set&handle_type=pass&id={$data['id']}&vendor_id={$_REQUEST['vendor_id']}&admin_name={$_REQUEST['admin_name']}" class="btn btn-primary">通过</a>
                            <button type="submit" class="btn btn-danger">拒绝</button>
                            <a target="_blank" href="http://{Core::$urls['host']}/set_info/{md5($data['id'])}/{$data['id']}.html" class="btn btn-default">新窗口预览</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div style="border: 1px solid #ddd">
            <iframe width=100% height=900 frameborder="no" border=0 scrolling=auto src='http://{Core::$urls['host']}/set_info/{md5($data['id'])}/{$data['id']}.html'></iframe>
        </div>
    <div>
</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
<script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/_page.js"></script>
<script>
    $(document).ready(function(){
        $(".tags_select2").each(function () {
            $(this).select2({
                tags: $(this).data('values').split(',')
            })
        });
    });
</script>
<!-- BEGIN CORE PLUGINS -->
</body>
<!-- END BODY -->
</html>