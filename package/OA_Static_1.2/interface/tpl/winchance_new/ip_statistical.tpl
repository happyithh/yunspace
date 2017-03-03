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
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-datepicker/css/datepicker.css"/>
    <link rel="stylesheet" type="text/css"
          href="{$_assets}plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-datetimepicker/css/datetimepicker.css"/>
    <link href="{$_assets}css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/style-conquer.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/style.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/style-responsive.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/plugins.css" rel="stylesheet" type="text/css"/>
    <link href="{$_assets}css/themes/blue.css" rel="stylesheet" type="text/css" id="style_color"/>
    <link href="{$_assets}css/custom.css" rel="stylesheet" type="text/css"/>
    {*<link href="style/media.css" rel="stylesheet"/>*}
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
    <li {if $tab=='total'}class="active"{/if}>
        <a href="?tab=total" >ip累计报表</a>
    </li>
    <li {if $tab=='step'}class="active"{/if}>
        <a href="?tab=step" >ip分阶段报表</a>
    </li>

</ul>

<div class="portlet-body" style="margin-top:-50px;">
<form class="form-horizontal" role="form">
    <div class="form-body">
        <div class="form-group">
            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">云负责人</label>
            <input type="hidden" name="tab" value="{$_REQUEST['tab']}">
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
            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">运营范围</label>

            <div class="col-md-10  col-xs-10">
                <div class="radio-list">
                    <label class="radio-inline">
                        <input type="radio" name="search[city]" id="optionsRadios4" {if empty($_REQUEST['search']['city'])} checked {/if}value=""> 全部
                    </label>
                    {foreach $city as $k=>$v}
                    <label class="radio-inline">
                        <input type="radio" name="search[city]" {if $_REQUEST['search']['city']==$v}checked {/if}id="optionsRadios5" value="{$v}">{$v}
                    </label>
                    {/foreach}
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">时间间隔</label>

            <div class="col-md-10  col-xs-10">
                <div class=" radio-list">
                    <label class="radio-inline">
                        <input type="radio" name="tab_time" id="optionsRadios4" value="week" {if $_REQUEST['tab_time']=='week' || empty($_REQUEST['tab_time'])} checked{/if}> 周
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="tab_time" id="optionsRadios5" value="day" {if $_REQUEST['tab_time']=='day'}checked{/if}> 日
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="tab_time" id="optionsRadios5" value="month" {if $_REQUEST['tab_time']=='month'}checked{/if}> 月
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">选择时间</label>
            <div class="col-md-6 col-xs-6">
                <div class="input-group input-large date-picker input-daterange" data-date="10/11/2012" data-date-format="mm/dd/yyyy" style="float: left">
                    <input type="text" class="form-control date" name="search[start_time]" readonly="" placeholder="开始时间" value="{$_REQUEST['search']['start_time']}">
												<span class="input-group-addon">
												to</span>
                    <input type="text" class="form-control date" name="search[end_time]" readonly="" placeholder="结束时间" value="{$_REQUEST['search']['end_time']}">
                </div>
                <button type="submit" class="btn btn-info" style="float: left;margin-left: 30px;">确定</button>
            </div>
        </div>

    </div>
    <div class="form-actions">

        {*<button type="button" class="btn btn-success pull-right">导出</button>*}
    </div>

</form>
<div class="tab-content">
    <div class="tab-pane active">
        <div style="margin:10px;">
            <div class="">
                <div class="portlet-body">
                    <div class="tab-content clearfix">
                        <div class="table-responsive">
                            {if $tab=='total'}
                                {include "OA_Static::winchance_new/inc/statistical_total_inc.tpl"}
                            {else}
                                {include "OA_Static::winchance_new/inc/statistical_step_inc.tpl"}
                            {/if}
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
{*<style>*}
{*.step_content {*}
{*height: auto;*}
{*overflow: hidden;*}
{*background-color: #eee;*}
{*padding: 2%;*}
{*width: 96%;*}
{*margin-top: 5px;*}
{*display: none;*}
{*word-break: break-all;*}
{*}*}
{*</style>*}

<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
{static "core/yunspace.js"}
{*<script src="js/demands/demands_change_select.js" type="text/javascript"></script>*}

<script type="text/javascript" src="js/moment.min.js"></script>
{*<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>*}
<script type="text/javascript" src="js/bootstrap-datetimepicker.js"></script>
{*<script type="text/javascript" src="js/zh-cn.js"></script>*}
{*<script type="text/javascript" src="js/date.js"></script>*}
<script type="text/javascript">
    $(document).ready(function () {
//        $('.date').datetimepicker({
//            format: 'YYYY-MM-DD',
//            locale: 'zh-cn'
//        });
        $('.date').datetimepicker({
            format: 'yyyy-mm-dd',
            language: 'cn',
            minView: 2,
            autoclose: true
        });
    });
</script>

</body>
<!-- END BODY -->
</html>