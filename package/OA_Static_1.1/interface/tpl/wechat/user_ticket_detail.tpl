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
    <script src="{$_assets}plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
    <script src="{$_assets}plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="{$_assets}plugins/select2/select2.min.js"></script>

    <link rel="stylesheet" href="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.css"/>
    <script type="text/javascript" src="{$_assets}/plugins/bootstrap-fileinput/bootstrap-fileinput.js"></script>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <script src="js/jquery-1.9.1.min.js"></script>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <style>
        table tr th {
            text-align: center;
        }

        table tr td input {
            width: 150px;
            height: 30px;;
        }
    </style>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->

<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-body clearfix form-horizontal">
        <div class="form-body">
            <input type="hidden" name="eid" value="{$info['id']}"/>

            <div class="form-group col-md-9">
                <h3 class="col-md-3 control-label">基本信息</h3>

            </div>
            <div class="clearfix">
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">活动名称</label>

                    <div class="col-md-9">
                        <label class="form-control" rows="2"> {$data['order_info']['event_title']}</label>
                    </div>
                </div>
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">购票人姓名</label>

                    <div class="col-md-9">
                        <label class="form-control" rows="2"> {$data['order_info']['buyer_account_name']}</label>
                    </div>
                </div>
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">联系方式</label>

                    <div class="col-md-9">
                        <label class="form-control" rows="2"> {$data['order_info']['buyer_account_phone']}</label>
                    </div>
                </div>
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">订单号</label>

                    <div class="col-md-9">
                        <label class="form-control" rows="2"> {$data['order_info']['order_no']}</label>
                    </div>
                </div>
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">购票票数</label>

                    <div class="col-md-9">
                        <label class="form-control" rows="2"> {$data['order_info']['order_ticket_num']} 张</label>
                    </div>
                </div>
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">支付金额</label>

                    <div class="col-md-9">
                        <label class="form-control" rows="2"> {$data['order_info']['order_price_pay']} {if $data['order_info']['price_is_score']==1}积分{else}元{/if}</label>
                    </div>
                </div>
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">支付时间</label>

                    <div class="col-md-9">
                        <label class="form-control"
                               rows="2"> {if !empty($data['order_info']['create_time2'])}{date('Y-m-d',$data['order_info']['create_time2'])}{else}-------{/if}</label>
                    </div>
                </div>
                <div class="form-group col-md-9">
                    <label class="col-md-3 control-label">门票详情</label>

                    <div class="col-md-9">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th width="35%"> 票 号</th>
                                <th width="20%">门 票 类 型</th>
                                <th width="10%">状 态</th>
                                <th width="20%">门 票 时 间</th>
                                <th width="15%">票 价</th>
                            </tr>
                            </thead>
                            <tbody class="sortable">
                            {if $data['ticket_info']}
                                {foreach $data['ticket_info'] as $k=>$v}
                                    <tr>
                                        <td><input type="text" class="form-control" name="eventstock[{$k}]"
                                                   value="{$v['ticket_num']}" readonly/></td>
                                        <td><input type="text" class="form-control" name="eventname[{$k}]"
                                                   value="{$v['ticket_detail']}" readonly/></td>
                                        <td><input type="text" class="form-control" name="eventprice[{$k}]"
                                                   value="{if $v['status']==0}未使用{elseif $v['status']==1}已使用 {/if}"
                                                   readonly/></td>
                                        <td><input type="text" class="form-control" name="eventprice[{$k}]"
                                                   value="{if empty($v['event_time'])}通 用{else}{$v['event_time']}{/if}"
                                                   readonly/></td>
                                        <td><input type="text" class="form-control" name="eventstock[{$k}]"
                                                   value="{$v['ticket_price']} {if $data['order_info']['price_is_score']==1}积分{else}元{/if}" readonly/></td>
                                    </tr>
                                {/foreach}
                            {/if}
                            {*</tbody>*}
                        </table>
                    </div>
                </div>
                {if  !empty($data['order_info']['addressInfo'])}

                <form action="?action=edit_order_detail" method="post">
                    <div class="form-group col-md-9">
                        <h3 class="col-md-3 control-label">收货地址信息</h3>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">姓名</label>

                        <div class="col-md-9">
                            <input class="form-control"  name="addressInfo[name]"
                                   value="{$data['order_info']['addressInfo']['name']}" rows="2">
                            </input>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">电话</label>

                        <div class="col-md-9">
                            <input class="form-control" name="addressInfo[phone]"
                                   value="{$data['order_info']['addressInfo']['phone']}"  rows="2">
                            </input>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">地址</label>

                        <div class="col-md-9">
                            <input class="form-control" name="addressInfo[address_content]"
                                   value="{$data['order_info']['addressInfo']['address_content']}"  rows="2">
                            </input>
                        </div>
                    </div>
                    {if $data['order_info']['order_status']==1 }
                    <div class="form-group col-md-9">
                        <h3 class="col-md-3 control-label">物流信息</h3>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">物流来源</label>

                        <div class="col-md-9">
                            <input class="form-control" placeholder="如：顺丰快递" name="logisticsInfo[name]"
                                   value="{$data['order_info']['logisticsInfo']['name']}" {if $data['order_info']['status']==-9 || $data['order_info']['order_status']==-2}display{/if} rows="2">
                            </input>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">物流单号</label>

                        <div class="col-md-9">
                            <input class="form-control" placeholder="如：25654646545565" name="logisticsInfo[order_no]"
                                   value="{$data['order_info']['logisticsInfo']['order_no']}" {if $data['order_info']['status']==-9 || $data['order_status']==-2}display{/if}  rows="2">
                            </input>
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="col-md-3 control-label">物流状态</label>

                        <div class="col-md-9">
                            <label class="radio-inline">
                                <input type="radio" name="logisticsInfo[status]" value="0"  checked>
                                未寄出
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="logisticsInfo[status]" value="1" {if $data['order_info']['logisticsInfo']['status']==1}checked{/if} >
                                已寄出
                            </label>
                        </div>
                    </div>
                    {/if}
                    <input type="hidden" name="id" value="{$data['order_info']['id']}"/>
                    <div class="form-group col-md-9 text-center">
                        <button type="reset" class="btn btn-default">
                            重置
                        </button>
                        <button type="submit" class="btn btn-success">
                            提交
                        </button>
                    </div>
                </form>
                {/if}
            </div>

        </div>
    </div>


</body>
</html>