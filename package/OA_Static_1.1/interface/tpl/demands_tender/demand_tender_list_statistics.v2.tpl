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
    {*<link href="css/demand_tender_list_statistics.css" rel="stylesheet"/>*}
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<ul class="nav nav-tabs ">
    <li class="{if $_REQUEST['action']=='list'} active{/if}">
        <a href="?action=list">常规统计</a>
    </li>
    <li class="{if $_REQUEST['action']=='list_v2'} active{/if}">
        <a href="?action=list_v2">比例统计</a>
    </li>
</ul>

<div class="portlet tabbable">

<style>
    .oneTable {
        width: 100%;
        min-width: 100%;
    }

    .oneTable tr {
        height: 70px;
        padding: 10px 0px;
    }

    .oneTable td {
        text-align: center;
        border-right: 1px solid rgb(231, 231, 235);
    }

    .oneTable td dt {
        padding-top: 15px;
        line-height: 50px;
    }

    .oneTable td dd {
        line-height: 20px;
    }

    .oneTable dl .count {
        font-size: 17px;
        color: rgb(103, 103, 103);
        margin-bottom: 5px;
    }
</style>
<div class="portlet">
<div class="portlet-title">昨日关键指标</div>
<div class="portlet-body form">

    <div class="statistical-numbs">

        <table class="oneTable">

            <tr>
                <td>
                    <div>
                        <dl>
                            <dt><b>客户浏览量为0</b></dt>
                            <dd class="count"><strong>{$yesterdayIndex['view0_count']}</strong></dd>
                            <dd>日
                                <i></i>{if $yesterdayIndex['view0']['day'] <0 } -{$yesterdayIndex['view0']['day']*100}{else}+{$yesterdayIndex['view0']['day']*100}{/if}
                                %
                            </dd>
                            <dd>周
                                <i></i>{if $yesterdayIndex['view0']['week'] < 0}-{$yesterdayIndex['view0']['week']*100}{else}+{$yesterdayIndex['view0']['week']*100}{/if}
                                %
                            </dd>
                            <dd>月
                                <i></i>{if $yesterdayIndex['view0']['month']<0 }-{$yesterdayIndex['view0']['month']*100}{else}+{$yesterdayIndex['view0']['month']*100}%{/if}
                            </dd>
                        </dl>
                    </div>
                </td>
                <td>
                    <div>
                        <dl>
                            <dt><b>客户浏览量大于3</b></dt>
                            <dd class="count"><strong>{$yesterdayIndex['view3_count']}</strong></dd>
                            <dd>日
                                <i></i>{if $yesterdayIndex['view3']['day'] <0 } -{$yesterdayIndex['view3']['day']*100}{else}+{$yesterdayIndex['view3']['day']*100}{/if}
                                %
                            </dd>
                            <dd>周
                                <i></i>{if $yesterdayIndex['view3']['week'] < 0}-{$yesterdayIndex['view3']['week']*100}{else}+{$yesterdayIndex['view3']['week']*100}{/if}
                                %
                            </dd>
                            <dd>月
                                <i></i>{if $yesterdayIndex['view3']['month']<0 }-{$yesterdayIndex['view3']['month']*100}{else}+{$yesterdayIndex['view3']['month']*100}%{/if}
                            </dd>

                        </dl>
                    </div>
                </td>

            </tr>
        </table>

    </div>
</div>
<div class="portlet-title">走势图</div>
<div class="portlet-body form">
    <div class="clearfix margin-bottom-10">
    </div>
    <div class="btn-group btn-group-justified">
        <a class="btn btn-default" onclick="getCount('demand')"><font><font>需求报价数量</font></font></a>
        {*<a class="btn btn-default" onclick="getCount('changePhone')"><font><font>交换电话总量</font></font></a>*}
        <a class="btn btn-default"><font><font></font></font></a>
    </div>
    <div class="clearfix margin-bottom-10">
    </div>
    <div class="btn-group btn-group-justified">
        {*<a class="btn btn-default"><font><font>7日</font></font></a>*}
        <a class="btn btn-default"><font><font>30日</font></font></a>
    </div>
    <div id="mainss11" style="height:250px;width: 100%;"></div>

</div>

<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
<script type="text/javascript" src="js/dist/echarts-all.js"></script>


<script src="{$_assets}plugins/jquery-1.11.0.min.js"
        type="text/javascript"></script>
{literal}
    <script type="text/javascript">
        var myChart1 = echarts.init(document.getElementById('mainss11'));
        $(document).ready(function () {

            getCount('demand');

        });
        function getCount(type) {
            $.ajax({
                url: "?action=ajax&type=" + type,
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
                                name: '最大',
                                type: 'line',
                                data: dataJson.data.series_data,
                                markPoint: {
                                    data: [
                                        {type: 'max', name: '最大值'},
                                        {type: 'min', name: '最小值'}
                                    ]
                                }
                            },

                        ]
                    };
                    console.log(dataJson.data.xAxis_data, dataJson.data.series_data);
                    myChart1.setOption(option);

                }
            });
        }
    </script>
{/literal}

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