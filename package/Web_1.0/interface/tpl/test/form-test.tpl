<!DOCTYPE html>
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>表单设置
        </div>
    </div>
    <div class="portlet-body form">
        <form class="form-horizontal" role="form" action="?" method="post">
            <input type="hidden" name="submit" value="1">
            <input type="hidden" name="id" value="1">
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">姓名</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text"  name="data[姓名]" value="">
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">电话</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text"  name="data[电话]" value="">
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">邮箱</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text"  name="data[邮箱]" value="">
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">学校</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text" name="data[学校]" value="">
                </div>
            </div>
            <div class=" tabbable tabbable-custom boxless" style="padding: 10px;">
                <label class="col-md-3 control-label">QQ</label>

                <div class="col-md-4">
                    <input class="form-control" rows="1" type="text" name="data[QQ]" value="">
                </div>
            </div>


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
</body>
<!-- END BODY -->
</html>