<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
    <script src="js/jquery-1.9.1.min.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<style>
    .title {

        margin: 10px 0px 10px 10px;

        float: left;
    }
</style>
<body style="background:#FaFaFa !important">
<div class="portlet tabbable">
    <div class="portlet-title" style="height: 50px;">
        <div class="caption " style="height: 40px;line-height: 35px;">
            <i class="fa fa-reorder"></i>活动列表
        </div>
        <div class="btn-group pull-right">
            <a href="?action=test" class="btn btn-field" style="background-color: #5bc0de;color: #e6ecf3">Api测试</a>
        </div>
        <div class="btn-group pull-right">
            &nbsp;&nbsp;&nbsp;&nbsp;
        </div>
        <div class="btn-group pull-right">
            <a href="?action=add" class="btn btn-success">Api添加</a>
        </div>
        &nbsp;&nbsp;&nbsp;

    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="tab-content">
                <div class="tab-pane active">
                    {*<div class="pull-left" style="width:50%; padding: 10px 0;">*}
                        {*<form action="test_interface">*}
                            {*<div class="input-group">*}
                                {*<input type="text" class="form-control" placeholder="名称 / 类型 / 分类" name="search[title]"*}
                                       {*value="{$_REQUEST['search']['title']}">*}
                        {*<span class="input-group-btn" style="position: absolute;right: 0;top:0;">*}
                        {*<button class="btn btn-info" type="submit">*}
                            {*<i class="fa fa-search"></i>搜索*}
                        {*</button>*}
                        {*</span>*}
                            {*</div>*}
                        {*</form>*}
                    {*</div>*}

                    <table class="table table-striped table-bordered table-hover"
                           id="data_table" style="word-break: break-all">
                        <thead>
                        <tr>
                            <th>接口名称</th>
                            <th>接口分类</th>
                            <th>接口类型</th>
                            <th>接口说明</th>
                            <th>创建时间</th>
                            <th>操作</th>

                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data['rows'] as $k=>$v}
                            <tr>
                                <td>{$v['interface_name']}</td>
                                <td>{$v['category']}</td>
                                <td>{$v['type']}</td>
                                <td>{$v['des']}</td>
                                <td>{date('Y-m-d',$v['update_time'])}</td>
                                <td data-id={$v['id']}>
                                    <a onclick="editInterface(this)"
                                       class="btn btn-info btn-xs"><i class="fa fa-pencil"></i>修改</a>
                                    <a onclick="deleteInterface(this) "
                                       class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>

                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                    <div class="center-block">
                        <ul class="pagination">
                            {if $_data['page']['dpll']}
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}1" title="First"><i
                                                class="fa fa-angle-double-left"></i></a>
                                </li>
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i
                                                class="fa fa-angle-left"></i></a>
                                </li>
                            {else}
                                <li class="prev disabled">
                                    <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                                </li>
                                <li class="prev disabled">
                                    <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                                </li>
                            {/if}
                            {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                                <li{if $i==$_data['page']['dp']} class="active"{/if}>
                                    <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                                </li>
                            {/for}
                            <li class="disabled">
                                <a> {$_data['page']['dtp']}
                                    ( {$_data['page']['dp']*$_data['page']['dn']}
                                    /{$_data['page']['dt']}
                                    )</a></li>

                            {if $_data['page']['dprr']}
                                <li class="next">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                                class="fa fa-angle-right"></i></a>
                                </li>
                                <li class="next">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
                                                class="fa fa-angle-double-right"></i></a>
                                </li>
                            {else}
                                <li class="next disabled">
                                    <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                                </li>
                                <li class="next disabled">
                                    <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                                </li>
                            {/if}
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="js/moment.min.js"></script>
    <script type="text/javascript" src="js/zh-cn.js"></script>
</body>
<script>
    function deleteInterface(e) {
        var id = $(e).parent('td').data('id');
        var tab = 'deleteInterface'
        YunSpace.api("test/interface.jsonp",
                {
                    id: id, tab: tab
                },
                function (data) {
                    top.alert(data.msg);
                    window.history.go(0);
                }
        )
    }
    function editInterface(e) {
        var tab = 'editInterface'
        var id = $(e).parent('td').data('id');
        YunSpace.api("test/interface.jsonp",
                {
                    id: id, tab: tab
                },
                function (data) {
                    window.location.href='interface?action=add&id='+id+''
                }
        )
    }
</script>
{static "core/yunspace.js"}
<!-- END BODY -->
</html>