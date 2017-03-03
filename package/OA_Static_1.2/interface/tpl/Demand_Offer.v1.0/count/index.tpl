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
    <link href="css/demand_tender_list_statistics.css" rel="stylesheet"/>
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
                    {*<input type="hidden" name="list_type" value="product">*}
                    <input type="hidden" name="handle_type" value="{$handle_type}">

                    <div class="form-body clearfix">
                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">员工名称</label>

                            <div class="col-md-9">
                                <select class="form-control input-sm" name="search[account_id]">
                                    <option value=0>全部</option>
                                    {foreach $account as $k=>$v}
                                        {if $v['fullname']}
                                            <option {if $v['id']==$_REQUEST['search']['account_id']}selected {/if}
                                                    value="{$v['id']}">{$v['fullname']}</option>
                                        {/if}
                                    {/foreach}
                                </select></div>
                        </div>
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

                        <div class="form-group col-md-5">
                            <label class="col-md-3 control-label">城市</label>

                            <div class="col-md-9">
                                {*<input type="text" class="form-control input-sm" placeholder="状态" name="search[status]" value="{$_REQUEST['search']['status']}">*}
                                <select class="form-control input-sm" name="search[city]">
                                    <option value=0>全部</option>
                                    {foreach $_REQUEST['cities'] as $value}
                                        <option {if $value==$_REQUEST['search']['city']}selected {/if}
                                                value="{$value}">{$value}</option>
                                    {/foreach}
                                </select>
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

<div class="portlet-body">
{*<div class="title clearfix">*}
{*<a href="?action=export&search[city]={$_REQUEST['search']['city']}&search[account_id]={$_REQUEST['search']['account_id']}&search[start_time]={$_REQUEST['search']['start_time']}&search[end_time]={$_REQUEST['search']['end_time']}"*}
{*class="btn btn-success">数据导出</a>*}
{*</div>*}

<div class="statistical-numbs">
    {if $_REQUEST['search']}
        <h2>{foreach $account as $k=>$v}
                {if $_REQUEST['search']['account_id']==$v['id']}
                    {$v['fullname']}
                {/if}
            {/foreach}、{$_REQUEST['search']['city']}、{$_REQUEST['search']['start_time']}
            至{$_REQUEST['search']['end_time']}的统计数据</h2>
    {/if}


    <ul class="nav nav-tabs ">
        <li class="active">
            <a href="#tab_0" data-toggle="tab"><font><font>需求统计</font></font></a>
        </li>
        <li>
            <a href="#tab_1" data-toggle="tab"><font><font>拓展统计</font></font></a>
        </li>
        <li>
            <a href="#tab_2" data-toggle="tab"><font><font>浏览统计</font></font></a>
        </li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane active" id="tab_0">
            <div class="row stats-overview-cont">
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">

                        <div class="details">
                            <div class="title">
                                需求订单量
                            </div>
                            <div class="numbers">
                                1360
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">
                        <div class="details">
                            <div class="title">
                                成交量
                            </div>
                            <div class="numbers">
                                1800
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">
                        <div class="details">
                            <div class="title">
                                关闭量
                            </div>
                            <div class="numbers">
                                1800
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        {********拓展量********}
        <div class="tab-pane " id="tab_1">
            <div class="row stats-overview-cont">
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">

                        <div class="details">
                            <div class="title">
                                拓展量
                            </div>
                            <div class="numbers">
                                1360
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">
                        <div class="details">
                            <div class="title">
                                拒拓展量
                            </div>
                            <div class="numbers">
                                1800
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">
                        <div class="details">
                            <div class="title">
                                关闭量
                            </div>
                            <div class="numbers">
                                1800
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        {********浏览********}
        <div class="tab-pane " id="tab_2">
            <div class="row stats-overview-cont">
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">

                        <div class="details">
                            <div class="title">
                                客户浏览
                            </div>
                            <div class="numbers">
                                1360
                            </div>
                        </div>

                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">
                        <div class="details">
                            <div class="title">
                                成交量
                            </div>
                            <div class="numbers">
                                1800
                            </div>

                        </div>
                    </div>
                </div>
                <div class="col-md-2 col-sm-4">
                    <div class="stats-overview stat-block">
                        <div class="details">
                            <div class="title">
                                关闭量
                            </div>
                            <div class="numbers">
                                1800
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>


<div class="table-responsive clearfix">
    <div class="title clearfix">
        <h2 class="fl">统计详情</h2>
    </div>
    <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
        <thead>
        <tr>
            <th>创建时间</th>
            <th>需求ID</th>
            <th>拓展量</th>
            <th>推荐量</th>
            <th>客户浏览量</th>
            <th>商户浏览量</th>
            <th>电话交换量</th>
            <th>状态</th>
        </tr>
        </thead>
        <tbody>
        {foreach $demand as  $k=>$v}
            <tr>
                <td>{date('Y-m-d H:i:s',$v['create_time'])}</td>
                <td>{$v['demand_id']}</td>
                <td>{intval($other[$v['demand_id']]['expand_sum'])}</td>
                <td>{intval($other[$v['demand_id']]['recommend_sum'])}</td>
                <td>{$v['view_count_c']}</td>
                <td>{intval($other[$v['demand_id']]['vendor_view_sum'])}</td>
                <td>{intval($other[$v['demand_id']]['change_phone_sum'])}</td>
                <td>{$status[$v['status']]}</td>
            </tr>
        {/foreach}
        </tbody>
    </table>
    <div class="pull-left" style="width:30%; padding: 10px 0;">
    </div>

</div>
</div>
</div>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
<script src="{$_assets}scripts/_page.js"></script>

<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" tab="text/javascript"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

<script tab="text/javascript"
        src="{$_assets}plugins/select2/select2.min.js"></script>

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