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
                <i class="fa fa-reorder"></i> 新建关联供应商
            </div>
        </div>
        <div class="portlet-body form">
            <div class="alert alert-success" style="margin:20px">
                <strong>此处新建的供应商会和该账户绑定,如果是新建的账户则必须绑定一个供应商。</strong>
            </div>
            {if !$type}
                <div class="alert alert-danger" style="margin:20px">
                    <strong>如果要绑定的供应商已存在，请点击这里
                        <button class="btn btn-danger abtn"><a href="check?accountId={$accountId}&contactId={$contactId}" style="color: #fff">跳过此步</a></button>
                    </strong>
                </div>
            {/if}

            <form class="form-horizontal" action="doAddSupplier" method="post">
                <div class="form-body">
                    <div class="form-group">
                        <label for="inputEmail12" class="col-md-2 control-label">供应商名称</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" placeholder="供应商名称" name="vendor_name" value="{$data['company']}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword1" class="col-md-2 control-label">供应商地址</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" placeholder="供应商地址" name="data[供应商地址]">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail12" class="col-md-2 control-label">主要联系人</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control" placeholder="主要联系人"  name="data[主要联系人]" value="{$data['username']}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputEmail12" class="col-md-2 control-label">联系方式</label>
                        <div class="col-md-4">
                            <input type="text" class="form-control"  placeholder="联系方式" name="data[联系方式]" value="{$data['phone']}">
                        </div>
                    </div>

                    {*<div class="form-group">*}
                    {*<label class="col-md-2 control-label">选择城市</label>*}
                    {*<div class="col-md-4">*}
                    {*<div class="checkbox-list">*}
                    {*<label class="checkbox-inline"><input type="checkbox" name="post_city[]" value="上海">上海</label>*}
                    {*<label class="checkbox-inline"><input type="checkbox" name="post_city[]" value="北京">北京</label>*}
                    {*<label class="checkbox-inline"><input type="checkbox" name="post_city[]" value="深圳">深圳</label>*}
                    {*<label class="checkbox-inline"><input type="checkbox" name="post_city[]" value="广州">广州</label>*}
                    {*<label class="checkbox-inline"><input type="checkbox" name="post_city[]" value="成都">成都</label>*}
                    {*<label class="checkbox-inline"><input type="checkbox" name="post_city[]" value="杭州">杭州</label>*}
                    {*</div>*}
                    {*</div>*}
                    {*</div>*}

                    <input type="hidden" name="accountId" value="{$accountId}" style="display: none"/>
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

<script src="{$_assets}scripts/form-components.js"></script>
<script>
    jQuery(document).ready(function () {
        App.init();
        TableManaged.init();

    });
</script>
</body>
<!-- END BODY -->
</html>