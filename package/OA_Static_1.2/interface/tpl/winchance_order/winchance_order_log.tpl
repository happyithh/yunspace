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
    </div>
    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#tab_1_1" data-toggle="tab">工作记录</a>
            </li>
        </ul>
        <div class="tab-pane fade active in" id="tab_1_1">
            <div class="portlet-body">
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th width="10%">
                                时间
                            </th>
                            <th width="10%">
                                工作小结
                            </th>
                            <th width="10%">
                                工作计划
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $data['log_data'] as $k=>$v}
                        <tr>
                            <td>
                                {$k}（{$v['s_e']}）
                            </td>
                            <td>
                                {$v['summary']}
                            </td>
                            <td>
                                 {$v['plan']}
                            </td>
                        </tr>
                        {/foreach}
                        {*<tr>*}
                            {*<td>*}
                                {*2016年17周（4/18-4/24）*}
                            {*</td>*}
                            {*<td>*}
                                {*其实我叫死胖子ZZC*}
                            {*</td>*}
                            {*<td>*}
                                {*喝水都发胖，所以未使用！！*}
                            {*</td>*}
                        {*</tr>*}
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

    </div>
    <div class="portlet-body">
        <ul class="nav nav-tabs">
            <li class="active">
                <a href="#tab_1_1" data-toggle="tab">订单阶段记录</a>
            </li>
        </ul>
        <style>
            .state-list{
                padding:15px;
            }
            .state-list li{
                width:100%;
                list-style: none;
                position:relative;
                border-left:1px solid #d06ff8;
            }
            .state-list li p{
                margin:0px;
                line-height: 60px;
                padding-left:20px;
            }
            .state-list li:before{
                content:"";
                display: inline-block;
                position: absolute;
                width:10px;
                height:10px;
                left:-5px;
                top:50%;
                margin-top:-5px;
                background: #d06ff8;
                border:2px solid #fff;
                border-radius: 50%;
                box-shadow: 0px 0px 0px 3px #d06ff8;
                transition: all 0.3s ease-in;
                -webkit-transition: all 0.3s ease-in;
                -moz-transition: all 0.3s ease-in;
                -o-transition: all 0.3s ease-in;
            }
            .state-list li:hover:before{
                box-shadow: 0px 0px 3px 3px #9006c9;
                background: #9006c9;
            }
        </style>
        <div class="tab-pane fade active in clearfix" id="tab_1_1">
            <div class="col-md-6 col-xs-6">
                <ul class="state-list">
                    {foreach $data['step_time'] as $k=>$v}
                    <li>
                        <p>{$k}（{date('Y-m-d H:i:s',$v)}）</p>
                    </li>
                    {/foreach}
                    {*<li>*}
                        {*<p>了解需求（2016/4/21 00:19:42）</p>*}
                    {*</li>*}
                    {*<li>*}
                        {*<p>创建订单（2016/4/21 00:19:42）</p>*}
                    {*</li>*}
                    {*<li>*}
                        {*<p>创建订单（2016/4/21 00:19:42）</p>*}
                    {*</li>*}
                    {*<li>*}
                        {*<p>创建订单（2016/4/21 00:19:42）</p>*}
                    {*</li>*}
                </ul>
            </div>
            <div class="col-md-4 col-xs-4" style="padding-top:15px;">
                <div class="alert alert-success">
                    <strong>当前阶段：</strong> {$step[$data['step']]}
                </div>
                <div class="alert alert-info">
                    <strong>当前状态：</strong> {$status[$data['status']]}
                </div>
            </div>

        </div>


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
<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date();
        a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
    ga('create', 'UA-37564768-1', 'keenthemes.com');
    ga('send', 'pageview');
</script>
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
    });
</script>
</body>

<!-- END BODY -->
</html>