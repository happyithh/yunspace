{if $_REQUEST['type']=='week' || $_REQUEST['type']=='month'}
        <div id="mainss1" style="height:250px;width: 100%;"></div>
        {/if}
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr class="mHidden">
                            <th class="sizeset">创建时间</th>
                            {foreach $demandType as $k=>$v}
                                <th>{$v}</th>
                            {/foreach}
                            <th>总计</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $data as $k=>$v}
                            <tr class="mHidden">
                                <td class="sizeset1">{$k}</td>
                                {foreach $v as $kk=>$vv}
                                    <td>{$vv}</td>
                                {/foreach}
                                <td>{array_sum( $v)}</td>
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
        $(document).ready(function() {
            var winW = document.documentElement.clientWidth;
            if (winW < 520) {
                $('#mainss1').hide();
                $(".mHidden").find("th").eq(1).hide();
                $(".mHidden").find("th").eq(3).hide();
                $(".mHidden").find("th").eq(4).hide();
                $(".mHidden").find("th").eq(6).hide();
                $(".mHidden").find("th").eq(8).hide();
                for (j = 0; j < 32; j++) {
                    $(".mHidden").eq(j).find('td').eq(1).hide();
                    $(".mHidden").eq(j).find('td').eq(3).hide();
                    $(".mHidden").eq(j).find('td').eq(4).hide();
                    $(".mHidden").eq(j).find('td').eq(6).hide();
                    $(".mHidden").eq(j).find('td').eq(8).hide();
                }
            }else{
            var myChart1 = echarts.init(document.getElementById('mainss1'));
            option = {
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: [{foreach $month as $v}'{$v}',{/foreach} '总量']
                },
                {literal}
                toolbox: {
                    show: true,
                    feature: {
                        mark: {show: true},
//                    dataView: {show: true, readOnly: false},
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
                        data: {$dataType}
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
//                    scale: false,
//                    axisTick: { show: true },
//                    splitArea: { show: true }
                    }
                ],
                series: [
                        {foreach $month as $k=>$v}
                    {
                        name: '{$v}',
                        type: 'line',
//                    stack: '总量',
                        data: {$demand[$k]}
                    },
                        {/foreach}
                    {
                        name: '总量',
                        type: 'line',
//                    stack: '总量',
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
