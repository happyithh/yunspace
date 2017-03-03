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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
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
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <div style="padding: 10px 0 ">
                <div class="clearfix"></div>
                <form action="?" method="get" class="form-horizontal">
                    {*<div class="form-group">*}
                        {*<input type="text" class="form-control" placeholder="ID / 关键词" name="search[title]" value="{$_REQUEST['search']['title']}">*}
                    {*</div>*}
                    {*<button type="submit" class="btn btn-primary">*}
                        {*<i class="fa fa-search"></i>*}
                        {*搜索*}
                    {*</button>*}
                    <div class="form-body clearfix">
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">账户ID/名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="账户ID / 名称" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">手机号</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="手机号" name="search[phone]" value="{$_REQUEST['search']['phone']}">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">邮箱</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="邮箱" name="search[email]" value="{$_REQUEST['search']['email']}">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">更新时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间" name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间" name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                        </div>
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="tab-pane active">
                <table class="table table-striped table-bordered table-advance table-hover table-service">
                    <thead>
                    <tr>
                        <th>#ID</th>
                        <th>账户名</th>
                        <th>手机号</th>
                        <th>邮箱</th>
                        <th>修改时间</th>
                        {if $handle_type=='reject'}
                            <th>拒绝原因</th>
                        {/if}
                        {if $handle_type=='waiting'}
                        <th>操作</th>
                        {/if}
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
                                    {$pv['username']}
                                </label>
                            </td>
                            <td>
                                <label>
                                {$pv['phone']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    {$pv['email']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    {date('Y-m-d H:i:s',$pv['register_time'])}
                                </label>
                            </td>
                            {if $pv['status'] == 3}
                                <td>
                                    <label>
                                        {$pv['attr']['refuse_reason']}
                                    </label>
                                </td>
                            {/if}
                            {if $pv['status']==2}
                            <td>
                                <a href="?action=detail&id={$pv['id']}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>
                                    审核</a>
                            </td>
                            {/if}
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
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
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