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
<div class="clearfix">
    <div class="portlet" style="margin: auto">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-reorder"></i> 新建供应商账户
            </div>
        </div>
        <div class="portlet-body form">
            <div class="alert alert-success" style="margin:20px">
                <strong>该账号用于前台的登录</strong>
            </div>
            <form class="form-horizontal" action="doTransformSupplier" method="post" role="form">
                <div class="form-body">
                    <div class="form-group">
                        <label for="inputEmail12" class="col-md-2 control-label">账户名</label>

                        <div class="col-md-4">
                            <div class="input-icon">
                                <i class="fa fa-user"></i>
                                <input type="text" class="form-control" id="inputEmail12" placeholder="新建账户名" name="username">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword1" class="col-md-2 control-label">手机号</label>

                        <div class="col-md-4">
                            <div class="input-icon">
                                <i class="fa fa-mobile"></i>
                                <input type="text" class="form-control" id="inputPassword1" placeholder="手机号" value="{$contactPhone}" name="phone">
                            </div>
                            {*<div class="help-block">*}
                            {*with right aligned icon*}
                            {*</div>*}
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail12" class="col-md-2 control-label">密码</label>

                        <div class="col-md-4">
                            <div class="input-icon">
                                <i class="fa fa-keyboard-o"></i>
                                <input type="password" class="form-control" placeholder="请输入密码" name="password">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail12" class="col-md-2 control-label">确认密码</label>

                        <div class="col-md-4">
                            <div class="input-icon">
                                <i class="fa fa-keyboard-o"></i>
                                <input type="password" class="form-control"  placeholder="请输入密码" name="rpassword">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-2 control-label">认证类型</label>
                        <div class="col-md-4">
                            <select class="form-control" name="identity_type">
                                <option value="2">企业认证</option>
                                <option value="1">个人认证</option>
                            </select>
                        </div>
                    </div>
                    <input type="text" name="contactId" value="{$contactId}" style="display: none"/>
                </div>

                <div class="form-actions">
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <button type="submit" class="btn btn-success">确认提交</button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


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