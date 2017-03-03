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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>更新关键词
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div style="text-align: center;padding: 20px 10px;">
                <a class="btn btn-success" href="?action=update_keyword" style="margin-left: 35px;">更新关键词</a>
                {*<a class="btn btn-primary" href="?action=update_frequency" style="margin-left: 35px;">更新搜索次数</a>*}
            </div>
        </div>
        {*<div>*}
            {*{foreach $data as $k=>$v}*}


            {*{/foreach}*}
        {*</div>*}
    </div>
</div>
</body>
<!-- END BODY -->
</html>