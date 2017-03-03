<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/media.css" rel="stylesheet"/>
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">

{include 'OA_Static::Demand.v2.0/inc/demand_search_head.tpl' index=1}
<div class="form-group col-md-3 record" style="padding-left: 0px;padding-right: 0px;">
    <div class="col-md-3 doneR"><a href="?record=doneR&type={$type}{if !empty($urls)}&{$urls}{/if}"
                                   class=" btn btn-default {if $_REQUEST['record']=='doneR' || !isset($_REQUEST['record'])} btn-success{/if} ">已回访</a>
    </div>
    <div class="col-md-3 waitingR"><a href="?record=waitingR&type={$type}{if !empty($urls)}&{$urls}{/if}"
                                      class=" btn btn-default {if $_REQUEST['record']=='waitingR'} btn-success{/if} ">未回访</a>
    </div>
</div>
<div class="portlet">
    <div class="portlet-body">

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
                            <th>#ID</th>
                            <th class="list_none">创建时间</th>
                            <th class="list_none">活动名称</th>
                            <th class="list_none">需求类型</th>
                            <th>联系人</th>
                            <th class="list_none">城市</th>
                            <th class="list_none">预算范围</th>
                            <th>具体要求</th>
                            <th class="admin">负责人</th>
                            <th class="list_none" width="12%">进度</th>
                            <th width="8%">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {foreach $_data['rows'] as $k=>$v}
                            <tr>
                                <td>#{$v['id']}<br/>
                                    {if $v['offer_id']}
                                        <span class="btn-sm btn-danger" style="width: 50px;padding: 2px;">已进入报价系统</span>
                                    {/if}
                                </td>
                                <td class="list_none">{date('Y-m-d H:i',$v['create_time'])}</td>
                                <td class="list_none">{$v['demand_name']}</td>
                                <td class="list_none">{$v['demand_type']}</td>
                                <td class="contact">{if !empty($v['demand']['联系人'])}姓名：{$v['demand']['联系人']}{/if}</br>
                                    {if !empty($v['phone'])}电话： {$v['phone']}{/if}
                                </td>
                                {*<td>{$v['phone']}</td>*}
                                <td class="list_none">{$v['city']}</td>
                                <td class="list_none">{$v['price_up']}至{$v['price_down']}</td>
                                <td class="demand">{mb_substr($v['demand']['具体要求'],0,500,'utf-8')}</br>

                                    {*<span class="step_reason1" >联系记录:{$v['reason']}</span>*}
                                    <span class="steprecord btn btn-default btn-xs"
                                          style="background-color: #89c4f4" data-demand_id="{$v['id']}"
                                          onclick="demand.demandStepRecord(this)">展开联系记录↓</span>

                                    <div class="step_content">&nbsp;</div>
                                </td>
                                <td>
                                    <a href="?search[response_account_id]={$v['response_account_id']}">{$_adminInfo[$v['response_account_id']]}</a>
                                </td>
                                <td class="list_none">

                                    {foreach $_step_funnel as $key=>$val}
                                        {if $v['step']==$key}
                                            <p class="step">{$val}</p>
                                        {/if}
                                    {/foreach}
                                </td>
                                <td>
                                    <a data-id="{$v['id']}" href="#close_reason" data-toggle="modal"
                                       onclick="demand.customerStepUpdate(this)" class="btn btn-primary btn-xs">记录</a>
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
<script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js"
        type="text/javascript"></script>
{static "core/yunspace.js"}
{static "js/demands_change_select.js"}
{static "js/moment.min.js"}
{static "js/bootstrap-datetimepicker.min.js"}
{static "js/zh-cn.js"}
{static "js/date.js"}
<script type="text/javascript">
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });

    });

</script>

</body>
<!-- END BODY -->
</html>