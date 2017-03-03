<style>
    @media (max-width: 520px) {
        .list_none {
            display: none;
        }

        .table-responsive table tbody tr td {
            white-space: inherit !important;
        }
    }
</style>
<div class="portlet">
    <div class="portlet-body">
        <div id="mainss" style="height:250px;width: 100%;"></div>
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr class="mHidden">
                            <th>创建时间</th>
                            {foreach $month as $k=>$v}
                                <th>{$v}</th>
                            {/foreach}
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $data as $k=>$v}
                            <tr class="mHidden">
                                <td>{$k}{if is_numeric($k)}：00{/if}</td>
                                {foreach $v as $kk=>$vv}
                                    <td>{if !is_numeric($k)&& empty($vv)}0{/if}{$vv}</td>

                                {/foreach}
                            </tr>
                        {/foreach}

                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
{*{var_dump($title[0])}*}
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            type="text/javascript"></script>
    <script type="text/javascript" src="js/dist/echarts-all.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            var winW = document.documentElement.clientWidth;
            if (winW < 520) {
                $('#mainss').hide();
                for (i = 1; i < 4; i++) {
                    $(".mHidden").find("th").eq(i).hide();
                    for (j = 1; j < 25; j++) {
                        $(".mHidden").eq(j).find('td').eq(i).hide();
                    }
                }
            } else {
                var myChart1 = echarts.init(document.getElementById('mainss'));
                option = {
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        data: [{foreach $month as $k=>$v}'{$v}',{/foreach}'总量']
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
                            data: {$getHours}
                        }
                    ],
                    yAxis: [
                        {
                            type: 'value'
                        }
                    ],
                    series: [
                        {foreach $month as $k=>$v}
                        {
                            name: '{$v}',
                            type: 'line',
                            data: {$hours[$k]}
                        },
                        {/foreach}
                        {
                            name: '总量',
                            type: 'line',
                            data: {$dataSum}
                        }

                    ]
                };
                myChart1.setOption(option);
            }
        });
    </script>
    {static "core/yunspace.js"}
    <script src="js/demands/demands_change_select.js" type="text/javascript"></script>
