<!DOCTYPE html>
<!--
Template Name: Conquer - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.2.0
Version: 2.0
Author: KeenThemes
Website: http://www.keenthemes.com/
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Like: www.facebook.com/keenthemes
Purchase: http://themeforest.net/item/conquer-responsive-admin-dashboard-template/3716838?ref=keenthemes
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
-->
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <meta charset="utf-8"/>
    <title>Conquer | UI Features - General</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
    <meta content="" name="description"/>
    <meta content="" name="author"/>
    <meta name="MobileOptimized" content="320">
    <!-- BEGIN GLOBAL MANDATORY STYLES -->
    <link href="{$_assets}plugins/font-awesome/css/font-opensans.css" rel="stylesheet"
          type="text/css"/>
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css"/>
    <!-- END GLOBAL MANDATORY STYLES -->
    <!-- BEGIN THEME STYLES -->
    <link href="{$_assets}css/style-conquer.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/style.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/style-responsive.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/themes/blue.css" rel="stylesheet" type="text/css" id="style_color"/>
    <link href="{$_assets}css/custom.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-datepicker/css/datepicker.css"/>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-datetimepicker/css/datetimepicker.css"/>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/select2/select2.css"/>
    <link href="{$_assets}css/plugins.css" rel="stylesheet" type="text/css"/>
    <!-- END THEME STYLES -->
    <!-- BEGIN PAGE LEVEL STYLES -->
    <link href="{$_assets}plugins/gritter/css/jquery.gritter.css" rel="stylesheet" type="text/css"/>
    <link href="css/ip/ip.css" rel="stylesheet" type="text/css"/>
    <!-- END PAGE LEVEL STYLES -->
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
</head>
<style>
    .none{
        display:none!important;
    }

</style>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body  style="background:#FaFaFa !important;min-height:800px;">
<div class="portlet">
    <div class="portlet-title">
        <span style="font-size: 20px;font-weight: bolder;">{$data['space_name']}--{$data['active_name']}</span>
        {if $data['step']>=0}
            （订单阶段：了解需求）
            {elseif $data['step']>=1}
            （订单阶段：明确需求中）
            {elseif $data['step']>=2}
            （订单阶段：合同流程中）
        {/if}
    </div>
    <div class="portlet-body">
        {if $data['step']>=0}
        {include "OA_Static::winchance_order/inc/add_1.tpl"}
        {/if}
        {if $data['step']>=1}
        {include "OA_Static::winchance_order/inc/add_2.tpl"}
        {/if}
        {if $data['step']>=2}
        {include "OA_Static::winchance_order/inc/add_3.tpl"}
        {/if}
    </div>

</div>
<div class="modal fade" id="modal-one" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title"></h4>
            </div>
            <div class="modal-body">
                <div class="form-body">
                    <div class="form-group clearfix">
                        <div class="col-md-12 col-xs-12 modal-text" style="text-align: center;font-size:15px;">

                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info company_create modal-ok-one" >确定</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<div class="modal fade" id="modal-two" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">取消订单</h4>
            </div>
            <div class="modal-body">
                <div class="form-body">
                    <div class="form-group clearfix">
                        <div class="col-md-12 col-xs-12 modal-text" style="text-align: center;font-size:15px;">
                            请确认场地已经终止了意向，订单无法继续<br/>订单取消后不可恢复，请慎重选择！！
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <a href="" class="btn btn-info company_create modal-url">确定</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->

<script src="{$_assets}plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="{$_assets}plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="js/ip.js"></script>
<script src="{$_assets}plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->
<script type="text/javascript" src="{$_assets}plugins/gritter/js/jquery.gritter.js"></script>
<script type="text/javascript" src="{$_assets}plugins/jquery.pulsate.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/jquery-bootpag/jquery.bootpag.min.js"></script>
<script type="text/javascript" src="{$_assets}plugins/holder.js"></script>
<script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
<script src="{$_assets}scripts/app.js"></script>
<script src="{$_assets}scripts/ui-general.js"></script>
<script src="{$_assets}scripts/form-components.js"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
    jQuery(document).ready(function () {
        // initiate layout and plugins
        App.init();
        UIGeneral.init();
    });
</script>
<!-- END JAVASCRIPTS -->
<script src="js/select2_res/select2.js"></script>
<script src="js/winchance_ip/dateWeek.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
//        $('.date').datetimepicker({
//            format: 'YYYY-MM-DD',
//            locale: 'zh-cn'
//        });
        $('.date').datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'cn',
            minView:2,
            autoclose:true
        });
        $('.cancel_order').click(function(){
            var r=confirm("请确认场地方已经终止了意向，订单无法继续订单取消后不可恢复，请慎重选择？");
            if(r){
                var order_id = $(this).attr('data-value');
                window.location.href="?action=cancel&order_id="+order_id;
            }else{
                return false;
            }
        });
    });
</script>
</body>

<!-- END BODY -->
</html>