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
<div class="portlet-body">
    <div style="padding: 10px 0">
    <select class="form-control" name="city" onchange="changeCity(this)">
        {foreach $_REQUEST['cities'] as $v}
            <option value="{$v}" {if $v==$_REQUEST['city']}selected="selected" {/if}>
                {$v}
            </option>
        {/foreach}
    </select>
    </div>
    <div class="tab-content clearfix">
        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>员工</th>
                <th>每日限额</th>
                <th>今日已领联系人</th>
                <th>级别</th>
                <th>所属组</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            {foreach $_data['rows'] as $k=>$v}
                <tr role="row">
                    <td>{$v['fullname']}</td>
                    <td>{$v['quota_today']}</td>
                    <td>{$v['quota_now']}</td>
                    <td>{$level_title[$v['level']]}</td>
                    <td>{$v['team_name']}</td>
                    <th>
                        <a href="?action=edit&id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> 修改</a>
                        <a href="?action=delete&id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i> 删除</a>
                    </th>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
    <a href="?action=edit&city={$_REQUEST['city']|default:'上海'}" class="btn btn-primary">添加部门成员</a>
</div>
</body>
<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script>
    function changeCity(o) {
        var href = window.location.href + '?';
        window.location = href.substr(0, href.indexOf('?')) + '?city=' + $(o).val() + '&t=' + (new Date()).valueOf();
    }
</script>
</body>
<!-- END BODY -->
</html>