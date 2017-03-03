<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/wechat.v1.0/ticket.css">
    <link type="text/css" rel="stylesheet" href="css/v1.0/global.css">
</head>
<body>
<div class="ticket-container">
    <div class="ticket-title">
            <p>您已经购买</p>
        <h1>{$title}</h1>
    </div>

    <ul class="ticket-order-list">

        {foreach $ticket_lists as $kk=>$vv}
            <li>
                <h3>{$vv['ticket_detail']}</h3>

                <p class="order-text"><a
                            href="{$_home}ticket/ticketinfo?ticket_num={$vv['ticket_num']}">票号：{$vv['ticket_num']}</a>
                </p>
            </li>
        {/foreach}
    </ul>
</div>
</body>
</html>