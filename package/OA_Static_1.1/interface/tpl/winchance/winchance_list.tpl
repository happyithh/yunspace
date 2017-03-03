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
                <form action="?" method="get" class="clearfix form_search">
                    {*<input type="hidden" name="list_type" value="product">*}
                    {*<input type="hidden" name="handle_type" value="{$handle_type}">*}
                    <input type="hidden" name="action" class="action_input" value="">
                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">资源的名称</label>

                            <div class="col-md-9">
                                <input type="text" class="form-control input-sm" placeholder="资源的名称/ID" name="search[resource_name]" value="{$_REQUEST['search']['resource_name']}">
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">云负责人</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[yun_principal]">
                                    <option value=''>全部</option>
                                    {foreach $yun_principal as $key=>$value}
                                        <option {if $_REQUEST['search']['yun_principal']==$key}selected {/if} value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">所属栏目</label>*}

                            {*<div class="col-md-9">*}
                                {*<select class="form-control input-sm" name="search[category_id]">*}
                                    {*<option value=''>全部</option>*}
                                    {*{foreach $category_name as $key=>$value}*}
                                        {*<option {if {$_REQUEST['search']['category_id']==$value['id']}}selected {/if} value="{$value['id']}">{if $value['parent']==0}{$value['name']}{else}&nbsp;&nbsp;---{$value['name']}{/if}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                            {*</div>*}
                        {*</div>*}
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">状态</label>*}
                            {*<div class="col-md-9">*}
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                {*<select class="form-control input-sm" name="search[status]">*}
                                    {*<option value=''>全部*}
                                    {*</option>*}
                                    {*{foreach $status as $key=>$value}*}
                                        {*<option {if {$_REQUEST['search']['status']==$key}}selected {/if} value="{$key}">{$value}</option>*}
                                    {*{/foreach}*}
                                {*</select>*}
                            {*</div>*}
                        {*</div>*}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">分类</label>
                            <div class="col-md-9">
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                <select class="form-control input-sm" name="search[category]">
                                    <option value=''>全部</option>
                                    {foreach $category as $key=>$value}
                                        <option {if $_REQUEST['search']['category']==$key}selected {/if} value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">表现形式</label>
                            <div class="col-md-9">
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                <select class="form-control input-sm" name="search[manifestation]">
                                    <option value=''>全部</option>
                                    {foreach $manifestation as $key=>$value}
                                        <option {if $_REQUEST['search']['manifestation']==$value}selected {/if} value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">运营范围</label>
                            <div class="col-md-9">
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                <select class="form-control input-sm" name="search[operation_range]">
                                    <option value=''>全部</option>
                                    {foreach $city_array as $key=>$value}
                                        <option {if $_REQUEST['search']['operation_range']==$value}selected {/if} value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">合作状态</label>
                            <div class="col-md-9">
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                <select class="form-control input-sm" name="search[cooperating_state]">
                                    <option value=''>全部</option>
                                    {foreach $cooperating_state_array as $key=>$value}
                                        <option {if $_REQUEST['search']['cooperating_state']==$value}selected {/if} value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">合作模式</label>
                            <div class="col-md-9">
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                <select class="form-control input-sm" name="search[cooperating_mode]">
                                    <option value=''>全部</option>
                                    {foreach $cooperating_mode_array as $key=>$value}
                                        <option {if $_REQUEST['search']['cooperating_mode']==$value}selected {/if} value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">关键词</label>*}
                            {*<div class="col-md-9">*}
                                {*<input type="text" class="form-control input-sm" placeholder="关键词" name="search[tags_info]" value="{$_REQUEST['search']['tags_info']}">*}
                            {*</div>*}
                        {*</div>*}
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">面积</label>
                            <div class="col-md-9">
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                <select class="form-control input-sm" name="search[area]">
                                    <option value=''>全部</option>
                                    {foreach $area_array as $key=>$value}
                                        <option {if $_REQUEST['search']['area']==$key}selected {/if} value="{$key}">{$value}</option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>


                        {*<div class="form-group col-md-5">*}
                            {*<label class="col-md-3 control-label">创建时间</label>*}
                            {*<div class="col-md-4">*}
                                {*<input type='text' class="form-control date" placeholder="请选择开始时间" name="search[start_time]" value="{$_REQUEST['search']['start_time']}"/>*}
                            {*</div>*}
                            {*<div class="col-md-4 col-md-offset-1">*}
                                {*<input type='text' class="form-control date" placeholder="请选择结束时间" name="search[end_time]" value="{$_REQUEST['search']['end_time']}"/>*}
                            {*</div>*}
                        {*</div>*}
                    </div>
                    <div class="form-actions">
                        <div class="" style="text-align: center">
                            <button type="submit" class="btn btn-primary" style="width: 150px">
                                <i class="fa fa-search"></i>
                                搜索
                            </button>
                            <button type="button" class="btn btn-success export" style="width: 150px;margin-left: 20px;">
                                <i class="fa fa-sign-out"></i>
                                导出
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
    </div>
    <div class="portlet-tabs" style="position:relative">
        <div style="position: absolute;left:10px;bottom:0px;color: #444444;font-size: 16px"><a href="?action=add" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span>添加文创</a></div>
        {*<div style="position: absolute;left:150px;bottom:0px;color: #444444;font-size: 16px"><a href="?action=convert_baike" class="btn btn-primary">一键转换为百科</a></div>*}
        {*<ul class="nav nav-tabs" style="overflow: inherit; padding-left: 100px">*}
            {*<li class="{if $handle_type=='hand_insert'}active{/if}">*}
                {*<a href="?{if !empty($_REQUEST['search'])}handle_type=hand_insert&{$urls}{else}handle_type=hand_insert{/if}">手动录入</a>*}
            {*</li>*}
            {*<li class="{if $handle_type=='auto_insert'}active{/if}">*}
                {*<a href="?{if !empty($_REQUEST['search'])}handle_type=auto_insert&{$urls}{else}handle_type=auto_insert{/if}">自动采集</a>*}
            {*</li>*}
            {*<li class="{if $handle_type=='all'}active{/if}">*}
                {*<a href="?{if !empty($_REQUEST['search'])}handle_type=all&{$urls}{else}handle_type=all{/if}">全部</a>*}
            {*</li>*}
        {*</ul>*}
    </div>
    <div class="portlet-body">
        <div class="table-responsive clearfix">
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>#ID</th>
                    <th width="10%">文创名称（临时）</th>
                    <th width="10%">资源的名称</th>
                    <th>云负责人</th>
                    <th>分类</th>
                    <th>表现形式</th>
                    <th>运营范围</th>
                    <th>合作状态</th>
                    <th>合作模式</th>
                    <th width="10%">符合人群</th>
                    <th width="10%">关键词</th>
                    <th>面积</th>
                    {*<th>所属栏目</th>*}
                    {*<th>状态</th>*}
                    {*<th>创建时间</th>*}
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $data['rows'] as $key=>$value}
                    <tr>
                        <td>#{$value['id']}</td>
                        <td>{$value['title']}</td>
                        <td>
                            {*{if mb_strlen($value['title'],'UTF-8')>40}*}
                                {*<a href="#" target="_blank" >{mb_substr($value['title'],0,39,'utf-8')}...</a*}
                            {*{else}*}
                                {*<a href="#" target="_blank" >{$value['title']}</a>*}
                            {*{/if}*}
                            {*{if mb_strlen($value['resource_name'],'UTF-8')>40}*}
                                {*{mb_substr($value['resource_name'],0,39,'utf-8')}...*}
                            {*{else}*}
                                {$value['resource_name']}
                            {*{/if}*}
                        </td>
                        <td>{$value['yun_principal']}</td>
                        <td>{$value['category']}</td>
                        <td>{$value['manifestation']}</td>
                        <td>{$value['operation_range']}</td>
                        <td>{$value['cooperating_state']}</td>
                        <td>{$value['cooperating_mode']}</td>
                        <td>{$value['conform_crowd']}</td>
                        <td>{$value['tags_info']}</td>
                        <td>{$value['area']}平方米</td>
                        {*<td>{if $value['status']==1}上线{else}下线{/if}</td>*}
                        {*<td> <select class="form-control select2me input-sm" data-id="{$value['id']}" onchange="ListOperator.online(this)">*}
                                {*{foreach $status as $key =>$val}*}
                                    {*<option {if $key == $value['status']}selected{/if} value="{$key}">{$val}</option>*}
                                {*{/foreach}*}
                            {*</select>*}
                        {*</td>*}

                        {*<td>{date('Y-m-d H:i:s',$value['create_time'])}</td>*}
                        <td><a href="?action=edit&id={$value['id']}" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i>修改</a>&nbsp;
                            <a href="?action=delete&id={$value['id']}" onclick="return confirm('您确定要删除吗？？')" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i>删除</a>&nbsp;

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

<script tab="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>

<script>
    ListOperator = {

        online: function (obj) {
            var status = $(obj).find('option:selected').val();
            var id =$(obj).attr('data-id');
            $.getJSON('?', {
                id: id,
                status: status,
                action:'update_status'
            }, function (data) {
                top.alert(data.msg);
            })
        },
        changeCategory: function (o) {

            var category_id = $(o).find('option:selected').val();
            var id =$(o).attr('data-id');
            if (!category_id) {
                category_id = $(o).find('td:first').val();
            }
            $.post("?", {
                id: id,
                category_id: category_id,
                action:'update_category'
            }, function (data) {
                top.alert(data.msg);
                window.location.reload();
            });
        },
//        delProductSet: function (e) {
//            if (!confirm('您确定要删除吗？？')) {
//                return false;
//            }
//        },
        updatePageView: function(id){
            $.post("?", {
                id: id,
                action: 'update_pv'
            }, function(data) {
                top.alert(data.msg);
                window.location.reload();
            });
        }
    }
    $(document).ready(function(){
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    })
    $(".export").click(function(){
        $(".action_input").val('export');
        $('.form_search').submit();
//        return false;

    });

</script>
</body>
<!-- END BODY -->
</html>