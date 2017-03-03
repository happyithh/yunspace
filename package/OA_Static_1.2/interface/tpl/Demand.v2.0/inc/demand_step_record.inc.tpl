<div class="portlet-title" xmlns="http://www.w3.org/1999/html">
    <div class="caption">
        <i class="fa fa-database"></i>进度记录
    </div>
</div>
<div class="tab-content clearfix">
    <div class="tab-pane active">
            <table class="table table-striped table-bordered table-hover" id="data_table"
                   style="word-break: break-all">
                <thead>
                <tr>
                    <th>进度</th>
                    <th>理由</th>
                    <th>记录时间</th>
                </tr>
                </thead>
                <tbody>
                {foreach $stepRecord as $key=>$value}
                    <tr>
                        <td>{$_step_funnel[$value['step']]}</td>
                        <td>{$value['reason']}</td>
                        <td>{$value['create_time']}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
</div>