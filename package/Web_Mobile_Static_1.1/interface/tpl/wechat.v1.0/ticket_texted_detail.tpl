<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/wechat.v1.0/ticket.css">
    <link type="text/css" rel="stylesheet" href="css/v1.0/global.css">
</head>
<body>
<div class="ticket-pdg15-container">
    <table cellpadding="0" cellspacing="0" class="ticket_texted_detail">
        <tr>
            <th colspan="2">{$ticket_info['ticket_detail']}</th>
        </tr>
        <tr>
            <td class="detail-title">票号</td>
            <td>{$ticket_info['ticket_num']}</td>
        </tr>
        <tr>
            <td class="detail-title">购买日期</td>
            <td>{date("Y-m-d H:i:s",$ticket_info['create_time'])}</td>
        </tr>
        <tr>
            <td class="detail-title">票价</td>
            <td>￥{$ticket_info['ticket_price']}元</td>
        </tr>
        <tr>
            <td class="detail-title">用户名</td>
            <td>{$ticket_info['buyer_account_name']}</td>
        </tr>
        <tr>
            <td class="detail-title">手机号码 </td>
            <td>{$ticket_info['buyer_account_phone']}</td>
        </tr>
        {if $ticket_info['use_time']}
        <tr>
            <td class="detail-title">使用日期</td>
            <td>{date("Y-m-d H:i:s",$ticket_info['use_time'])}</td>
        </tr>
        {/if}
    </table>

    <div class="ticket-btn-wrap texted-detail-btnwrap clearfix">
       <a href="#" class="fl ticket-btn btn-col-grey" style="width: 100%;">  {if $ticket_info['status']==0}未使用{else}已使用{/if}</a>
    </div>
</div>
</body>
</html>