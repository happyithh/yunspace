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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="tab-content">
    <div class="tab-pane active" id="tab_7">
        <div class="portlet ">
            <div class="portlet-title">
                <div class="caption">
                    <i class="fa fa-reorder"></i><font><font>公告
                        </font></font></div>

            </div>
            <div class="portlet-body form">

                <form action="?" method="post" class="form-horizontal form-bordered form-label-stripped">


                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-3"><font><font>时间</font></font></label>

                            <div class="col-md-9">
                                <span class="form-control">{date('Y-m-d H:i:s',$_data['create_time'])}</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-3"><font><font>标题</font></font></label>

                            <div class="col-md-9">
                                <span class="form-control">{$_data['title']}</span>
                            </div>
                        </div>

                        <div class="form-group ">
                            <label class="control-label col-md-3"><font><font>内容</font></font></label>

                            <div class="col-md-9">
                                {$_data['content']}
                            </div>
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>
</div>

<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        tab="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>

</body>
<!-- END BODY -->
</html>