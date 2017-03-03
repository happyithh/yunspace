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
    <link rel="stylesheet" type="text/css" href="{$_assets}plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
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
<style>
    .radio-list > label.radio-inline:first-child {
        padding-left: 20px;
    }
</style>
<div class="portlet tabbable">
    <div class="portlet-title">
        <div class="caption">
            <i class="fa fa-search"></i>IP订单数据报表
        </div>
    </div>
    <div class=" portlet-tabs">
        {*<ul class="nav nav-tabs">*}
            {*<li>*}
                {*<a href="ui_tabs_accordions_navs.html#portlet_tab1" data-toggle="tab"></a>*}
            {*</li>*}
            {*<li class="active">*}
                {*<a href="ui_tabs_accordions_navs.html#portlet_tab2" data-toggle="tab"></a>*}
            {*</li>*}
        {*</ul>*}

        <div class="portlet-body" >
            <form class="form-horizontal" action="?"  method="get" role="form">
                <div class="form-body">
                    {if $is_manager}
                    <div class="form-group">
                        <label class="col-md-1 control-label col-xs-2">云负责人</label>
                        <div class="col-md-10  col-xs-10">
                            <div class="radio-list">
                                <label class="radio-inline">
                                    <input type="radio" name="admin_id" id="optionsRadios4" value="" {if $_REQUEST['admin_id']=='all'||empty($_REQUEST['admin_id'])}checked{/if}>全部
                                </label>
                                {foreach $yun_principal as $k=>$v}
                                    <label class="radio-inline">
                                        <input type="radio" name="admin_id" id="optionsRadios4" value="{$k}" {if $_REQUEST['admin_id']==$k}checked{/if}>{$v['name']}
                                    </label>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                    {/if}
                    <div class="form-group">
                        <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">城市</label>
                        <div class="col-md-10  col-xs-10">
                            <div class="radio-list">
                                <label class="radio-inline">
                                    <input type="radio" name="city" id="optionsRadios5" value="all" {if $_REQUEST['city']=='all'||empty($_REQUEST['city'])}checked{/if}> 全部
                                </label>
                                {$i=1}
                                {foreach $city_array as $k=>$v}
                                    <label class="radio-inline">
                                        <input type="radio" name="city" id="optionsRadios5" value="{$v}" {if $_REQUEST['city']==$v}checked{/if}>{$v}
                                    </label>
                                    {if $i==12}
                                        <br />
                                    {/if}
                                    {$i=$i+1}
                                {/foreach}
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">时间间隔</label>
                        <div class="col-md-10  col-xs-10">
                            <div class=" radio-list">
                                <label class="radio-inline">
                                    <input type="radio" name="type" id="optionsRadios4" value="weeks" {if $_REQUEST['type']=='weeks'}checked{/if}> 周
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="type" id="optionsRadios5" value="days" {if $_REQUEST['type']=='days'}checked{/if}> 日
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="type" id="optionsRadios5" value="months" {if $_REQUEST['type']=='months'}checked{/if}> 月
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-md-1 control-label col-xs-2" style="min-width: 100px;">选择时间</label>
                        <div class="col-md-6 col-xs-6">
                            <div class="input-group input-large date-picker input-daterange"  data-date="10/11/2012" data-date-format="mm/dd/yyyy" style="float: left">
                                <input type="text" class="form-control date" name="start_time" readonly placeholder="开始时间" value="{$_REQUEST['start_time']}">
												<span class="input-group-addon">
												to</span>
                                <input type="text" class="form-control date" name="end_time"  readonly placeholder="结束时间" value="{$_REQUEST['end_time']}">
                            </div>
                            <button type="submit" class="btn btn-info" style="float: left;margin-left: 30px;">确定</button>
                        </div>
                    </div>
                </div>
                {*<div class="form-actions">*}
                    {*<button type="submit" class="btn btn-info">搜索</button>*}
                    {*<button type="button" class="btn btn-success pull-right">导出</button>*}
                {*</div>*}
            </form>
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
                                                <th width="15%">时间段</th>
                                                <th width="10%">了解需求</th>
                                                <th width="10%">明确需求</th>
                                                <th width="10%">合同流程</th>
                                                <th width="10%">已签约 待进行</th>
                                                <th width="10%">取消订单数</th>
                                                <th width="10%">新订单数</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            {if $result}
                                                {foreach $result as $k=>$v}
                                                    <tr>
                                                        <td>{$k}</td>
                                                        <td>{$v['1']}</td>
                                                        <td>{$v['2']}</td>
                                                        <td>{$v['3']}</td>
                                                        <td>{$v['4']}</td>
                                                        <td>{$v['-1']}</td>
                                                        <td>{$v['0']}</td>
                                                    </tr>
                                                {/foreach}
                                            {/if}
                                            </tbody>
                                        </table>
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
            minView:2,
            autoclose:true
        });
    });
</script>

</body>
<!-- END BODY -->
</html>