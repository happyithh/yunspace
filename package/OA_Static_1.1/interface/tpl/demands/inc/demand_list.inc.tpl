<style>
    .step_content{ height: auto; overflow: hidden; background-color:#eee; padding: 2%; width: 96%; margin-top: 5px;
        display: none; word-break: break-all;}
</style>
<div class="portlet">
    <div class="portlet-body">
        {*<div class="portlet-title">*}
        {*<div class="caption">*}
        {*<i class="fa fa-database"></i>*}
        {*(当前共<a href="#"> {$_data['page']['dt']} </a>个需求)*}
        {*</div>*}
        {*</div>*}
        <ul class="nav nav-tabs">
            <li class="{if $type=='all'}active{/if}">
                <a href="?type=all{if !empty($urls)}&{$urls}{/if}">全部（{($total['all'])}）</a>
            </li>
            <li class="{if $type=='waiting'}active{/if}">
                <a href="?type=waiting{if !empty($urls)}&{$urls}{/if}">未开始（{($total['waiting'])}
                    ）</a>
            </li>
            <li class="{if $type=='done'}active{/if}">
                <a href="?type=done{if !empty($urls)}&{$urls}{/if}">进行中（{($total['done'])}）</a>
            </li>
            <li class="{if $type=='end'}active{/if}">
                <a href="?type=end{if !empty($urls)}&{$urls}{/if}">已完成（{($total['end'])}）</a>
            </li>
            <li class="{if $type=='abandon'}active{/if}">
                <a href="?type=abandon{if !empty($urls)}&{$urls}{/if}">已放弃（{($total['abandon'])}
                    ）</a>
            </li>
        </ul>
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th class="id" style="width: 125px;">#ID</th>
                            <th >创建时间</th>
                            <th class="list_none">活动名称</th>
                            <th class="list_none">需求类型</th>
                            <th class="list_none">联系人</th>
                            <th class="list_none">城市</th>
                            <th class="list_none">预算范围</th>
                            <th class="list_none">具体要求</th>
                            <th class="admin">负责人</th>
                            <th  width="12%">进度</th>
                            <th width="8%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data['rows'] as $k=>$v}
                            <tr>
                                <td>#{$v['id']}
                                    {if $v['offer_id']}
                                    <span class="btn-sm btn-primary" style="width: 50px;padding: 2px;">报价系统</span>
                                    {/if}
                                    {if $v['offer_status']}
                                        <span class="btn-sm btn-danger" style="width: 50px;padding: 2px;">
                                            {Data_Mysql_Table_Demand_Offer::$_status[$v['offer_status']]}</span>
                                    {/if}
                                </td>
                                <td >{date('Y-m-d H:i',$v['create_time'])}</td>
                                <td class="list_none">{$v['demand_name']}</td>
                                <td class="list_none">{$v['demand_type']}</td>
                                <td class="contact">{$v['demand']['联系人']}</td>
                                <td class="list_none">{$v['city']}</td>
                                <td class="list_none">{$v['price_up']}至{$v['price_down']}</td>
                                <td class="demand list_none" style="width: 20%">{mb_substr($v['demand']['具体要求'],0,500,'utf-8')}</br>
                                    {if !empty($v['reason'])}
                                    {*<span class="step_reason1" >联系记录:{$v['reason']}</span>*}
                                    <span class="steprecord btn btn-default btn-xs" style="background-color: #89c4f4" data-demand_id="{$v['id']}" onclick="demand.demandStepRecord(this)">展开联系记录↓</span>
                                    <div class="step_content">联系记录详情</div>
                                    {/if}
                                </td>
                                <td class="admin">  {if !empty($v['response_account_id'])}
                                        <a href="?search[response_account_id]={$v['response_account_id']}">{$_adminInfo[$v['response_account_id']]}</a>
                                    {else}
                                        <select class="form-control input-sm" id="{$v['id']}"
                                                onchange="demand.getAdmin(this)">
                                            <option value=0>分配负责人</option>
                                            {foreach $admin as $key=>$value}
                                                <option value="{$value['response_account_id']}"
                                                        data-admin-id="{$value['admin_id']}">{$value['fullname']}</option>
                                            {/foreach}
                                        </select>
                                    {/if}
                                </td>
                                <td >

                                        {foreach $_step_funnel as $key=>$val}
                                    {if $v['step']==$key} <p class="step" >{$val}</p>
                                    {/if}
                                        {/foreach}
                                </td>
                                <td>
                                    <a href="?action=demand_info&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=product_set"
                                                                            class="btn btn-info btn-xs">管理</a>
                                   <a data-id="{$v['id']}" href="#close_reason"  data-toggle="modal"
                                      onclick="demand.customerStepUpdate(this)" {foreach $_step_funnel as $key=>$val}
                                           {if $v['step']==$key} data-value="{$key}"
                                               {/if}
                                           {/foreach}
                                       class="btn btn-primary btn-xs" {if $v['step']==100}disabled{/if}>记录</a>

                                    <a data-account="{$v['response_account_id']}" data-ids="{$v['id']}" onclick="demand.noticeAdmin(this)" class="btn btn-danger btn-xs"{if empty($v['response_account_id'])}disabled{/if}>提醒</a>

                                </td>
                            </tr>
                        {/foreach}
                        </tbody>
                    </table>
                </div>
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-12" style="padding: 0px;">
                            <ul class="pagination">
                                {if $_data['page']['dpll']}
                                    <li class="prev">
                                        <a href="{$_data['page']['dup']}1" title="First"><i
                                                    class="fa fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="prev">
                                        <a href="{$_data['page']['dup']}{$_waiting['page']['dp']-1}" title="Prev"><i
                                                    class="fa fa-angle-left"></i></a>
                                    </li>
                                {else}
                                    <li class="prev disabled">
                                        <a href="#" title="First"><i class="fa fa-angle-double-left"></i></a>
                                    </li>
                                    <li class="prev disabled">
                                        <a href="#" title="Prev"><i class="fa fa-angle-left"></i></a>
                                    </li>
                                {/if}
                                {for $i=$_data['page']['dpl'] to $_data['page']['dpr']}
                                    <li{if $i==$_data['page']['dp']} class="active"{/if}>
                                        <a href="{$_data['page']['dup']}{$i}">{$i}</a>
                                    </li>
                                {/for}
                                <li class="disabled">
                                    <a> {$_data['page']['dtp']}
                                        ( {$_data['page']['dp']*$_data['page']['dn']}
                                        /{$_data['page']['dt']}
                                        )</a></li>

                                {if $_data['page']['dprr']}
                                    <li class="next">
                                        <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i
                                                    class="fa fa-angle-right"></i></a>
                                    </li>
                                    <li class="next">
                                        <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i
                                                    class="fa fa-angle-double-right"></i></a>
                                    </li>
                                {else}
                                    <li class="next disabled">
                                        <a href="#" title="Next"><i class="fa fa-angle-right"></i></a>
                                    </li>
                                    <li class="next disabled">
                                        <a href="#" title="Last"><i class="fa fa-angle-double-right"></i></a>
                                    </li>
                                {/if}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="close_reason" tabindex="-1" role="basic" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    理由</h4>
            </div>
            <div class="modal-body">

                <table width="80%">
                    <tr>
                        <td>进度记录：
                        </td>
                        <td>
                            <select class="form-control  demand_step ">
                                {foreach $_step_funnel as $key=>$val}

                                    <option value="{$key}">{$val}</option>

                                {/foreach}
                            </select>
                        </td>


                    </tr>
                    <tr style="display: none">
                        <td>
                            关闭理由：
                        </td>
                        <td>
                            &bkarow;<input type="checkbox" name="reason" value="联系不到"> 联系不到
                        </td>
                        <td>
                            &bkarow; <input type="checkbox" value="恶意提交" name="reason"> 恶意提交
                        </td>
                        <td>
                            &bkarow; <input type="checkbox" name="reason" value="客户手机输入错误"> 客户手机输入错误
                        </td>
                        <td>
                            &bkarow;<input type="checkbox" value="其他原因" name="reason"> 其他原因
                        </td>
                    </tr>
                    <tr>
                        <td>
                            备注：
                        </td>
                        <td colspan="4">
                            <textarea class="form-control step_reason"
                                      rows="5" placeholder="至少输入15个字"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    取消
                </button>
                <button type="button" class="btn btn-success" onclick="demand.demandStepReasonSubmit(this)">
                    确定
                </button>
            </div>

        </div>
    </div>

</div>
<script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
{static "core/yunspace.js"}
<script src="js/demands/demands_change_select.js" type="text/javascript"></script>
