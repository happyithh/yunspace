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
    {include 'inc/html_head.tpl'}
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body>
{include 'inc/header_top.tpl'}
<div class="clearfix"></div>
<!-- BEGIN CONTAINER -->
<div class="page-container">
    {include 'inc/header_nav.tpl' index=1}
    <!-- BEGIN CONTENT -->
    <div class="page-content-wrapper">
        <div class="page-content" style="min-height: 973px">
            <h3 class="page-title">交易管理</h3>

            <div class="portlet">
                <div class="portlet-body">
                    <ul class="nav nav-pills">
                        {foreach $counter as $k=>$v}
                            <li>
                                <a href="?status={$k}" class="btn{if $_REQUEST['status']==$k} btn-success{/if}">{$v[0]}
                                   订单（{$v[1]})</a>
                            </li>
                        {/foreach}
                        <li style="float:right;">
                            <a href="?status=100" class="btn{if $_REQUEST['status']==100} btn-primary{/if}">待评价订单（{$evaluate}）</a>
                        </li>
                    </ul>
                    <div>
                        <form action="?" method="get">

                            <div class="input-group">
                                <select class="form-control" name="datetime" style="width: 120px;">
                                    <option value="0">不限
                                    </option>
                                    {foreach $dates as $v}
                                        <option value="{$v}" {if $_REQUEST['datetime']==$v}selected="selected" {/if}>
                                            {$v}
                                        </option>
                                    {/foreach}
                                </select>

                                <div style="display: inline-block">
                                    <input type="text" class="form-control" style="width: 250px;" placeholder="订单号 / 关键词" name="text" value="{$_REQUEST['text']}">
                                    <span class="input-group-btn">
                                          <button class="btn btn-info" type="submit">
                                              <i class="fa fa-search"></i>
                                          </button>
                                    </span>
                                </div>
                            </div>

                        </form>
                    </div>
                    <div class="table-responsive" style="border: 0px;">
                        <table class="table table-striped table-bordered table-advance table-hover">
                            <thead>
                            <tr>
                                <th>服务内容</th>
                                <th>供应商</th>
                                <th>订单号</th>
                                <th>实付款</th>
                                <th>下单时间</th>
                                <th>交易状态</th>
                                <th>交易操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            {foreach $_data['rows'] as $v}
                                <tr>
                                    <td title="{$v['remark']}">
                                        {if $v['product_id']}
                                        <a href="{$_root}service_info/{$v['product_id']}.html" target="_blank">
                                            {$v['order_title']}
                                        </a>
                                        {else}
                                            <a href="{$_root}set_info/{$v['product_set_id']}.html" target="_blank">
                                                {$v['order_title']}
                                            </a>
                                        {/if}
                                        {if $v['start_time']}
                                            <br/>
                                            {date('Y-m-d', $v['start_time'])} ~ {date('Y-m-d', $v['end_time'])}
                                        {/if}
                                    </td>
                                    <td>{$v['vendor_name']}</td>
                                    <td>{$v['order_no']}</td>
                                    <td>{$v['order_price_pay']}
                                        元
                                        / {$v['order_price']}
                                        元
                                    </td>
                                    <td>{date('Y-m-d H:i',$v['create_time'])}</td>
                                    <td style="text-align: center;">
                                        {$v['order_status_text']}
                                        {if $v['status']==3}
                                            <br/>
                                            <span>订单因超时(20分钟)未处理关闭</span>
                                        {/if}
                                        {if $v['order_status'] != -1}
                                            <br/>
                                            {if $v['order_close_info']['buyer_cancel_time'] && !$v['order_close_info']['vendor_refuse_time']}
                                                <span>订单提交取消请求，待服务方确认</span>
                                            {elseif $v['order_close_info']['vendor_refuse_time']}
                                                <span>服务方已拒绝取消该订单</span>
                                            {/if}

                                            {if $v['order_close_info']['vendor_cancel_time'] && !$v['order_close_info']['buyer_refuse_time']}
                                                <span>服务方提交订单取消请求，待确认</span>
                                            {elseif $v['order_close_info']['buyer_refuse_time']}
                                                <span>已拒绝取消该订单</span>
                                            {/if}
                                        {/if}

                                    </td>
                                    <td>
                                        {if substr($v['order_no'],1,2) == '01'}
                                            <a href="{$_root}order_info_new/{$v['order_no']}" target="_blank" class="btn btn-xs btn-info">
                                                查看
                                            </a>
                                            {if $v['order_tracking']}
                                                <a href="{$_root}order_info_new/{$v['order_no']}?tab=7" target="_blank" class="btn btn-xs btn-default">
                                                    订单追踪
                                                </a>
                                            {/if}
                                        {elseif $v['product_set_id']}
                                            <a href="{$_root}product_set_order_info/{$v['order_no']}" target="_blank" class="btn btn-xs btn-info">
                                                查看
                                            </a>
                                        {else}
                                            <a href="{$_root}order_info/{$v['order_no']}" target="_blank" class="btn btn-xs btn-info">
                                                查看
                                            </a>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                    </div>
                    <div>
                        <ul class="pagination">
                            {if $_data['page']['dpll']}
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                                </li>
                                <li class="prev">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i class="fa fa-angle-left"></i></a>
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
                                    {if $_data['page']['dt'] == 0}
                                        ( 0/{$_data['page']['dt']} )
                                    {else}
                                        ({( $_data['page']['dp']-1)*$_data['page']['dn']+1}/{$_data['page']['dt']} )
                                    {/if}
                                </a>
                            </li>
                            {if $_data['page']['dprr']}
                                <li class="next">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dp']+1}" title="Next"><i class="fa fa-angle-right"></i></a>
                                </li>
                                <li class="next">
                                    <a href="{$_data['page']['dup']}{$_data['page']['dtp']}" title="Last"><i class="fa fa-angle-double-right"></i></a>
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

                <!-- END BUTTONS PORTLET-->
            </div>
            <!-- END BUTTONS PORTLET-->
        </div>
    </div>
</div>
<!-- END CONTENT -->
</div>
<!-- END CONTAINER -->
{include 'inc/footer_inbox.tpl'}
{include 'inc/footer_script.tpl'}
</body>

<!-- END BODY -->
</html>
