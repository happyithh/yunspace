<div class="portlet-body">
    <ul class="nav nav-tabs">
        <li class="active">
            <a href="#tab_1_1" data-toggle="tab">工作日志（请查看订单日志）</a>
        </li>
    </ul>
    <div class="tab-pane fade active in" id="tab_1_1">
        {if $log_data}
            {if in_array($weeks['week_num'],array_keys($log_data))}
                {foreach $log_data as $k=>$v}
                    {if $k==$weeks['week_num']}
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$weeks['week_num']}计划<br/>（{$weeks['start']}--{$weeks['end']}）</label>
                            <div class="col-md-10 col-xs-10">
                                <textarea class="form-control" name="log_data[{$weeks['week_num']}][plan]" rows="10" placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字"  maxlength="1000">{$v['plan']}</textarea>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$weeks['week_num']}小结<br/>（{$weeks['start']}--{$weeks['end']}）</label>
                            <div class="col-md-10 col-xs-10">
                                <textarea class="form-control" name="log_data[{$weeks['week_num']}][summary]" rows="10" placeholder="请填写本周小结，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000">{$v['summary']}</textarea>
                            </div>
                        </div>
                        <input type="hidden" name="log_data[{$weeks['week_num']}][s_e]" value="{$weeks['start']}--{$weeks['end']}">
                    {else}
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$k}计划<br/>（{$v['s_e']}）</label>
                            <div class="col-md-10 col-xs-10">
                                <textarea class="form-control"  rows="10" readonly placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字"  maxlength="1000">{$v['plan']}</textarea>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$k}小结<br/>（{$v['s_e']}）</label>
                            <div class="col-md-10 col-xs-10">
                                <textarea class="form-control"  rows="10" readonly placeholder="请填写本周小结，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000">{$v['summary']}</textarea>
                            </div>
                        </div>
                    {/if}
                {/foreach}
            {else}
                {foreach $log_data as $k=>$v}
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$k}计划<br/>（{$v['s_e']}）</label>
                            <div class="col-md-10 col-xs-10">
                                <textarea class="form-control"  rows="10" readonly placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字"  maxlength="1000">{$v['plan']}</textarea>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$k}小结<br/>（{$v['s_e']}）</label>
                            <div class="col-md-10 col-xs-10">
                                <textarea class="form-control"  rows="10" readonly placeholder="请填写本周小结，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000">{$v['summary']}</textarea>
                            </div>
                        </div>
                {/foreach}
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$weeks['week_num']}计划<br/>（{$weeks['start']}--{$weeks['end']}）</label>
                            <div class="col-md-10 col-xs-10">
                                <textarea class="form-control" name="log_data[{$weeks['week_num']}][plan]" rows="10" placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字"  maxlength="1000"></textarea>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$weeks['week_num']}小结<br/>（{$weeks['start']}--{$weeks['end']}）</label>
                            <div class="col-md-10 col-xs-10">
                                <textarea class="form-control" name="log_data[{$weeks['week_num']}][summary]" rows="10" placeholder="请填写本周小结，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000"></textarea>
                            </div>
                        </div>
                        <input type="hidden" name="log_data[{$weeks['week_num']}][s_e]" value="{$weeks['start']}--{$weeks['end']}">
            {/if}
        {else}
            <div class="form-group clearfix">
                <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$weeks['week_num']}计划<br/>（{$weeks['start']}--{$weeks['end']}）</label>
                <div class="col-md-10 col-xs-10">
                    <textarea class="form-control" name="log_data[{$weeks['week_num']}][plan]" rows="10" placeholder="请填写下周计划，请在本周内完成，本周内可以多次修改，不超过1000字"  maxlength="1000"></textarea>
                </div>
            </div>
            <div class="form-group clearfix">
                <label class="col-md-2 control-label col-xs-2" id="current-week" style="min-width: 150px;">{$weeks['week_num']}小结<br/>（{$weeks['start']}--{$weeks['end']}）</label>
                <div class="col-md-10 col-xs-10">
                    <textarea class="form-control" name="log_data[{$weeks['week_num']}][summary]" rows="10" placeholder="请填写本周小结，请在本周内完成，本周内可以多次修改，不超过1000字" maxlength="1000"></textarea>
                </div>
            </div>
            <input type="hidden" name="log_data[{$weeks['week_num']}][s_e]" value="{$weeks['start']}--{$weeks['end']}">
        {/if}
        <div class="form-group clearfix">
            <div class="col-md-12 col-xs-12 ps">
                <p>说明：</p>
                <p>1、周小结与计划请在周日23:59前完成，周一00:00系统会自动将小结跳转到下一周；</p>
                <p>2、周小结与计划可以修改在每周跳转前可以在修改。</p>
            </div>
        </div>
    </div>
</div>
<div class="form-group clearfix">
    <label class="col-md-2 control-label col-xs-2" id="next-week" style="min-width: 150px;">备注</label>
    <div class="col-md-10 col-xs-10">
        <textarea class="form-control" name="remarks"  rows="10" placeholder="此处可以输入关于此订单的备注信息，1000字以内"  maxlength="1000" >{$data['remarks']}</textarea>
    </div>
</div>

