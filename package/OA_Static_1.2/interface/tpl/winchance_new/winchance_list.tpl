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
    <link href="plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
    <link href="style/media.css" rel="stylesheet"/>
    <style>
        .reason {
            display:inline-block;
            background-color: #d9d9d9;
            padding: 6px;
            margin-top: 10px;
            height: auto;
            overflow: hidden;
            line-height: 20px;
        }

    </style>
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
<div class=" portlet-tabs">
<ul class="nav nav-tabs">
    <li {if $ip_type=='waiting'}class="active"{/if}>
        <a href="?action=list&ip_type=waiting">未入驻</a>
    </li>
    <li {if $ip_type=='done'|| !isset($ip_type)}class='active'{/if}>
        <a href="?action=list&ip_type=done">已入驻</a>
    </li>
</ul>

<div class="portlet-body" style="margin-top: -50px;">
    <form class="form-horizontal" role="form" action="?action=list" method="post">
        <div class="form-body">
            {if $ip_type=='waiting'}
                <div class="form-group">
                    <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">合作阶段</label>

                    <div class="col-md-10  col-xs-10">
                        <div class="radio-list">
                            <label class="radio-inline">
                                <input type="radio" name="search[step]" id="optionsRadios4" value=""
                                       {if !isset($_REQUEST['search']['step']) || empty($_REQUEST['search']['step'])}checked{/if}>全部
                            </label>
                            {foreach $step as $k=>$v}
                                <label class="radio-inline">
                                    <input type="radio" name="search[step]" id="optionsRadios4" value="{$k}"
                                           {if $_REQUEST['search']['step']==$k}checked{/if}>{$v}
                                </label>
                            {/foreach}
                        </div>
                    </div>
                </div>
            {/if}
            <div class="form-group">
                <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">云负责人</label>

                <div class="col-md-10  col-xs-10">
                    <div class="radio-list">
                        <label class="radio-inline">
                            <input type="radio" name="search[admin_id]" id="optionsRadios4" value=""
                                   {if !isset($_REQUEST['search']['admin_id']) || empty($_REQUEST['search']['admin_id'])}checked{/if}>全部
                        </label>
                        {foreach $admin as $k=>$v}
                            <label class="radio-inline">
                                <input type="radio" name="search[admin_id]" id="optionsRadios5" value="{$k}"
                                        {if $_REQUEST['search']['admin_id']==$k} checked{/if}> {$v['name']}
                            </label>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">分类</label>

                <div class="col-md-10  col-xs-10">
                    <div class="radio-list">
                        <label class="radio-inline">
                            <input type="radio" name="search[category]" id="optionsRadios5" value=""
                                   {if !isset($_REQUEST['search']['category']) || empty($_REQUEST['search']['category'])}checked{/if}>全部
                        </label>
                        {foreach $category as $k=>$v}
                            <label class="radio-inline">
                                <input type="radio" name="search[category]" id="optionsRadios4"
                                       value="{$v}" {if $_REQUEST['search']['category']==$v} checked{/if}>
                                {$v} </label>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">表现形式</label>

                <div class="col-md-10  col-xs-10">
                    <div class="radio-list">
                        <label class="radio-inline">
                            <input type="radio" name="search[manifestation]" id="optionsRadios5" value=""
                                   {if !isset($_REQUEST['search']['manifestation']) || empty($_REQUEST['search']['manifestation'])}checked{/if}>全部
                        </label>
                        {foreach $manifestation as $k=>$v}
                            <label class="radio-inline">
                                <input type="radio" name="search[manifestation]" id="optionsRadios4"
                                       value="{$v}" {if $_REQUEST['search']['manifestation']==$v} checked{/if}>
                                {$v} </label>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">运营范围</label>

                <div class="col-md-10  col-xs-10">
                    <div class="radio-list">
                        <label class="radio-inline">
                            <input type="radio" name="search[city]" id="optionsRadios5" value=""
                                   {if !isset($_REQUEST['search']['city']) || empty($_REQUEST['search']['city'])}checked{/if}>全部
                        </label>
                        {foreach $city as $k=>$v}
                            <label class="radio-inline">
                                <input type="radio" name="search[city]" id="optionsRadios4"
                                       value="{$v}" {if $_REQUEST['search']['city']==$v} checked{/if}>
                                {$v} </label>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">合作模式</label>

                <div class="col-md-10  col-xs-10">
                    <div class="radio-list">
                        <label class="radio-inline">
                            <input type="radio" name="search[cooperating_mode]" id="optionsRadios5" value=""
                                   {if !isset($_REQUEST['search']['cooperating_mode']) || empty($_REQUEST['search']['cooperating_mode'])}checked{/if}>全部
                        </label>
                        {foreach $cooperating_mode as $k=>$v}
                        <label class="radio-inline">
                            <input type="radio" name="search[cooperating_mode]" id="optionsRadios4"
                                   value="{$v}" {if $_REQUEST['search']['cooperating_mode']==$v} checked{/if}>{$v}
                        </label>
                        {/foreach}
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">面积</label>

                <div class="col-md-10 col-xs-10">
                    <div class="radio-list">
                        <label class="radio-inline">
                            <input type="radio" name="search[area]" id="optionsRadios5" value=""
                                   {if !isset($_REQUEST['search']['area']) || empty($_REQUEST['search']['area'])}checked{/if}>全部
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="search[area]" id="optionsRadios4" value="100"
                                    {if $_REQUEST['search']['area']=='100'} checked{/if}>100㎡以内
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="search[area]" id="optionsRadios5" value="100-500"
                                    {if $_REQUEST['search']['area']=='100-500'} checked{/if}>100-500㎡
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="search[area]" id="optionsRadios5" value="500-1000"
                                    {if $_REQUEST['search']['area']=='500-1000'} checked{/if}>500-1000㎡
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="search[area]" id="optionsRadios5" value="1000-3000"
                                    {if $_REQUEST['search']['area']=='1000-3000'} checked{/if}>1000-3000㎡
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="search[area]" id="optionsRadios5" value="3000"
                                    {if $_REQUEST['search']['area']=='3000'} checked{/if}>3000㎡以上
                        </label>

                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" name="ip_type" value="{$ip_type}">

        <div class="col-md-3 col-xs-4" style="min-width: 350px;">
            <div class="input-group">
                <input type="text" name="search[ip_name]" class="form-control" placeholder="输入IP名称或ID进行筛选"
                       value="{$_REQUEST['search']['ip_name']}">
            <span class="input-group-btn">
            <button class="btn btn-info" type="submit"><i class="fa fa-search"
                                                          aria-hidden="true"> &nbsp;查找</i>
            </button>
            </span>
            </div>
            <!-- /input-group -->
        </div>
    </form>
    <div class="row clearfix" style="margin:10px 0;">
        <!-- /.col-md-6 -->

        <div class="col-md-2 pull-right" style="text-align: right">
            <a type="button" class="btn btn-primary" href="?action=add">新增IP</a>
            {*<button type="button" class="btn btn-success">导出</button>*}

        </div>
    </div>
