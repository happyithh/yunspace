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
            <li class="{if $handle_type=='recycle'}active{/if}">
                <a href="?action=list&handle_type=recycle">回收站</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <div style="padding: 10px 0 ">
                <form action="?" method="get" class="form-inline">
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
                        <th>服务名称</th>
                        <th>服务类型</th>
                        <th>供应商名称</th>
                        <th>服务区域</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $data['rows'] as $pk=>$pv}
                        <tr data-pid="{$pv['id']}">
                            <td>
                                <label>
                                    {$pv['id']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    {$pv['product_name']}
                                </label>
                            </td>
                            <td>
                                <label>
                                {$pv['category_name']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    {$pv['vendor_name']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    {$pv['attr_new'][46]}
                                </label>
                            </td>
                            <td>
                                <label >
                                    {if $pv['status']==3 }
                                        <span class="label label-danger">拒绝</span>
                                    {elseif $pv['status']==2}
                                        <span class="label label-warning">待审核</span>
                                    {else}
                                        <span class="btn btn-success btn-xs">通过</span>
                                    {/if}
                                </label>
                            </td>
                            <td>
                                <a href="?action=detail&id={$pv['id']}&handle_type={$handle_type}" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>
                                    详情</a>
                                {if $handle_type=='recycle'}
                                    <a href="?action=list&id={$pv['id']}&handle_type=recover_product" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>恢复</a>
                                {/if}
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
<iframe style="width: 1px; height:1px;" width="1" height="1" hidden="hidden" src="{$_home}product_search/update_product_info_list"></iframe>
</body>
<!-- END BODY -->
</html>