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
    <style>
        .hidden-xs {

            line-height: 28px;
            color: #666;
            float: left;
            font-size: 15px;
            display: block;
            width: 46%;
            margin: 0 2% 0 0;

        }

        .information_left {
            padding: 10px;
            line-height: 28px;
            font-size: 15px;
            float: left;
            width: 100%;
        }

        .hidden-xs span {
            display: block;
            width: 46%;
            float: left;
            margin: 0 2% 0 0;
            padding-left: 90px;
        }

    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">


<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>{$page_name}
        </div>
    </div>
    {if $bind_vendor}
        <input type="hidden" name="bind_vendor" value="{$bind_vendor}">
    {/if}
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <tbody>

                <form class="form-horizontal" role="form" action="?" method="post">
                    <input type="hidden" name="action" value="pass">
                    <input type="hidden" name="id" value="{$data[0]['id']}" >

                    <tr>
                        <td>
                            <div class="information_left">
                                请输入拒绝理由
                            </div>
                        </td>
                        <td>
                            <div class="hidden-xs" style="padding-left: 90px;">
                                <textarea class="form-control rejectReason" placeholder="拒绝原因" name="rejectReason"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <div class="form-actions text-center">
                                <a type="submit" onclick="reject()" class="btn btn-default">
                                    拒绝
                                </a>
                                <button type="submit" class="btn btn-success">
                                    通过审核
                                </button>
                            </div>
                        </td>
                    </tr>
                </form>
                </tbody>
            </table>
        </div>
    </div>
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
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->

<script>

    //审核拒绝
    function reject() {
        var reject = $('.rejectReason').val();
        var url = "?action=reject&id={$data[0]['id']}&reason=" + reject + "";
        if (reject) {
            window.location.href = url;
        } else {
            alert('请填写拒绝原因！');
            $('.rejectReason').focus();
        }
    }
</script>
</body>

<!-- END BODY -->
</html>