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

{*<ul class="nav nav-tabs ">
    <li class="{if $_REQUEST['action']=='list' || $_REQUEST['action']==''} active{/if}">
        <a href="?action=list" data-toggle="tab"><font><font>常规统计</font></font></a>
    </li>
    <li class="{if $_REQUEST['action']=='list_v2'} active{/if}">
        <a href="?action=list_v2" data-toggle="tab"><font><font>比例统计</font></font></a>
    </li>
</ul>*}
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
    <div class="portlet-title">
        <span style="color: red">(*默认为一周内数据)</span>
    </div>
    <div class="portlet-body">
        <div class="title clearfix">
            {*<a href="?action=export&search[city]={$_REQUEST['search']['city']}&search[account_id]={$_REQUEST['search']['account_id']}&search[start_time]={$_REQUEST['search']['start_time']}&search[end_time]={$_REQUEST['search']['end_time']}"*}
            {*class="btn btn-success">数据导出</a>*}
        </div>

        <div class="statistical-numbs">
            {if $_REQUEST['search']}
                <h2>{foreach $account as $k=>$v}
                        {if $_REQUEST['search']['account_id']==$v['id']}
                            {$v['fullname']}
                        {/if}
                    {/foreach}、{$_REQUEST['search']['city']}、{$_REQUEST['search']['start_time']}
                    至{$_REQUEST['search']['end_time']}的统计数据</h2>
            {/if}
            <table>
                <tr>
                    <th width="16%"> <a class="btn btn-default" onclick="getCountNew('demand_num')" data-type="demand_num">需求订单数</a></th>
                   <th width="16%"> <a class="btn btn-default" onclick="getCountNew('order_all_num')" data-type="order_all_num">客户打开超过3次订单数</a></th>
                     <th width="16%"> <a class="btn btn-default" onclick="getCountNew('change_num')">交换电话订单数</a></th>
                     <th width="16%"> <a class="btn btn-default" onclick="getCountNew('c_order_num')">客户未打开订单数</a></th>
                     <th width="16%"> <a class="btn btn-default" onclick="getCountNew('merchant_num')">无商家响应订单数</a></th>
                    {* <th width="16%"> <a class="btn btn-default" onclick="getCount('demand')">高关注率<a></th>*}
                </tr>
             {*   <tr>
                    <td>{$data['demand_num']}</td>
                    <td>{$data['order_all_num']}</td>
                    <td>{$data['change_num']}</td>
                    <td style="border:none;">{$data['c_order_num']}</td>
                    <td style="border:none;">{$data['merchant_num']}</td>
                    <td style="border:none;">{$data['oppen_rate']}</td>
                </tr>*}
            </table>
            <table>
                <tr>
                    <th width="16%"><a class="btn btn-default" onclick="getCountNew('c_all_num')">客户打开总次数</a></th>
                   <th width="16%"><a class="btn btn-default" onclick="getCountNew('v_all_num')">商户打开总次数</a></th>
                     <th width="16%"><a class="btn btn-default" onclick="getCountNew('notice_num')">通知总数</a></th>
                    <th width="16%"><a class="btn btn-default" onclick="getCountNew('offer_num')">报价总数</a></th>
                     <th width="16%"><a class="btn btn-default" onclick="getCountNew('change_all_num')">交换电话总数</a></th>
                    {* <th width="16%"><a class="btn btn-default" onclick="getCountNew('c_order_num')">未打开率</a></th>*}
                </tr>
             {*   <tr>
                    <td>{$data['c_all_num']}</td>
                    <td>{$data['v_all_num']}</td>
                    <td>{$data['notice_num']}</td>
                    <td style="border:none;">{$data['offer_num']}</td>
                    <td style="border:none;">{$data['change_all_num']}</td>
                    <td style="border:none;">{$data['no_oppen_num']}</td>
                </tr>*}
            </table>
        </div>
        {**************************************************曲线图*************************************************************}

        <div id="mainss11" style="height:250px;width: 100%;"></div>
        <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
        <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
                type="text/javascript"></script>
        <script type="text/javascript" src="js/dist/echarts-all.js"></script>


        <script src="{$_assets}plugins/jquery-1.11.0.min.js"
                type="text/javascript"></script>
        {literal}
            <script type="text/javascript">
                var myChart1 = echarts.init(document.getElementById('mainss11'));
