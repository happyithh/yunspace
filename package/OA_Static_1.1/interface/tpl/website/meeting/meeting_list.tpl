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
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background:#FaFaFa !important;min-height: 500px;">
<div class="portlet">
    <div class="portlet-title" style="height: 50px;">
        <div class="caption " style="height: 40px;line-height: 35px;">
            <i class="fa fa-reorder"></i>套餐列表
        </div>
        <div class="btn-group pull-right">
            <a href="?action=category_list" class="btn btn-info" style="margin-right: 50px;">管理套餐分类</a>
            <a href="?action=add" class="btn btn-success">添加新套餐</a>
        </div>
    </div>
    <div class="portlet-body" style="height: auto;">
        <ul class="nav nav-pills">
            {*<li {if $status==1}class="active"{/if}>*}
                {*<a href="?action=list&status=1" data-toggle="tab">上线</a>*}
            {*</li>*}
            {*<li {if $status==0}class="active"{/if}>*}
                {*<a href="?action=list&status=0" data-toggle="tab">下线</a>*}
            {*</li>*}
            {*<li {if $status==-1}class="active"{/if}>*}
                {*<a href="?action=list&status=-1" data-toggle="tab">已删除</a>*}
            {*</li>*}
        </ul>
        <div class="table-responsive" style="border: 0px;">
            <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr>
                    <th style="width: 5%;">#id</th>
                    <th style="width: 8%;">城市</th>
                    <th style="width: 10%;">套餐分类</th>
                    <th style="width: 15%;">场地名称</th>
                    <th style="width: 15%;"> 空间名称</th>
                    <th style="width: 7%;">状态</th>
                    <th style="width: 10%;">套餐有效期</th>
                    <th style="width: 20%;">创建时间</th>
                    <th style="width: 10%;">操作</th>
                </tr>
                <form action="?action=list" method="post" class="clearfix form-horizontal" >
                <tr role="row" class="filter">
                    <td rowspan="1" colspan="1"> <input type="text" class="form-control form-filter input-sm" name="search[id]" value="{$search['id']}"></td>
                    <td rowspan="1" colspan="1"> <input type="text" class="form-control form-filter input-sm" name="search[city]" value="{$search['city']}"></td>
                    <td rowspan="1" colspan="1">
                        <select class="form-control input-sm" name="search[category]">
                            <option value=''{if !isset($search['category'])}selected{/if}>全部</option>
                            {foreach $category_list as $k=>$v}
                                <option {if isset($search['category'])&&$search['category']==$v['category']}selected {/if} value='{$v['category']}'>{$v['category']}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td rowspan="1" colspan="1"> <input type="text" class="form-control form-filter input-sm" name="search[space_name]" value="{$search['space_name']}"></td>
                    <td rowspan="1" colspan="1"> <input type="text" class="form-control form-filter input-sm" name="search[item_name]" value="{$search['item_name']}"></td>
                    <td rowspan="1" colspan="1">
                        {*<input type="text" class="form-control form-filter input-sm" name="status">*}
                        <select class="form-control input-sm" name="search[status]">
                            <option value='all' {if $search['status']=='all'}selected{/if}>全部</option>
                            <option {if isset($search['status'])&&$search['status']==1}selected {/if} value=1>上线</option>
                            <option {if isset($search['status'])&&$search['status']==0}selected {/if} value=0>下线</option>
                            {*<option {if $search['status']==-2}selected {/if} value=-2>已删除</option>*}

                        </select>
                    </td>
                    <td rowspan="1" colspan="1"></td>
                    {*<td rowspan="1" colspan="1">*}
                        {*<input type="text" class="form-control form-filter input-sm" name="status">*}
                    {*</td>*}
                    <td rowspan="1" colspan="1">
                        <div class="col-md-6">
                            <input type='text' class="form-control date" placeholder="请选择开始时间"
                                   name="search[start_time]" value="{$search['start_time']}"/>
                        </div>
                        <div class="col-md-6">
                            <input type='text' class="form-control date" placeholder="请选择结束时间"
                                   name="search[end_time]" value="{$search['end_time']}"/>
                        </div>
                    </td>
                    <td rowspan="1" colspan="1">
                        <button class="btn btn-sm btn-warning filter-submit margin-bottom" type="submit"><i class="fa fa-search"></i>搜索
                        </button></td>
                    {*<td rowspan="1" colspan="1">*}
                        {*<div class="input-group input-group-sm date date-picker margin-bottom-5" data-date-format="dd/mm/yyyy">*}
                            {*<input type="text" class="form-control form-filter" readonly="" name="order_date_from" placeholder="From">*}
											{*<span class="input-group-btn">*}
											{*<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i>*}
                                            {*</button>*}
											{*</span>*}
                        {*</div>*}
                        {*<div class="input-group input-group-sm date date-picker" data-date-format="dd/mm/yyyy">*}
                            {*<input type="text" class="form-control form-filter" readonly="" name="order_date_to" placeholder="To">*}
											{*<span class="input-group-btn">*}
											{*<button class="btn btn-default" type="button"><i class="fa fa-calendar"></i>*}
                                            {*</button>*}
											{*</span>*}
                        {*</div>*}
                    {*</td>*}
                    {*<td rowspan="1" colspan="1">*}
                        {*<input type="text" class="form-control form-filter input-sm" name="order_customer_name">*}
                    {*</td><td rowspan="1" colspan="1">*}
                        {*<input type="text" class="form-control form-filter input-sm" name="order_ship_to">*}
                    {*</td><td rowspan="1" colspan="1">*}
                        {*<div class="margin-bottom-5">*}
                            {*<input type="text" class="form-control form-filter input-sm" name="order_price_from" placeholder="From">*}
                        {*</div>*}
                        {*<input type="text" class="form-control form-filter input-sm" name="order_price_to" placeholder="To">*}
                    {*</td><td rowspan="1" colspan="1">*}
                        {*<div class="margin-bottom-5">*}
                            {*<input type="text" class="form-control form-filter input-sm margin-bottom-5 clearfix" name="order_quantity_from" placeholder="From">*}
                        {*</div>*}
                        {*<input type="text" class="form-control form-filter input-sm" name="order_quantity_to" placeholder="To">*}
                    {*</td><td rowspan="1" colspan="1">*}
                        {*<select name="order_status" class="form-control form-filter input-sm">*}
                            {*<option value="">Select...</option>*}
                            {*<option value="pending">Pending</option>*}
                            {*<option value="closed">Closed</option>*}
                            {*<option value="hold">On Hold</option>*}
                            {*<option value="fraud">Fraud</option>*}
                        {*</select>*}
                    {*</td><td rowspan="1" colspan="1">*}
                        {*<div class="margin-bottom-5">*}
                            {*<button class="btn btn-sm btn-warning filter-submit margin-bottom"><i class="fa fa-search"></i>Search*}
                            {*</button>*}
                        {*</div>*}
                        {*<button class="btn btn-sm btn-danger filter-cancel"><i class="fa fa-times"></i>Reset*}
                        {*</button>*}
                    {*</td>*}
                </tr>
                </form>
                {*<form action="?action=submit_edit" method="post" class="clearfix form-horizontal" >*}
                    {*<tr>*}
                        {*<th> <input type="text"  name="search['id']" value=""></th>*}
                        {*<th>城市</th>*}
                        {*<th >套餐分类</th>*}
                        {*<th>场地名称</th>*}
                        {*<th> 空间名称</th>*}
                        {*<th >状态</th>*}
                        {*<th >活动起止时间</th>*}
                        {*<th>创建时间</th>*}
                        {*<th>操作</th>*}
                    {*</tr>*}
                {*</form>*}
                </thead>
                <tbody>
                {foreach $_data['rows'] as $v}
                    <tr>
                        <td>#{$v['id']}</td>
                        <td>{$v['city']}</td>
                        <td>{$v['category']}</td>
                        <td>{$v['space_name']}</td>
                        <td>{$v['item_name']}</td>
                        <td>{$v['status']}</td>
                        <td>{$v['start_time']}--{$v['end_time']}</td>
                        <td >{date('Y-m-d H:i',$v['create_time'])}</td>
                        <!--<td><a href="?action=edit&id={$v['id']}">点击查看门票详情</a></td>-->
                        <td>
                            <a href="?action=edit&id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-edit"></i>修改</a>
                            {*{if $status ==1}*}
                                {*<a href="?action=edit&id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-edit"></i>修改</a>*}
                                {*<a href="?action=eventStatus&handle=down&id={$v['id']}" class="btn btn-warning btn-xs"><i class="fa fa-level-down"></i> 下线</a>*}
                                {*<a href="?action=eventStatus&handle=del&id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>*}
                            {*{/if}*}
                            {*{if $status ==0}*}
                                {*<a href="?action=edit&id={$v['id']}" class="btn btn-info btn-xs"><i class="fa fa-edit"></i>修改</a>*}
                                {*<a href="?action=eventStatus&handle=up&id={$v['id']}" class="btn btn-success btn-xs"><i class="fa fa-check"></i> 上线</a>*}
                                {*<a href="?action=eventStatus&handle=del&id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>*}
                            {*{/if}*}
                            {*{if $status ==-1}*}
                                {*<a href="?action=eventStatus&handle=recover&id={$v['id']}" class="btn btn-primary btn-xs"><i class="fa fa-recycle"></i>恢复</a>*}
                                {*<a href="?action=eventRealDel&id={$v['id']}" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>彻底删除</a>*}
                            {*{/if}*}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div>
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
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
</script>
</body>
<!-- END BODY -->
</html>