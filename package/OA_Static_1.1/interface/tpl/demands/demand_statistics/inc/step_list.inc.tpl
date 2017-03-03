<div id="mainss11" style="height:250px;width: 100%;"></div>
<div class="portlet-body">
    <div class="tab-content clearfix">
        <div class="table-responsive">
            <table class="table table-striped table-bordered ">
                <thead>
                <tr class="mHidden">
                    <th>创建时间</th>
                    {foreach $step_funnel as $k=>$v}
                        <th>{$v}</th>
                    {/foreach}
                    <th>总计</th>
                </tr>
                </thead>
                <tbody>
                {foreach $data as $k=>$v}
                    <tr class="mHidden">
                        <td>{$k}</td>
                        {foreach $v as $kk=>$vv}
                            <td>{$vv}</td>
                        {/foreach}
                        {*<td>{intval(array_sum($v))}</td>*}
                    </tr>
                {/foreach}

                </tbody>
            </table>
        </div>

    </div>

    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            type="text/javascript"></script>
    <script type="text/javascript" src="js/dist/echarts-all.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var winW = document.documentElement.clientWidth;
            if (winW < 520) {
                $('#mainss11').hide();
                for (i = 1; i < 7; i++) {
                    $(".mHidden").find("th").eq(i).hide();
                    for (j = 1; j < 32; j++) {
                        $(".mHidden").eq(j).find('td').eq(i).hide();
                    }
                }
            } else {
                var myChart1 = echarts.init(document.getElementById('mainss11'));
                option = {
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data: ['总量', '成交', '关闭']
                    },
                    {literal}
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
                    {/literal}
                    calculable: true,
                    xAxis: [
                        {
                            type: 'category',
                            boundaryGap: false,
                            data: {$daysTime}
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value'
                        }
                    ],
                    series: [
                        {
                            name: '总量',
                            type: 'line',
//                    stack: '总量',
                            data: {$sum}
                        },
                        {
                            name: '成交',
                            type: 'line',
//                    stack: '总量',
                            data: {$step1}
                        },
                        {
                            name: '关闭',
                            type: 'line',
//                    stack: '总量',
                            data: {$step2}
                        }

                    ]
                };
                myChart1.setOption(option);
            }

        });
    </script>
    {static "core/yunspace.js"}
    <script src="js/demands/demands_change_select.js" type="text/javascript"></script>
