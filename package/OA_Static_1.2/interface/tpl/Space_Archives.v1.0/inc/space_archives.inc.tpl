<style>
    .step_content {
        height: auto;
        overflow: hidden;
        background-color: #eee;
        padding: 2%;
        width: 96%;
        margin-top: 5px;
        display: none;
        word-break: break-all;
    }
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
                <a href="?type=all{if !empty($urls)}&{$urls}{/if}">全部</a>
            </li>
            <li class="{if $type=='order_asc'}active{/if}">
                <a href="?type=order_asc{if !empty($urls)}&{$urls}{/if}">活跃度正序</a>
            </li>
            <li class="{if $type=='order_desc'}active{/if}">
                <a href="?type=order_desc{if !empty($urls)}&{$urls}{/if}">活跃度倒序</a>
            </li>
            <li class="{if $type=='notice_desc'}active{/if}">
                <a href="?type=notice_desc{if !empty($urls)}&{$urls}{/if}">按通知数</a>
            </li>
            <li class="{if $type=='response_desc'}active{/if}">
                <a href="?type=response_desc{if !empty($urls)}&{$urls}{/if}">按响应数</a>
            </li>
        </ul>
        <div class="portlet-body">
            <div class="tab-content clearfix">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th>#ID</th>
                            <th>名称</th>
                            <th>城市</th>
                            <th>价格</th>
                            <th>通知总数</th>
                            <th>报价总数</th>
                            <th>最后通知</th>
                            <th>最后报价</th>
                            <th>更新时间</th>
                            <th>手机</th>
                            <th>负责人</th>
                            <th>微信</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data['rows'] as $k=>$v}
                            <tr>
                                <td>#{$v['id']} </td>
                                <td>{$v['space_name']} </td>
                                <td>{$v['s_a_city']} </td>
                                <td>{$v['price_up']}-{$v['price_down']} </td>
                                <td>{$v['notice_sum']} </td>
                                <td>{$v['response_sum']} </td>

                                <td>{$v['notice_last_time']} </td>
                                <td>{$v['scheme_last_time']} </td>
                                <td>{$v['s_a_update_time']} </td>
                                <td>{$v['phone']} </td>
                                <td>{$v['contacts']} </td>
                                <td>{if $v['openid']}
                                        <span class="label label-sm label-success">已绑</span>
                                    {else}
                                        <span class="label label-sm label-danger">未绑</span>
                                    {/if}
                                </td>
                                <td>
                                    {*<a href="?action=demand_info&demand_id={$v['id']}&id={$v['contact_id']}&recommend_type=product_set"*}
                                    {*class="btn btn-info btn-xs">管理</a>*}
                                    <a href="?action=preview&phone={$v['phone']}" target="_blank"
                                       class="btn btn-primary btn-xs">预览报价</a>

                                    <a data-phone="{$v['sale_phone']}" data-ids="{$v['id']}"
                                       onclick="demand.noticeAdmin(this)" class="btn btn-danger btn-xs"
                                       {if empty($v['sale_phone'])}disabled{/if}>提醒</a>

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
