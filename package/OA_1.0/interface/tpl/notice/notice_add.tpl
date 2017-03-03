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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>短信通知填写
        </div>
    </div>

    <form class="form-horizontal" role="form" action="?" method="post">
        {if empty($data['id'])}
            <input type="hidden" name="action" value="addsubmit">
        {else}
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="{$data['id']}">
        {/if}
        <input type="hidden" name="submit" value="1">

        <div class="form-actions text-center">
            <div class="portlet-body form text-center" id="outinput">

                <div class=" tabbable tabbable-custom boxless">
                    <label class="col-md-3 control-label">城市</label>

                    <div class="col-md-4">
                        <select class="form-control" name="city">

                            <option>请选择</option>
                            {foreach $_REQUEST['cities'] as $k=>$v}
                                <option value=" {$v}" {if $v==$data['city']} selected="selected" {/if}>
                                    {$v}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                </div>

                <div class=" tabbable tabbable-custom boxless">
                    <label class="col-md-3 control-label">名称</label>

                    <div class="col-md-4">
                        <select id="addinput" class="form-control" name="title">
                            <option value="0">
                                请选择
                            </option>
                            {foreach $_data2 as $k=>$v}
                                <option value="{$v}"  {if $v==$data['name']} selected="selected" {/if}>
                                    {$v}
                                </option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class=" tabbable tabbable-custom boxless">
                    <label class="col-md-3 control-label">设置</label>

                    <div class="col-md-4">
                        <input type="text" class="form-control" placeholder="填写联系方式" name="contact"
                               value="{$data['contact']}">
                    </div>
                </div>
            </div>
        </div>
</div>
<div style="margin-left: 30%;">
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