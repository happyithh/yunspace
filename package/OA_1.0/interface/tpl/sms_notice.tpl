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
            <i class="fa fa-database"></i>短信通知设置
        </div>
    </div>
    <div class="portlet-body form">
        <form class="form-horizontal" role="form" action="?" method="post">
            <input type="hidden" name="submit" value="1">
            {foreach $_data2 as $k=>$v}
            <div class="class=" tabbable tabbable-custom boxless
            " style="padding: 20px ;"">
            <label class="col-md-3 control-label">{$k}</label>

            <div class="col-md-4">
                <input class="form-control" rows="1" type="text" name="data[{$k}]" value="{$v}">
            </div>
    </div>
    {/foreach}
    <br>

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