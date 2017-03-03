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
        {include "OA_Static::winchance_new/step_add/add_1.tpl"}
        {*{if $step>=2}*}
            {include "OA_Static::winchance_new/step_add/add_2.tpl"}
        {*{/if}*}
        {*{if $step>=3}*}
            {include "OA_Static::winchance_new/step_add/add_3.tpl"}
        {*{/if}*}
        {*{if $step>=4}*}
            {include "OA_Static::winchance_new/step_add/add_4.tpl"}
        {*{/if}*}
        {*{if $step>=5}*}
            {include "OA_Static::winchance_new/step_add/add_5.tpl"}
        {*{/if}*}

    </div>

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
{*<script>*}
    {*(function (i, s, o, g, r, a, m) {*}
        {*i['GoogleAnalyticsObject'] = r;*}
        {*i[r] = i[r] || function () {*}
            {*(i[r].q = i[r].q || []).push(arguments)*}
        {*}, i[r].l = 1 * new Date();*}
        {*a = s.createElement(o),*}
                {*m = s.getElementsByTagName(o)[0];*}
        {*a.async = 1;*}
        {*a.src = g;*}
        {*m.parentNode.insertBefore(a, m)*}
    {*})(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');*}
    {*ga('create', 'UA-37564768-1', 'keenthemes.com');*}
    {*ga('send', 'pageview');*}
{*</script>*}
<script src="js/select2_res/select2.js"></script>
{*<script src="js/winchance_ip/drop_step.js"></script>*}
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
    $(".dropdown-menu-one").find('a').each(function(index,dom){
        var $dom=$(dom);
        $dom.on('click',function() {
            var $this=$(this);
            var w=$this.text();
            $this.parents('.input-group').find('.date-mo').val(w);
            $this.parents('.input-group').find(".current-mo").html(w+'<i class="fa fa-angle-down"></i>');
            console.log(w);
        })
    });
</script>
{static "core/yunspace.js"}
{*<script type="text/javascript" src="js/winchance_ip/draft_submit.js"></script>*}
</body>

<!-- END BODY -->
</html>