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
            <input type="hidden" name="action" value="submit">
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
                                    <div class="checker"></div>
                                    {$data[0]['space_name']}
                                </label>
                                <ul>
                                    <li style="font-size: large;color:#444444;margin-top: 10px;margin-bottom: 5px;">子空间列表</li>
                                    {foreach $item_name as $k=>$v}
                                        <li>
                                            <label>
                                                <div class="checker"></div>
                                                {$v}
                                            </label>
                                        </li>
                                    {/foreach}
                                </ul>
                            </li>
                        </ul>
                        <span style="font-size: medium;color :#444444">手机号：</span>{$data[0]['phone']}

                    </div>
                </div>

            </div>
        </form>
    </div>
</body>

<!-- END BODY -->
</html>