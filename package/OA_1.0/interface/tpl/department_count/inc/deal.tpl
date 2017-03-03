<hr class="hr1">
<div class="portlet-body">
    <div class="table-scrollable">
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th scope="col">排名</th>
                <th scope="col">员工</th>
                <th scope="col">新增订单数量</th>
                <th scope="col">交易签约数量</th>
                <th scope="col">交易签约金额</th>
                <th scope="col">交易利润金额</th>
            </tr>
            </thead>
            <tbody>
            {foreach $order_data as $key=>$value}
                <tr>
                    <td>{$key+1}</td>
                    <td>{$value['username']}</td>
                    <td>{$value['new_order']}</td>
                    <td>{$value['num']}</td>
                    <td> {$value['price']} </td>
                    <td>{$value['commission']}</td>
                </tr>
            {/foreach}

            <tr>
                <td class="total">总计</td>
                <td>{count(json_decode($userlist))}</td>
                <td>{array_sum(json_decode($usernewlist))}</td>
                <td>{array_sum(json_decode($usercountlist))}</td>
                <td> {array_sum(json_decode($userpricelist))} </td>
                <td>{array_sum(json_decode($usercomlist))}</td>

            </tr>
            </tbody>
        </table>
        </div>
    <div id="mainss" style="height:400px"></div>


    <div id="mainss11" style="height:400px"></div>

    <a href="?tab=order_data&action3=export" class="btn btn-success">数据导出</a>
</div>
<script type="text/javascript" src="js/dist/echarts-all.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts图表
    var myChart = echarts.init(document.getElementById('mainss'));
    option = {
        title : {
            text: '市场部交易金额'
            //  subtext: '纯属虚构'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['交易签约金额','交易利润金额']
        },
        {literal}
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {show: true, type: [ 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        {/literal}
        // calculable : true,
        xAxis : [
            {
                type : 'category',
                data : {$userlist}
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'交易签约金额',
                type:'bar',
                data:{$userpricelist},
                barWidth:30
            },
            {
                name:'交易利润金额',
                type:'bar',
                data:{$usercomlist},
                barWidth:30
            }
        ]
    };
    // 为echarts对象加载数据
    myChart.setOption(option);
</script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts图表
    var myChart1 = echarts.init(document.getElementById('mainss11'));

    option = {
        title : {
            text: '市场部交易数量'
            //  subtext: '纯属虚构'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['新增订单数量','交易签约数量']
        },
        {literal}
        toolbox: {
            show : true,
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                magicType : {show: true, type: [ 'bar']},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        {/literal}
        // calculable : true,
        xAxis : [
            {
                type : 'category',
                data : {$userlist}
            }
        ],
        yAxis : [
            {
                type : 'value'
            }
        ],
        series : [
            {
                name:'新增订单数量',
                type:'bar',
                data:{$usernewlist},
                barWidth:30
            },
            {
                name:'交易签约数量',
                type:'bar',
                data:{$usercountlist},
                barWidth:30
            }
        ]
    };
    // 为echarts对象加载数据
    myChart1.setOption(option);
</script>
