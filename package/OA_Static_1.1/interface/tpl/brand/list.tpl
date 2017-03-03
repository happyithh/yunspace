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
    <link href="style/media.css" rel="stylesheet"/>
    <link href="style/css.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
{*<div class="cols-md-3 " style="text-align: center;margin: 15px 0px">*}
    {*<a href="?action=list">*}
        {*<div class="btn btn-default {if $_REQUEST['action']=='list' || empty($_REQUEST['action'])} btn-success{/if} active go_switch_window">*}
            {*合作品牌管理*}
        {*</div>*}
    {*</a>*}
    {*<a href="?action=brand_form">*}
        {*<div class="btn btn-default {if  $_REQUEST['action']=='brand_form'} btn-success{/if} go_switch_window">品牌入驻列表</div>*}
    {*</a>*}
{*</div>*}
{*{if $_REQUEST['action']=='list' || empty($_REQUEST['action'])}*}
    {include "brand/inc/cooperation_brand.tpl"}
{*{else}*}
    {*{include "brand/inc/brand_form.tpl"}*}
{*{/if}*}
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
</script></body>
<!-- END BODY -->
</html>