//                $(document).ready(function () {
//                      //  var type = $().data('type');
//                    getCountNew('demand_num');
//
//
//                });
                function getCountNew(type) {
                    $.ajax({
                        url: "?action=ajaxnew&type=" + type,
                        type: 'post',
                        dataType: 'json',

                        success: function (dataJson) {
                            option = {
                                tooltip: {
                                    trigger: 'axis'
                                },
                                legend: {
                                    data: [dataJson.data.legend_data]
                                },
                                toolbox: {
                                    show: true,
                                    feature: {
                                        mark: {show: true},
                                        dataView: {show: true, readOnly: false},
                                        magicType: {show: true, type: ['line', 'bar']},
                                        restore: {show: true},
                                        saveAsImage: {show: true}
                                    }
                                },
                                calculable: true,
                                xAxis: [
                                    {
                                        type: 'category',
                                        boundaryGap: false,
                                        data: dataJson.data.xAxis_data
                                    }
                                ],
                                yAxis: [
                                    {
                                        type: 'value',
                                        axisLabel: {
                                            formatter: '{value} '
                                        }
                                    }
                                ],
                                series: [
                                    {
                                        name:dataJson.data.legend_data,
                                        type: 'line',
                                        data: dataJson.data.series_data,
                                      /*  markPoint: {
                                            data: [
                                                {type: 'max', name: '最大值'},
                                                {type: 'min', name: '最小值'}
                                            ]
                                        }*/
                                    },

                                ]
                             /*   noDataLoadingOption:[{
                                 effectOption:'null'
                                 }]*/
                            };
                            console.log(dataJson.data.xAxis_data, dataJson.data.series_data);
                            myChart1.setOption(option,true);

                        }
                    });
                }
            </script>
        {/literal}

        {*************************************************************************************************************************}
        <div class="table-responsive clearfix">
            <div class="title clearfix">
                <h2 class="fl">统计详情</h2>
            </div>
            <table class="table table-striped table-bordered table-hover" id="data_table" style="word-break: break-all">
                <thead>
                <tr>
                    <th>创建时间</th>
                    <th>需求ID</th>
                    <th>需求订单量</th>
                    <th>客户打开超过3次订单数</th>
                    <th>客户打开总次数</th>
                    {*<th>客户未打开订单数</th>
                    <th>商家打开总次数</th>
                    <th>通知总次数</th>
                    <th>交换电话订单数</th>
                    <th>交换电话总数</th>
                    <th>无商家响应订单数</th>
                    <th>报价总数</th>*}
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                {foreach $data_offer['rows'] as  $k=>$v}
                    <tr>
                        <td>{date('Y-m-d H:i:s',$v['create_time'])}</td>
                        <td>{$v['demand_id']}</td>
                        <td>{intval($data_num[$v['demand_id']]['demand_num'])}</td>
                        <td>{intval($data_num[$v['demand_id']]['order_all_num'])}</td>
                        <td>{intval($data_num[$v['demand_id']]['c_all_num'])}</td>
                       {* <td>{intval($data_num[$v['demand_id']]['c_order_num'])}</td>
                        <td>{intval($data_num[$v['demand_id']]['v_all_num'])}</td>
                        <td>{intval($data_num[$v['demand_id']]['notice_num'])}</td>
                        <td>{intval($data_num[$v['demand_id']]['change_num'])}</td>
                        <td>{intval($data_num[$v['demand_id']]['change_all_num'])}</td>
                        <td>{intval($data_num[$v['demand_id']]['merchant_num'])}</td>
                        <td>{intval($data_num[$v['demand_id']]['offer_num'])}</td>*}
                        <td>{$status[$v['status']]}</td>
                        <td><a href="?action=list_v3_detail&demand_id={$v['demand_id']}" class="btn btn-info btn-xs">查看详情</a></td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="pull-left" style="width:30%; padding: 10px 0;">
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12" style="padding: 0px;">
                        <ul class="pagination">
                            {if $data_offer['page']['dpll']}
                                <li class="prev">
                                    <a href="{$data_offer['page']['dup']}1" title="First"><i
                                                class="fa fa-angle-double-left"></i></a>
                                </li>
                                <li class="prev">
                                    <a href="{$data_offer['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i
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
                            {for $i=$data_offer['page']['dpl'] to $data_offer['page']['dpr']}
                                <li{if $i==$data_offer['page']['dp']} class="active"{/if}>
                                    <a href="{$data_offer['page']['dup']}{$i}">{$i}</a>
                                </li>
                            {/for}
                            <li class="disabled">
                                <a> {$data_offer['page']['dtp']}
                                    ( {$data_offer['page']['dp']*$data_offer['page']['dn']}
                                    /{$data_offer['page']['dt']}
                                    )</a></li>

                            {if $data_offer['page']['dprr']}
                                <li class="next">
                                    <a href="{$data_offer['page']['dup']}{$data_offer['page']['dp']+1}" title="Next"><i
                                                class="fa fa-angle-right"></i></a>
                                </li>
                                <li class="next">
                                    <a href="{$data_offer['page']['dup']}{$data_offer['page']['dtp']}" title="Last"><i
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