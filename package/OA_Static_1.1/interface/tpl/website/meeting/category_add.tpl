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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>

    <link rel="stylesheet" href="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
    <script type="text/javascript" src="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-reorder"></i>添加新的分类
        </div>
    </div>
    <div class="portlet-body">
        <form action="?action=category_submit" method="post" class="clearfix form-horizontal">
            <div class="form-body">
                <input  type="hidden" name="cid"  value="{$info['id']}"/>
                <input type="hidden" name="url_referer" value="{Core::$urls['referer']}">
                <div class="clearfix">
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">分类名称</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="分类名称" name="category" value="{$info['category']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">分类简介</label>

                        <div class="col-md-9">
                            <input type="text" class="form-control input-sm" placeholder="分类简介" name="des" value="{$info['des']}">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">上线/下线</label>

                        <div class="col-md-9">
                            <label class="radio-inline">
                                <input type="radio" name="status" value="1" {if $info['status']==1 ||!isset($info['status'])}checked{/if}>
                                上线
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="status" value="0" {if isset($info['status'])&&$info['status']==0}checked{/if}>
                                下线
                            </label>
                        </div>
                    </div>
                </div>
                <div class="clearfix"></div>
                <div class="form-actions text-center">
                    <button type="reset" class="btn btn-default">
                        重置
                    </button>
                    <button type="submit" class="btn btn-success">
                        提交
                    </button>
                </div>
        </form>
    </div>
</div>
</body>
</html>