</div>
<div class="portlet">
    <div class="portlet-title">
    </div>
    <div class="portlet-tabs" style="position:relative">
    </div>
    <div class="portlet-body">
        <div class="portlet-body">
            <div class="tab-content">
                <div class="tab-pane active" id="portlet_tab1">
                    <div style="margin:10px;">
                        <div class="">
                            <div class="portlet-body">
                                <div class="tab-content clearfix">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-bordered">
                                            <thead>
                                            <tr>
                                                <th class="id">#ID</th>
                                                <th width="14%">名称</th>
                                                {if $ip_type=='waiting'}
                                                    <th>合作阶段</th>
                                                {/if}
                                                <th width="10%">云负责人</th>
                                                <th width="10%">分类</th>
                                                <th width="10%">表现形式</th>
                                                <th width="10%">合作模式</th>
                                                <th width="10%">符合人群</th>
                                                <th width="10%">面积</th>
                                                <th>操作</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            {foreach $_data['rows'] as $k=>$v}
                                                <tr>
                                                    <td>{$v['id']}</td>
                                                    <td>{$v['ip_name']}
                                                        {if !empty($v['reject_step']) && ($admin[$operator_id]['auth']==1|| $v['admin_id']==$operator_id)}
                                                            <br/>
                                                            <span style="cursor:pointer;" class="label label-sm label-danger step_rej"
                                                                  data-reject-time="{date('Y-m-d H:i:s',$v['reject_time'])}"
                                                                  data-reject-step="{$v['reject_step']}"
                                                                  data-reason="{$v['reject_reason']}"
                                                                  style="height: 20px;">
                                                           点击查看拒绝原因
                                                        </span>
                                                            <br/>
                                                            <span class="reason default hidden"></span>
                                                        {/if}
                                                    </td>
                                                    {if $ip_type=='waiting'}
                                                        <td>{$step[$v['step']]}</td>
                                                    {/if}
                                                    <td>
                                                        {if $admin[$operator_id]['auth']==1}
                                                            <select class="form-control input-sm" data-check-id=""
                                                                    data-type="winchance" data-id="{$v['id']}"
                                                                    onchange="changeAdmin(this)">
                                                                <option {if empty($v['name'])}selected{/if}>请选择负责人
                                                                </option>
                                                                {foreach $admin as $kk=>$vv}
                                                                    <option {if $v['admin_id']==$kk}selected {/if}
                                                                            value="{$kk}">{$vv['name']}</option>
                                                                {/foreach}
                                                            </select>
                                                        {else}
                                                            {$admin[$v['admin_id']]['name']}
                                                        {/if}
                                                    </td>
                                                    <td>{$v['category']}</td>
                                                    <td>{$v['manifestation']}</td>
                                                    <td>{$v['cooperating_mode']}</td>
                                                    <td>{$v['conform_crowd']}</td>
                                                    <td>{if !empty($v['min_area'])}{$v['min_area']}m
                                                            <sup>2</sup>
                                                            -{$v['max_area']}m
                                                            <sup>2</sup>
                                                        {/if}</td>
                                                    <td>
                                                        {if ($v['admin_id']==$operator_id)||$is_manager}
                                                            <a href="?action=edit&id={$v['id']}&step={if $v['step']!=5}{$v['step']+1}{else}{$v['step']}{/if}{if empty($v['id'])}&check_id={$v['check_id']}{/if}"
                                                               class="btn btn-info btn-xs">编辑</a>
                                                            <a href="javascript:;" data-id="{$v['id']}"
                                                              data-check-id="{$v['check_id']}" data-name="{$v['ip_name']}"
                                                               class="btn btn-danger btn-xs ip_delete">删除</a>
                                                            {if $v['space_id']}
                                                                <a href="{$_home}space/spacepedia?action=case&space_id={$v['space_id']}"
                                                                   class="btn btn-info btn-xs">关联文章</a>
                                                            {/if}
                                                        {/if}
                                                    </td>

                                                </tr>
                                            {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="container-fluid">
                                        <div class="row">
                                            <div class="col-md-12" style="padding: 0px;">
                                                <ul class="pagination">
                                                    {if $_data['page']['dpll']}
                                                        <li class="prev">
                                                            <a href="{$_data['page']['dup']}1" title="First"><i
                                                                        class="fa fa-angle-double-left"></i></a>
                                                        </li>
                                                        <li class="prev">
                                                            <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}"
                                                               title="Prev"><i
                                                                        class="fa fa-angle-left"></i></a>
                                                        </li>
                                                    {else}
                                                        <li class="prev disabled">
                                                            <a href="#" title="First"><i
                                                                        class="fa fa-angle-double-left"></i></a>
                                                        </li>
                                                        <li class="prev disabled">
                                                            <a href="#" title="Prev"><i
                                                                        class="fa fa-angle-left"></i></a>
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
                                                            <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}"
                                                               title="Next"><i
                                                                        class="fa fa-angle-right"></i></a>
                                                        </li>
                                                        <li class="next">
                                                            <a href="{$_data['page']['dup']}{$_data['page']['dtp']}"
                                                               title="Last"><i
                                                                        class="fa fa-angle-double-right"></i></a>
                                                        </li>
                                                    {else}
                                                        <li class="next disabled">
                                                            <a href="#" title="Next"><i
                                                                        class="fa fa-angle-right"></i></a>
                                                        </li>
                                                        <li class="next disabled">
                                                            <a href="#" title="Last"><i
                                                                        class="fa fa-angle-double-right"></i></a>
                                                        </li>
                                                    {/if}
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

</div>

<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
{static "core/yunspace.js"}
{*<script src="js/demands/demands_change_select.js" type="text/javascript"></script>*}

<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
        $('.step_rej').click(function () {
            var reason = $(this).attr('data-reason');
            var time = $(this).attr('data-reject-time');
            var step = $(this).attr('data-reject-step');
            var step_name = '';
            if (step == 1) {
                step_name = '储备';
            } else if (step == 2) {
                step_name = '审核上线';
            } else if (step == 3) {
                step_name = '拜访或电话';
            } else if (step == 4) {
                step_name = '完善IP信息';
            } else if (step == 5) {
                step_name = '签订协议';
            }
            $(this).parent().find('.reason').html('拒绝阶段：' + step_name + '<br/>拒绝理由：' + reason + '<br/>拒绝时间：' + time);
            $(this).parent().find('.reason').toggleClass("hidden");
        });

    });
</script>
<script type="text/javascript" src="js/winchance_ip/change_admin.js"></script>
<script type="text/javascript" src="js/winchance_ip/delete_operate.js"></script>
</body>
<!-- END BODY -->
</html>