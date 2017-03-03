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
    <link href="style/media.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="pull-left" style="width:30%; padding: 10px 0;">
    <form action="?" method="post">
        <input type="hidden" name="type" value="{$type}">
        <div class="input-group">
            <input type="text" class="form-control" placeholder="表单名称" name="search[title]" value="{$_REQUEST['search']['title']}">
<span class="input-group-btn">
<button class="btn btn-info" type="submit">
    <i class="fa fa-search"></i>
</button>
</span>
        </div>
    </form>
    </div>
<div class="portlet" >
    <div class="portlet-title" style="padding: 6px;">
        <div class="caption">
            <i class="fa fa-comments"></i>
            表单列表
        </div>
            <a style="float: right;padding: 3px;"class="btn btn-success" href="?action=add"><i class="fa fa-plus"></i>添加</a>
    </div>

    <div class="portlet-body">

        {*<ul class="nav nav-tabs">*}
            {*<li class="{if $type=='normal'}active{/if}">*}
                {*<a href="?action=list&type=normal&search[title]={$_REQUEST['search']['title']}">正常</a>*}
            {*</li>*}
            {*<li class="{if $type=='close'}active{/if}">*}
                {*<a href="?action=list&type=close&search[title]={$_REQUEST['search']['title']}">已关闭</a>*}
            {*</li>*}
        {*</ul>*}
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th class="list_none">ID</th>
                    <th>表单名称</th>
                    <th class="list_none">必填字段</th>
                    <th class="list_none">反馈邮箱</th>
                    <th class="list_none">邮箱字段</th>
                    <th>创建时间</th>
                    <th>表单有效期</th>
                    <th>提交数量</th>
                    <th>操作</th>
                </tr>
                </thead>
                {foreach $data['rows'] as $k=>$v}
                <tr>
                    <td class="list_none">{$v['id']}</td>
                    <td><a href="?action=detail&id={$v['id']}">{$v['form']}</a></td>
                    <td class="list_none">{foreach $v['field'] as $kk=>$vv}
                            {$vv}
                    {/foreach}、</td>
                    <td class="list_none">{$v['backemail']}</td>
                    <td class="list_none">{$v['email']}</td>
                    <td>{date('Y-m-d',$v['update_time'])}</td>
                    <td>{if !empty($v['start_time'])}{date('Y-m-d',$v['start_time'])}{/if}
                        {if !empty($v['start_time'])&&!empty($v['end_time'])}
                            --
                        {/if}
                        {if !empty($v['end_time'])}{date('Y-m-d',$v['end_time'])}{/if}
                        {if empty($v['start_time']) && empty($v['end_time'])}-----{/if}
                        {if !empty($v['end_time']) && $v['end_time']<time()}
                            <span class="btn btn-warning btn-xs">活动已过期</span>
                        {/if}
                    </td>
                    <td>{$v['sum']}</td>
                    <td>
                        {if $v['status']!=-1}
                        <a href="?action=edit&id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i>修改</a>&nbsp;&nbsp;
                        <a href="?action=detail&id={$v['id']}" class="btn btn-success btn-xs" {if $v['sum']=='0 条'}disabled{/if}><i class="fa fa-eye"></i>详情</a>&nbsp;&nbsp;
                        {*<a href="?action=close&id={$v['id']}" class="btn btn-danger btn-xs" ><i class="fa fa-trash-o"></i>关闭</a>&nbsp;&nbsp;*}
                       {*{else}*}
                            {*<a href="?action=restore&id={$v['id']}" class="btn btn-success btn-xs" ><i class="fa fa-rotate-left"></i>恢复</a>&nbsp;&nbsp;*}
                        {/if}
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
                            <a href="{$data['page']['dup']}{$data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
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
                            <a href="{$data['page']['dup']}{$data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                        </li>
                        <li class="next">
                            <a href="{$data['page']['dup']}{$data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
</script>
</body>
<!-- END BODY -->
</html>