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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">


<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>账户实名认证
        </div>
    </div>
    <div class="portlet-body form">
        <div class="" style="padding: 20px">
            <div class="alert alert-warning">
                <strong>联系人账户信息未认证！请登录账号完善信息!</strong>
            </div>
            {*<div class="alert alert-danger">*}
                {*<strong>如果没有关联的供应商，请点击此处*}
                    {*<button class="btn btn-danger abtn"><a href="addSupplier?accountId={$user_id}&contactId={$contactId}" style="color: #fff">新建关联供应商</a></button>*}
                {*</strong>*}
            {*</div>*}
        </div>

            <form class="form-horizontal" role="form" action="pass" method="post">
                <input type="hidden" name="action" value="pass">
                <input type="hidden" name="id" value="{$user_id}">
                <div class="form-body">
                    {*{foreach $data as $k=>$v}*}
                        {*<div class="form-group">*}
                            {*<label class="col-md-3 control-label">{$k}</label>*}

                            {*<div class="col-md-6 col-sm-12">*}
                                {*<input type="text" class="form-control" placeholder="{$v}" value="{$v}" readonly="readonly">*}
                            {*</div>*}
                        {*</div>*}
                    {*{/foreach}*}
                    {if $existing}
                        <div class="form-group">
                            <label class="col-md-3 control-label">已绑定供应商</label>

                            <div class="col-md-6 col-sm-12 radio-list">
                                {foreach $existing as $k=>$v}
                                    <label>
                                        [{$v['id']}]  {$v['vendor_name']}
                                    </label>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    {if $vendors}
                        <div class="form-group">
                            <label class="col-md-3 control-label">绑定供应商</label>

                            <div class="col-md-6 col-sm-12 radio-list">
                                {foreach $vendors as $k=>$v}
                                    <label>
                                        <input type="checkbox" class="form-control" value="{$v['id']}" name="vendor_id[]"/>
                                        [{$v['id']}
                                        ]  {$v['vendor_name']}
                                        {if $v['vendor_account_id'] != 0 && $v['vendor_account_id'] != $v['id']}
                                            <span style="color:#ff0000">[已绑定其他账户]</span>
                                        {/if}
                                    </label>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                    {*{foreach $files as $k=>$v}*}
                        {*<div class="form-group">*}
                            {*<label class="col-md-3 control-label">{$k}</label>*}

                            {*<div class="col-md-6 col-sm-12">*}
                                {*<a href="{str_replace('//','/',$v)}" target="_blank" class="thumbnail">*}
                                    {*<img src="{str_replace('//','/',$v)}" style="height: 360px; width: 100%; display: block;">*}
                                {*</a>*}
                            {*</div>*}
                        {*</div>*}
                    {*{/foreach}*}

                </div>
                {*<div class="form-group">*}
                    {*<label class="col-md-3 control-label">如果拒绝请在此处输入拒绝原因</label>*}

                    {*<div class="col-md-4">*}
                        {*<input type="text" class="form-control" placeholder="拒绝原因" name="rejectReason" value="" id="rejectReason">*}
                    {*</div>*}
                {*</div>*}
                <div class="form-actions text-center">
                    {*<a type="submit" onclick="reject()" class="btn btn-default" disabled>*}
                        {*拒绝*}
                    {*</a>*}
                    <button class="btn btn-danger abtn"><a href="addSupplier?accountId={$user_id}&contactId={$contactId}" style="color: #fff">新建关联供应商</a></button>
                    <button type="submit" class="btn btn-success" >
                        绑定供应商
                    </button>
                </div>
            </form>
    </div>

    <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
    <!-- BEGIN CORE PLUGINS -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
    <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
    <script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
            type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->
    <!-- BEGIN PAGE LEVEL PLUGINS -->
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
    <script type="text/javascript" src="{$_assets}plugins/datatables/media/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript"
            src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/app.js"></script>
    <script src="{$_assets}scripts/_page.js"></script>
    <script>
        jQuery(document).ready(function () {
            App.init();
        });
        function reject() {
            var rejectReason = $('#rejectReason').val();
            var url = "reject?id={$user_id}&rejectReason=" + rejectReason + "";
            if (rejectReason) {
                window.location.href = url;
            } else {
                alert('请填写拒绝原因！');
            }
        }
    </script>
</body>

<!-- END BODY -->
</html>