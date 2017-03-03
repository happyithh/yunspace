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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <style>
        .readdata p {
            padding: 0
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
<div class="portlet-title">
    <div class="caption">
        <i class="fa fa-cogs"></i>
        {if $_REQUEST['is_my']}
            添加我的联系人
        {else}
            添加公共联系人
        {/if}
    </div>

</div>
<div class="portlet-body">
{include file="contacts/inc/contact_detail_tab_edit.tpl"}
</div>
</div>

</body>
<!-- END BODY -->
</html>