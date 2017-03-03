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
            <li class="{if $handle_type=='pass'}active{/if}">
                <a href="?action=list&handle_type=pass">已审核</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <div style="padding: 10px 0 ">
                <div class="clearfix"></div>
                <form action="?" method="get" class="form-horizontal">
                    <input type="hidden" name="handle_type" value="{$handle_type}">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">账户名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="原账户名称 / 新账户名称" name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商名称" name="search[vendor_name]" value="{$_REQUEST['search']['vendor_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label class="col-md-3 control-label">操作者</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[admin_id]">
                                    <option value=0>全部
                                    </option>
                                    {foreach $_adminInfo as $key=>$value}
                                        <option {if {$_REQUEST['search']['admin_id']==$value['admin_id']}}selected {/if} value="{$value['admin_id']}">{$value['fullname']}</option>
                                    {/foreach}
                                </select>                            </div>
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
                        <th>供应商名称</th>
                        <th>原账户名</th>
                        <th>新账户名</th>
                        <th>操作者</th>
                        <th>创建时间</th>
                        <th>更新时间</th>
                        {if $handle_type != 'pass'}
                            <th>拒绝原因</th>
                        {/if}
                        {if $handle_type=='waiting'}
                            <th>操作</th>
                        {/if}
                    </tr>
                    </thead>
                    <tbody>
                    {foreach $data['rows'] as $pk=>$pv}
                        <tr>
                            <td>
                                <label>
                                    {$pv['id']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    {$pv['vendor_name']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    [{$pv['old_account_id']}]{$pv['old_account_name']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    [{$pv['new_account_id']}]{$pv['new_account_name']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    {$pv['admin_name']}
                                </label>
                            </td>
                            <td>
                                <label>
                                    {date('Y-m-d H:i:s',$pv['create_time'])}
                                </label>
                            </td>
                            <td>{date("Y-m-d H:i:s",$pv['update_time'])}</td>
                            {if $handle_type != 'pass'}
                                <td width="200">
                                    {if $handle_type=='waiting'}
                                        <textarea class="form-control refuse_reason" name="refuse_reason" rows="1" cols="25"></textarea>
                                    {else}
                                        {$pv['demo']}
                                    {/if}
                                </td>
                            {/if}
                            {if $pv['status']==0}
                            <td>
                                <a href="?action=pass&id={$pv['id']}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>
                                    审核通过</a>
                                <button type="button" class="btn btn-danger btn-xs" data-cid="{$pv['id']}" onclick="refuse(this)">拒绝</button>
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
    function refuse(o) {
        var cid=$(o).attr('data-cid');
        var refuse_reason=$('.refuse_reason').val();
        $.post('?',{ action:'refuse',id:cid,refuse_reason:refuse_reason },function(data){
           if(data.status==1){
               window.location.reload();
           }
            top.alert(data.msg);
        })
    }
</script>

</body>
<!-- END BODY -->
</html>