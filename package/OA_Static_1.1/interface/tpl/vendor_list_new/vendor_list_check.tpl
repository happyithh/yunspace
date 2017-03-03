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
                            <label class="col-md-3 control-label">供应商名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="供应商ID / 名称"
                                       name="search[title]" value="{$_REQUEST['search']['title']}">
                            </div>
                        </div>
                        {if $_REQUEST['department']!=2}
                            <div class="form-group col-md-5">
                                <label class="col-md-3 control-label">负责人</label>

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
                            <label class="col-md-3 control-label">服务分类</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[category_id]">
                                    <option value=0>不限
                                    </option>
                                    {function show_category level=0}
                                        {foreach $categoryList[$id] as $k=>$v}
                                            {if $v||$k==$_REQUEST['search']['category_id']}
                                                <option value="{$k}"
                                                        {if $k==$_REQUEST['search']['category_id']}selected="selected" {/if}>{str_repeat('&nbsp; ', $lv)}
                                                    {$v}
                                                </option>
                                                {if $categoryList[$k]}
                                                    {show_category data=$categoryList id=$k lv=$lv+1}
                                                {/if}
                                            {/if}
                                        {/foreach}
                                    {/function}
                                    {show_category data=$categoryList id=0 lv=1}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">创建时间</label>

                            <div class="col-md-3">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>
                            </div>
                            <div class="col-md-3 ">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>
                            </div>
                            {if !empty($weeks)}
                            <div class="col-md-3 com-md-offset-1">
                                <select class="form-control" name="search[weeks]">
                                <option value=0>请选择时间范围</option>
                                    {foreach $weeks as $k=>$v}
                                    <option value='{$v}'{if $v==$_REQUEST['search']['weeks']}selected="selected"{/if}>
                                        {$v}
                                    </option>
                                    {/foreach}
                                    </select>
                            </div>
                            {/if}
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">更新时间</label>

                            <div class="col-md-3">
                                <input type='text' class="form-control date" placeholder="请选择开始时间"
                                       name="search[update_start_time]" value="{$_REQUEST['search']['update_start_time']}"/>
                            </div>
                            <div class="col-md-3">
                                <input type='text' class="form-control date" placeholder="请选择结束时间"
                                       name="search[update_end_time]" value="{$_REQUEST['search']['update_end_time']}"/>
                            </div>
                            {if !empty($weeks)}
                                <div class="col-md-3 com-md-offset-1">
                                    <select class="form-control" name="search[update_weeks]">
                                        <option value=0>请选择时间范围</option>
                                        {foreach $weeks as $k=>$v}
                                            <option value='{$v}'{if $v==$_REQUEST['search']['update_weeks']}selected="selected"{/if}>
                                                {$v}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                            {/if}
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
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-comments"></i>
                所有待审核供应商列表
        </div>
    </div>
    <div class="portlet-tabs">
        <ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">
            <li class="{if $handle_type=='other'}active{/if}">
                <a href="?handle_type=other{if !empty($urls)}&{$urls}{/if}">正常创建</a>
            </li>
            <li class="{if $handle_type=='quick'}active{/if}">
                <a href="?handle_type=quick{if !empty($urls)}&{$urls}{/if}">快速创建</a>
            </li>
            <li class="{if $handle_type=='all'}active{/if}">
                <a href="?handle_type=all{if !empty($urls)}&{$urls}{/if}">全部</a>
            </li>
        </ul>
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>供应商ID</th>
                    <th>供应商名称</th>
                    <th>负责人</th>
                    <th>产品总数</th>
                    <th>服务类型</th>
                    <th>创建时间</th>
                    <th>更新时间</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $_data['rows'] as $k=>$v}
                    <tr>
                        <td>{$v['id']}</td>
                        <td>
                            {$v['vendor_name']}
                            {if $v['create_by_quick']==1}
                                (后台快速创建)
                            {/if} {if $v['create_by_quick']==2}
                                (供应商加盟)
                            {/if}
                            {if $v['create_by_quick'] == 3}
                            (数据采集)
                            {/if}
                        </td>
                        <td>{$_adminInfo[$v['admin_id']]}</td>
                        <td>{if $v['count_product']}{$v['count_product']}{else}-----{/if}</td>
                        <td>
                            {foreach $v['category_arr'] as $ck=>$cv}
                                {$categoryInfo[$cv][0]}&nbsp;
                            {/foreach}
                        </td>
                        <td>{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td>{date('Y-m-d H:i:s',$v['update_time'])}</td>
                        <td>
                            {if $v['status']==2 || $v['status']==4}
                                <a href="?action=waiting&vendor_id={$v['id']}&admin_name={$_adminInfo[$v['admin_id']]}"
                                   class="btn btn-xs btn-warning">审核</a>
                            {/if}
                            <a href="?action=detail&tab=vendor&vendor_id={$v['id']}"
                               class="btn btn-success btn-xs"><i class="fa fa-pencil"></i>查看</a>
                        </td>
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