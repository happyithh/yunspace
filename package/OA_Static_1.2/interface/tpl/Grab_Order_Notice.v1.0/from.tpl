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
                    <i class="fa fa-reorder"></i><font><font>编辑公告
                        </font></font></div>

            </div>
            <div class="portlet-body form">

                <form action="?" method="post" class="form-horizontal form-bordered form-label-stripped">
                    <input type="hidden" name="id" value="{$_data['id']}">
                    <input type="hidden" name="action" value="edit">

                    <div class="form-body">
                        <div class="form-group">
                            <label class="control-label col-md-3"><font><font>标题</font></font></label>

                            <div class="col-md-9">
                                <input type="text" class="form-control" name="title" value="{$_data['title']}">
                            </div>
                        </div>
                        <div class="form-group ">
                            <label class="control-label col-md-3"><font><font>类型</font></font></label>

                            <div class="col-md-9">
                                <select class="form-control" name="type">
                                    <option>公告</option>
                                </select>
                            </div>
                        </div>


                        <div class="form-group ">
                            <label class="control-label col-md-3"><font><font>内容</font></font></label>

                            <div class="col-md-9">
                                {include "Admin::inc/html_umeditor.tpl" name="cont" value=$_data['content'] height=300}

                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="row">
                            <div class="col-md-offset-3 col-md-9">
                                <button type="submit" class="btn btn-success"><i
                                            class="fa fa-check"></i><font><font>提交</font></font></button>
                                <button type="reset" class="btn btn-default"><font><font>重置</font></font></button>
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