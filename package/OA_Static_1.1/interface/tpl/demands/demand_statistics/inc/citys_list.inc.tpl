
        <div id="city_pic" style="height:250px;width: 100%;"></div>
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>创建时间</th>
                            {foreach $citys as $k=>$v}
                                <th>{$v}</th>
                            {/foreach}
                            {*<th>总计</th>*}
                        </tr>
                        </thead>
                        <tbody>
                        {if !empty($data)}
                        {foreach $data as $k=>$v}
                            <tr>
                                <td style="width: 10%">{$k}</td>
                                {foreach $v as $kk=>$vv}
                                    <td>{$vv}</td>
                                {/foreach}
                                {*<td>{array_sum($v)}</td>*}
                            </tr>
                        {/foreach}
                        {else}
                            <td colspan="8" style="text-align: center;font-size: 16px;">
                                暂无统计信息
                            </td>
                        {/if}

                        </tbody>
                    </table>
                </div>

            </div>

    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
            type="text/javascript"></script>
    <script type="text/javascript" src="js/dist/echarts-all.js"></script>
    {static "core/yunspace.js"}
    {*<script src="js/demands/demands_change_select.js" type="text/javascript"></script>*}
    <script>
        $(document).ready(function(){
            var  winW = document.documentElement.clientWidth;
            if(winW < 520  ){
                $('#mainss11').hide();
                for(i=1;i<7;i++){
                    $(".mHidden").find("th").eq(i).hide();
                    for(j=1;j<32;j++){
                        $(".mHidden").eq(j).find('td').eq(i).hide();
                    }
                }
            }else{
                var myChart1 = echarts.init(document.getElementById('city_pic'));
                option = {
                    title : {
                        text: 'YunSpace城市订单统计',
                        x:'center'
                    },
                    tooltip : {
                        trigger: 'item'
                    },
                    legend: {
                        orient : 'vertical',
                        x : 'left',
                        data:[{foreach $city_s as $k=>$v}'{$v}',{/foreach}]
                    },
                    {literal}
                    toolbox: {
                        show : true,
                        feature : {
                            mark : {show: true},
                            dataView : {show: true, readOnly: false},
                            magicType : {
                                show: true,
                                type: ['pie', 'funnel'],
                                option: {
                                    funnel: {
                                        x: '25%',
                                        width: '50%',
                                        funnelAlign: 'left',
                                        max: 1548
                                    }
                                }
                            },
                            restore : {show: true},
                            saveAsImage : {show: true}
                        }
                    },
                    {/literal}
                    calculable : true,
                    series : [
                        {
                            name:'访问来源',
                            type:'pie',
                            data:[{foreach $pieChart as $k=>$v}{$v},{/foreach}]

                        }
                    ]
                };
                myChart1.setOption(option);
            }

        });

    </script>