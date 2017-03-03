<div class="portlet-title" xmlns="http://www.w3.org/1999/html">
    <div class="caption">
        <i class="fa fa-database"></i>客户咨询的场地
    </div>
</div>
<div class="tab-content clearfix">
    <div class="tab-pane active">
        <table class="table table-striped table-bordered table-hover" id="data_table"
               style="word-break: break-all">
            <thead>
            <tr>
                <th>需求ID</th>
                <th>场地</th>
                <th>记录内容</th>
                <th>记录时间</th>
            </tr>
            </thead>
            <tbody>
            {foreach $events as $key=>$value}
                <tr>
                    <td>{$value['demand_id']}</td>
                    <td><a href="{$_root}baike/{Func_Url::str_urlencode($value['space_name'])}" target="_blank">{$value['space_name']}</a></td>
                    <td>{$value['demand']['开始时间']} 至 {$value['demand']['结束时间']},{{$value['demand']['具体要求']}}</td>
                    <td>{$value['create_time']}</td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>