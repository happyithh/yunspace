<!DOCTYPE html>
<!--[if IE 8]>
<html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]>
<html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en" class="no-js" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
<!--<![endif]-->
<!-- BEGIN HEAD -->
<head>
    <title>{$title}</title>
    <meta content="" name="description"/>
    {include "Admin::inc/html_head.tpl"}
    <link href="style/css.css" rel="stylesheet"/>
    <link href="style/media.css" rel="stylesheet"/>
    <link href="css/bootstrap-datetimepicker.min.css" rel="stylesheet"/>
    <script src="js/jquery-1.9.1.min.js"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<style>
    .title {

        margin: 10px 0px 10px 10px;

        float: left;
    }
</style>
<body style="background:#FaFaFa !important">
<div class="portlet">
    <div class="portlet-body" >
        <ul class="nav nav-tabs">
            {foreach $counter as $k=>$v}
                <li>
                    <a href="?{if !empty($_REQUEST['text']) or !empty($_REQUEST['datetime'])}datetime={$_REQUEST['datetime']}&text={$_REQUEST['text']}&status={$k}{elseif $_REQUEST['userid']}action=user&datetime={$_REQUEST['datetime']}&status={$k}&userid={$_REQUEST['userid']}&name={$_REQUEST['name']}&tab={$_REQUEST['tab']}{else}status={$k}{/if}&start_time={$_REQUEST['start_time']}&end_time={$_REQUEST['end_time']}"
                       class="btn{if $_REQUEST['status']==$k} btn-success{/if}">{$v[0]}
                        订单（{$v[1]})</a>
                </li>
            {/foreach}
        </ul>
        <div>
            <form action="?" method="get">
                <div class="input-group">
                    <select class="form-control datetime" name="datetime" style="width: 120px;">
                        <option value="0">不限
                        </option>
                        {foreach $dates as $v}
                            <option value="{$v}" {if $_REQUEST['datetime']==$v}selected="selected" {/if}>
                                {$v}
                            </option>
                        {/foreach}
                    </select>
                    <input type="hidden" name="status" value="{$_REQUEST['status']}">

                    <div style="display: inline-block">
                        <input type="text" class="form-control" style="width: 250px;" placeholder="订单号 / 关键词"
                               name="text" value="{$_REQUEST['text']}">
                                    <span class="input-group-btn">
                                          <button class="btn btn-info" type="submit">
                                              <i class="fa ">搜索</i>
                                          </button>
                                        {*<input class="btn btn-info" type="submit" name="submit" value="搜索" style="margin-top: 7px">*}
                                    </span>
                    </div>
                </div>
                <div style="width: 420px;float: left;margin: 10px 0 10px 0;">
                    <span style="font-size:14px;display: block;float: left;width: 110px;line-height: 40px;height: 30px;">选择下单时间：</span>

                    <div class="col-md-4" style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                        <input type='text' class="form-control date" placeholder="请选择开始时间" name="start_time"
                               value="{$_REQUEST['start_time']}"/>
                    </div>
                    <div style="display: block;float: left;line-height: 30px;height: 30px;text-align: center;margin-left: 2px;">
                        --
                    </div>
                    <div class="col-md-4" style="width: 130px;float: left;margin-left: 5px;padding: 0;">
                        <input type='text' class="form-control date" placeholder="请选择结束时间" name="end_time"
                               value="{$_REQUEST['end_time']}"/>
                    </div>
                </div>
                {if !empty($_REQUEST['userid'])}
                    <input type="hidden" name="action" value="user">
                    <input type="hidden" name="userid" value="{$_REQUEST['userid']}">
                    <input type="hidden" name="name" value="{$_REQUEST['name']}">
                    <input type="hidden" name="tab" value="{$_REQUEST['tab']}">
                {/if}
            </form>
        </div>
        {if !empty($_REQUEST['start_time'])||!empty($_REQUEST['end_time'])||(!empty($_REQUEST['start_time']) && !empty($_REQUEST['end_time']))|| !empty($_REQUEST['userid'])}
            {if !empty($_REQUEST['userid'])}
                <div class="btn btn-default"
                     style="font-size:10px;float: left;margin: 10px 0 10px 0;padding: 7px;background: #dff0d8">
                    {$_REQUEST['name']}{if $_REQUEST['tab']==1}(采购){elseif $_REQUEST['tab']==2}(供应商){/if}<a
                            href="? {if !empty($_REQUEST['start_time'])||!empty($_REQUEST['end_time'])||(!empty($_REQUEST['start_time']) && !empty($_REQUEST['end_time']))}start_time={$_REQUEST['start_time']}&end_time={$_REQUEST['end_time']}{/if}">x</a>
                </div>
            {/if}
            <div class="alert alert-success"
                 style="font-size:10px;float: left;margin: 10px 0 10px 0;padding: 7px;color: #24252f">
                汇总：实付款: {if empty($sumData[0]['pay'])}0{else}{$sumData[0]['pay']}{/if}
                元&nbsp;&nbsp;&nbsp;订单金额: {if empty($sumData[0]['price'])} 0 {else}{$sumData[0]['price']} {/if}
                元
            </div>
        {/if}
        {if $_REQUEST['action']=='show_tracking'}
            <table class="table table-striped table-bordered table-advance table-hover">
                <tr>
                    <th width="30%">更新时间</th>
                    <th width="30%">更新内容</th>
                    <th width="40%">操作对象</th>
                </tr>
                {foreach $tracking as $k=>$v}
                    <tr>
                        <td>{date('Y-m-d H:i:s',$v['更新时间'])}</td>
                        <td>{$v['操作内容']}</td>
                        <td>{$v['操作人']}</td>
                    </tr>
                {/foreach}
            </table>
        {else}
        <div class="table-responsive" style="border: 0px;height: auto">
            <table class="table table-striped table-bordered table-advance table-hover">
                <thead>
                <tr>
                    <th>采购者</th>
                    <th>供应商</th>
                    <th>服务内容</th>
                    <th class="list_none">订单号</th>
                    <th>实付款/订单金额</th>
                    <th class="list_none">下单时间</th>
                    <th class="list_none">订单档期</th>
                    {if $status==2}
                        <th class="list_none">审核时间</th>
                    {/if}
                    {if $status==3 || $status==4 || $status==5}
                    <th class="list_none">签约时间</th>
                    {/if}
                    {if  $status==4 || $status==5}
                        <th class="list_none">支付时间</th>
                    {/if}
                    {if $status==5}
                        <th class="list_none">结算时间</th>
                    {/if}
                    {if $status==-1}
                        <th class="list_none">取消时间</th>
                    {/if}
                    {if $status==-9}
                        <th class="list_none">删除时间</th>
                    {/if}
                    <th >交易状态</th>
                    <th>操作人</th>
                </tr>
                </thead>
                <tbody>
                {foreach $data as $v}
                    <tr>
                        <td>
                            <a href="?action=user&userid={$v['buyer_account_id']}&name={$v['username']}&tab=1{if !empty($_REQUEST['start_time'])||!empty($_REQUEST['end_time'])||(!empty($_REQUEST['start_time']) && !empty($_REQUEST['end_time']))}&start_time={$_REQUEST['start_time']}&end_time={$_REQUEST['end_time']}{/if}
                            ">{if empty($v['username'])}-----{else}{$v['username']}{/if}</a>
                        </td>
                        <td>
                            <a href="?action=user&userid={$v['vendor_account_id']}&name={$v['vendor_name']}&tab=2{if !empty($_REQUEST['start_time'])||!empty($_REQUEST['end_time'])||(!empty($_REQUEST['start_time']) && !empty($_REQUEST['end_time']))}&start_time={$_REQUEST['start_time']}&end_time={$_REQUEST['end_time']}{/if}">{if empty($v['vendor_name'])}-----{else}{$v['vendor_name']}{/if}</a>
                        </td>
                        <td title="{$v['remark']}">
                            <a href="{$_root}{if !empty($v['product_id'])}service_info/{$v['product_id']}{else}set_info/{$v['product_set_id']}{/if}.html" target="_blank">
                                {$v['order_title']}</a>
                            {if $v['start_time']}
                                <br/>
                                {date('Y-m-d', $v['start_time'])} ~ {date('Y-m-d', $v['end_time'])}
                            {/if}
                        </td>
                        <td class="list_none">
                            {$v['order_no']}
                            {if $v['order_tracking']}
                                <a href="?action=show_tracking&order_no={$v['order_no']}"  class="btn btn-xs btn-default">
                                    订单追踪
                                </a>
                            {/if}
                        </td>
                        <td>{$v['order_price_pay']}
                            元
                            / {$v['order_price']}
                            元
                        </td>
                        <td class="list_none">{date('Y-m-d H:i',$v['create_time'])}</td>
                        <td class="list_none">{if empty($v['start_time']) && empty($v['end_time'])}------{else}{date('Y-m-d',$v['start_time'])}--{date('Y-m-d',$v['end_time'])}{/if}</td>
                        {if $status==2}
                            <td class="list_none">{date('Y-m-d H:i',$v['create_time2'])}</td>
                        {/if}
                        {if $status==3 || $status==4 || $status==5}
                            <td class="list_none">{date('Y-m-d H:i',$v['create_time3'])}</td>
                        {/if}
                        {if $status==4 || $status==5}
                            <td class="list_none">{if !empty($v['create_time4'])}{date('Y-m-d H:i',$v['create_time4'])}{else}-----{/if}</td>
                        {/if}
                        {if $status==-1}
                            <td class="list_none">{date('Y-m-d H:i',$v['cancel_time'])}</td>
                        {/if}
                        {if $status==5}
                            <td class="list_none">{date('Y-m-d H:i',$v['create_time5'])}</td>
                        {/if}
                        {if $status==-9}
                            <td class="list_none">{date('Y-m-d H:i',$v['update_time'])}</td>
                        {/if}
                        <td>
                            {$v['order_status_text']}
                            {if $v['order_status']>=0 && $v['order_status'] < 15 && $is_admin}
                            <a href="?action=cancel_order&id={$v['id']}" class="btn btn-warning btn-xs"><i
                                        class="fa fa-trash-o"></i>
                                取消订单</a>
                            {/if}

                            {if $v['order_status'] < 0}
                                {if $v['status'] != -9 }
                                    <a href="?action=deleteOrderInfo&id={$v['id']}" class="btn btn-danger btn-xs"><i
                                                class="fa fa-trash-o"></i>
                                        删除</a>
                                {/if}
                                &nbsp;
                                <a href="?action=recover_order&id={$v['id']}" class="btn btn-success btn-xs"><i
                                            class="fa fa-trash-o"></i>
                                    恢复</a>
                            {/if}
                        </td>
                        <td>{if empty($v['admin_username'])}-----{else}{$v['admin_username']}{/if}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
        <div>
            {if empty($_REQUEST['userid'])}
                <ul class="pagination">
                    {if $_data['page']['dpll']}
                        <li class="prev">
                            <a href="{$_data['page']['dup']}1" title="First"><i class="fa fa-angle-double-left"></i></a>
                        </li>
                        <li class="prev">
                            <a href="{$_data['page']['dup']}{$_data['page']['dp']-1}" title="Prev"><i
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
            {/if}
        </div>
        {/if}
    </div>
</div>
</div>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/zh-cn.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>

<script>
    $(document).ready(function () {
        $('.date').datetimepicker({
            format: 'YYYY-MM-DD',
            locale: 'zh-cn'
        });
    });
    $('.datetime').on('change', function () {
        var time = $(this).val();
        if (time != '' && time != 0) {
            var arr = time.split("-");
            var day = new Date(arr[0], arr[1], 0);
            //获取天数：
            var daycount = day.getDate();
            $("input[name=start_time]").val(time + '-' + 1);
            $("input[name=end_time]").val(time + '-' + daycount);
        } else if (time == 0) {
            $("input[name=start_time]").val('');
            $("input[name=end_time]").val('');

        }
    })

</script>
</body>
<!-- END BODY -->
</html>