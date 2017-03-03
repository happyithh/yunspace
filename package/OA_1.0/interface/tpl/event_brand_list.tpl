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


<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>搜索条件
        </div>
    </div>
    <div class="portlet-body">
        <div class="portlet-tabs">
            <div class="clearfix"></div>
            <div>
                <form action="?" method="get" class="clearfix">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">品牌名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="品牌ID / 名称"
                                       name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        {if $_REQUEST['department']!=2}
                            <div class="form-group col-md-5">
                                <label class="col-md-3 control-label">当前状态</label>

                                <div class="col-md-9">
                                    <select class="form-control input-sm" name="search[admin_id]">
                                        <option value=0>全部
                                        </option>
                                        {foreach $_adminInfo as $key=>$value}
                                            <option {if {$_REQUEST['search']['admin_id']==$key}}selected {/if}
                                                    value="{$key}">{$value}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                        {/if}

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-4">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-4 col-md-offset-1">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
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

        </div>
    </div>
</div>
<div class="portlet">
    {*<div class="portlet-title">*}
    {*<div class="caption">*}
    {*<i class="fa fa-comments"></i>*}
    {*{if $_REQUEST['department']==1}*}
    {*部门供应商列表*}
    {*{elseif $_REQUEST['department']==2}*}
    {*我的供应商列表*}
    {*{else}*}
    {*所有供应商列表*}
    {*{/if}*}
    {*</div>*}
    {*</div>*}

    {*<div class="portlet-tabs">*}
    {*<ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">*}
    {*<li class="{if $handle_type=='reject'}active{/if}">*}
    {*<a href="?{if !empty($_REQUEST['search'])}handle_type=online{$urls}{else}list_type=vendor&handle_type=reject{/if}">审核拒绝</a>*}
    {*</li>*}
    {*<li class="{if $handle_type=='waiting'}active{/if}">*}
    {*<a href="?{if !empty($_REQUEST['search'])}handle_type=waiting{$urls}{else}list_type=vendor&handle_type=waiting{/if}">审核中</a>*}
    {*</li>*}
    {*<li class="{if $handle_type=='offline'}active{/if}">*}
    {*<a href="?{if !empty($_REQUEST['search'])}handle_type=offline{$urls}{else}list_type=vendor&handle_type=offline{/if}">下线</a>*}
    {*</li>*}
    {*<li class="{if $handle_type=='online'}active{/if}">*}
    {*<a href="?{if !empty($_REQUEST['search'])}handle_type=offline{$urls}{else}list_type=vendor&handle_type=online{/if}">上线</a>*}
    {*</li>*}
    {*<li class="{if $handle_type=='all'}active{/if}">*}
    {*<a href="?{if !empty($_REQUEST['search'])}handle_type=all{$urls}{else}list_type=vendor&handle_type=all{/if}">全部</a>*}
    {*</li>*}
    {*</ul>*}
    {*</div>*}
    <div class="portlet-body">
        <div style=" margin-bottom: 10px;">
            <a href="?action=add" class="btn btn-success"><span
                        class="glyphicon glyphicon-plus"></span>添加品牌</a>
        </div>

        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th class="list_none">品牌名称</th>
                    <th>当前状态</th>
                    <th>更新时间</th>
                    <th class="list_none">操作</th>
                    {*<th  class="list_none">服务类型</th>*}
                    {*<th class="list_none">创建时间</th>*}
                    {*<th>更新时间</th>*}
                    {*<th>状态</th>*}
                    {*<th>操作</th>*}
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td class="list_none">{$v['event_name']}</td>
                        <td>
                            {if $v['status'] == 0}下线
                            {elseif $v['status'] == 1}上线
                            {elseif $v['status'] == 2}审核中
                            {elseif $v['status'] == 3}审核拒绝
                            {elseif $v['status'] == 4}上线（存在待审核商品）
                            {/if}
                        </td>
                        <td>{date('Y-m-d H:i:s', $v['update_time'])}</td>
                        <td>
                            <!-- {if $v['id']}
                            <a href="?action=detail&id={$v['id']}" class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>查看</a>
                            {/if} -->
                            {if $v['status']!=98&&$v['status']!=99}
                                <a href="?action=edit&ids[]={$v['id']}"
                                   class="btn btn-danger btn-xs"><i class="fa fa-pencil"></i>编辑</a>
                            {/if}
                            {if $v['status']!=99}
                                <a href="?action=del&ids[]={$v['id']}"
                                   class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>
                            {/if}
                        </td>

                        {*<td  class="list_none">*}
                        {*{foreach $v['category_arr'] as $ck=>$cv}*}
                        {*{$categoryInfo[$cv][0]}&nbsp;*}
                        {*{/foreach}*}
                        {*</td>*}
                        {*<td  class="list_none">{date('Y-m-d H:i:s',$v['create_time'])}</td>*}
                        {*<td>{date('Y-m-d H:i:s',$v['update_time'])}</td>*}
                        {*<td>{if $v['status'] == 0}下线*}
                        {*{elseif $v['status'] == 1}上线*}
                        {*{elseif $v['status'] == 2}审核中*}
                        {*{elseif $v['status'] == 3}审核拒绝*}
                        {*{elseif $v['status'] == 4}上线（存在待审核商品）*}
                        {*{/if}*}
                        {*</td>*}
                        {*<td>*}
                        {*{if $v['vendor_account_id']}*}
                        {*<a href="?action=detail&tab=vendor&vendor_id={$v['vendor_id']}&id={$v['vendor_account_id']}"*}
                        {*class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>查看</a>*}
                        {*{/if}*}
                        {*</td>*}
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">
            </div>
            <div class="pull-right">
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
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
                            /{$_data['page']['dt']} )</a>
                    </li>

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

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
</script>
</body>
<!-- END BODY -->
</html>