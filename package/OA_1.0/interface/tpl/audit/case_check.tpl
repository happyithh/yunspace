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
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">


<div class="portlet">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-database"></i>共有
            <span style="color: #ff0000">{$data['page']['dt']}</span>
            条{$page_name}记录
        </div>
    </div>
    <div class="portlet-tabs">

        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $handle_type=='reject'}active{/if}">
                <a href="?action=list&handle_type=reject">已拒绝</a>
            </li>
            <li class="{if $handle_type=='waiting'}active{/if}">
                <a href="?action=list&handle_type=waiting">待审核</a>
            </li>
            <li class="{if $handle_type=='passed'}active{/if}">
                <a href="?action=list&handle_type=passed">已审核</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <div style="padding: 10px 0 ">
                <form action="?action=list&handle_type=all" method="post" class="form-inline">
                    <div class="form-group">
                        <label class="sr-only">名称</label>
                        <input type="text" class="form-control" placeholder="ID / 名称" name="search[title]" value="{$_REQUEST['search']['username']}">
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fa fa-search"></i>
                        搜索
                    </button>
                </form>
            </div>
            <div class="tab-pane active">

                <table class="table table-striped table-bordered table-advance table-hover table-service">
                    <thead>
                    <tr>
                        <th>#ID</th>
                        <th>案例名称</th>
                        <th>活动名称</th>
                        <th>活动类型</th>
                        <th>行业类型</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $data['rows'] as $ek=>$ev}
                        <tr>
                            <td>{$ev['id']}</td>
                            <td>{$ev['case_name']}</td>
                            <td>{$ev['event_name']}</td>
                            <td>{$ev['attr']['活动类型']}</td>
                            <td>
                                {$ev['attr']['服务行业']}
                            </td>
                            <td>
                                <a href="?action=detail&id={$ev['id']}&handle_type={$handle_type}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i> 详情</a>
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
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
                                /{$data['page']['dt']}
                                )</a>
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
</div>
</body>
<!-- END BODY -->
</html>