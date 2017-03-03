<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
{*<head>*}
    {*<title>{$title}</title>*}
    {*<meta content="" name="description"/>*}
    {*{include "inc/html_head.tpl"}*}
{*</head>*}

<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/media.css" rel="stylesheet"/>
    <link href="style/css.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title">
    </div>
    <div class="portlet-body form">
        <form class="form-horizontal" role="form" action="?" method="post">
            <input type="hidden" name="action" value="assign_submit">
            <input type="hidden" name="space_id" value="{$space_id}">
            <div class="form-body">
                <div class="form-group">
                    <div class="col-md-6 col-sm-12 show_menu">
                        <style>
                            .show_menu li {
                                list-style: none;
                            }

                            .show_menu > ul {
                                padding: 0
                            }
                        </style>
                        <ul>
                            <li style="font-size: large;color:#444444;margin-bottom: 5px;">百科名字</li>
                            <li>
                                <label>
                                    {*<div class="checker"><span class="checked"></span></div>*}
                                    <input type="checkbox" {if $status==1}checked{else}{/if} name="data[space_pedia_id]" value="{$data[0]['space_id']}" >
                                    {*<div class="checker"><input type="checkbox" name="data[space_pedia_id]" value="{$data[0]['space_id']}" ></div>*}
                                    {$data[0]['space_name']}
                                </label>
                                <ul>
                                    <li style="font-size: large;color:#444444;margin-top: 10px;margin-bottom: 5px;">子空间列表</li>
                                    {foreach $data as $k=>$v}
                                        <li>
                                            <label>
                                                {*<div class="checker"><span class="checked"><input type="checkbox" name="data[space_item_id][]" value="{$v['id']}" ></span></div>*}
                                                {if $v['status']==1}
                                                <input type="checkbox" name="data[space_item_id][]" {foreach $space_item_id as $key=>$val}{if $val==$v['id']}checked{/if}{/foreach} value="{$v['id']}" >
                                                {/if}
                                                {$v['item_name']}
                                                {if $v['status']==2}<span style="color: #ecbc29;">审核中</span>{/if}
                                                {if $v['status']==3}<span style="color: #ff0000;">审核拒绝</span>{/if}
                                                {if $v['status']==0}<span style="color: #ecbc29;">已下线</span>{/if}
                                                {if $v['status']==-1}<span style="color: #ecbc29;">已删除</span>{/if}
                                            </label>
                                        </li>
                                    {/foreach}
                                </ul>
                            </li>
                        </ul>
                        <span style="font-size: medium;color :#444444">授权的手机号：</span><input type="text" name="data[phone]" value="{$phone}"/>

                    </div>
                </div>

            </div>
            <div class="form-actions text-center">
                {*<button type=" reset" class="btn btn-default">*}
                    {*重置*}
                {*</button>*}
                <button type="submit" class="btn btn-success">
                    提交
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
    <script type="text/javascript" src="{$_assets}plugins/datatables/plugins/bootstrap/dataTables.bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/jquery-multi-select/css/multi-select.css"/>
    <script type="text/javascript" src="{$_assets}plugins/jquery-multi-select/js/jquery.multi-select.js"></script>
    <!-- END PAGE LEVEL PLUGINS -->
    <!-- BEGIN PAGE LEVEL SCRIPTS -->
    <script src="{$_assets}scripts/app.js"></script>
    <script src="{$_assets}scripts/_page.js"></script>
    <script>
        jQuery(document).ready(function () {
            App.init();
            $('#my_multi_select2').multiSelect({
                selectableOptgroup: true
            });
        });
    </script>
</body>

<!-- END BODY -->
</html>