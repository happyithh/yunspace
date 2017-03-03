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
该联系人手机号已被注册，请选择下列操作。
<div>
    你可以为该联系人绑定新的供应商或者绑定已存在供应商
    <div>
        <a href="{$_root}{Core::$urls['package']}vendor/list?action=add&vendorId={$_vendorId['id']}" class="btn btn-success">
            <i class="fa fa-plus"></i>新建供应商
        </a>
    </div>
    <form action="">
        {if $vendors}
            <div class="form-group clearfix">
                <label class="col-md-3 control-label">绑定已存在供应商</label>

                <div class="col-md-6 col-sm-12 radio-list">
                    {foreach $vendors as $k=>$v}
                        <label>
                            <input type="checkbox" class="form-control" value="{$v['id']}" name="vendor_id[]"/>
                            [{$v['id']}]  {$v['vendor_name']}
                            {if $v['vendor_account_id'] != 0 && $v['vendor_account_id'] != $v['id']}
                                <span style="color:#0b679e">[已绑定其他账户]</span>
                            {/if}
                        </label>
                    {/foreach}
                </div>
            </div>
        {/if}

        {foreach $data as $k=>$v}
            <div class="form-group">
                <label class="col-md-3 control-label">{$k}</label>

                <div class="col-md-6 col-sm-12">
                    <input type="text" class="form-control" placeholder="{$v}" value="{$v}" readonly="readonly">
                </div>
            </div>
        {/foreach}
    </form>


</div>
<a href="">返回</a>
</body>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
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
<script src="{$_assets}plugins/jquery.blockui.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js"
        type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
<script type="text/javascript"
        src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script>
    jQuery(document).ready(function () {
        App.init();
        TableManaged.init();
    });
</script>
</body>
<!-- END BODY -->
</html>