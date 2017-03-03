<hr class="hr1">
<div class="portlet-body">
    <div class="table-scrollable">
        <table class="table table-striped table-bordered table-hover">
            <thead>
            <tr>
                <th scope="col">排名</th>
                <th scope="col">员工</th>
                <th scope="col">联系人数量</th>
            </tr>
            </thead>
            <tbody>
            {foreach $contact_data['rows'] as $key=>$value}
            <tr>
                <td>{$key+1}</td>
                <td>{$_adminInfo[$value['admin_id']]}</td>
                <td>{$value['total_num']}</td>
            </tr>
            {/foreach}
            <tr>
                <td class="total">总计</td>
                <td>{count(json_decode($userlist))}</td>
                <td>{array_sum(json_decode($usercountlist))}</td>
            </tr>
            </tbody>
        </table>
    </div>
    <div id="mainss" style="height:400px"></div>
    <a href="?action1=export" class="btn btn-success">数据导出</a>
</div>
<script type="text/javascript" src="js/dist/echarts-all.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts图表
    var myChart = echarts.init(document.getElementById('mainss'));

    option = {
        title : {
            text: '市场部联系人数量'
          //  subtext: '纯属虚构'
        },
        tooltip : {
            trigger: 'axis'
        },
        legend: {
            data:['联系人数量']
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
                name:'联系人数量',
                type:'bar',
                data:{$usercountlist},
                 barWidth:30
            }
        ]
    };

    // 为echarts对象加载数据
    myChart.setOption(option);
</script>