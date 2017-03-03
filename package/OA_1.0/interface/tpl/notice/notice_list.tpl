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
</div>
<div class="portlet">
    <div class="portlet-title" style="padding: 6px;">
        <div class="caption">
            <i class="fa fa-comments"></i>
            短信设置列表
        </div>
        <a style="float: right;padding: 3px;" class="btn btn-success" href="?action=add"><i
                    class="fa fa-plus"></i>添加</a>
    </div>
    <form class="form-horizontal" role="form" action="?" method="post">
        <div class="input-group" style="width: 30%;padding: 15px;">
            <input type="text" class="form-control" placeholder="ID / 关键词" name="search[title]" value="">
<span class="input-group-btn">
<button class="btn btn-info" type="submit">
    <i class="fa fa-search"></i>
</button>
    </span>
        </div>
    </form>
    </span>
</div>
<div class="portlet-body">
    <div class="table-responsive clearfix">
        <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
            <thead>
            <tr>
                <th>ID</th>
                <th>名称</th>
                <th>城市</th>
                <th>设置</th>
                <th>发表时间</th>
                <th>操作</th>
            </tr>
            </thead>
            {foreach $data['rows'] as $k=>$v}
                <tr>
                    <td>{$v['id']}</td>
                    <td><a href="?search[title]={$v['name']}">{$v['name']}</a></td>
                    <td><a href="?search[title]={$v['city']}">{$v['city']}</a></td>
                    <td>{$v['contact']}</td>
                    <td>{$v['update_time']}</td>
                    <td>
                        <a href="?action=edit&id={$v['id']}" class="btn btn-info btn-xs"><i
                                    class="fa fa-pencil"></i>修改</a>&nbsp;&nbsp;
                        <a href="?action=delete&id={$v['id']}" class="btn btn-danger btn-xs"><i
                                    class="fa fa-trash-o"></i>
                            删除</a>
                    </td>
                </tr>
            {/foreach}
            </thead>
            <tbody>

        </table>
        <div class="pull-left" style="width:30%; padding: 10px 0;">

        </div>
        <div class="pull-right">
            <ul class="pagination">
                {if $data['page']['dpll']}
                    <li class="prev">
                        <a href="{$data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li class="prev">
                        <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i
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
                {for $i=$data['page']['dpl'] to $data['page']['dpr']}
                    <li{if $i==$data['page']['dp']} class="active"{/if}>
                        <a href="{$data['page']['dup']}{$i}">{$i}</a>
                    </li>
                {/for}
                <li class="disabled">
                    <a> {$data['page']['dtp']}
                        ( {$data['page']['dp']*$data['page']['dn']}
                        /{$data['page']['dt']} )</a>
                </li>

                {if $data['page']['dprr']}
                    <li class="next">
                        <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i
                                    class="fa fa-angle-right"></i></a>
                    </li>
                    <li class="next">
                        <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i
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

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
</body>
<!-- END BODY -->
</html>