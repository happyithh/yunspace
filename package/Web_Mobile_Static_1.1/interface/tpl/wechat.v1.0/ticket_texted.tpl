<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/wechat.v1.0/ticket.css">
    <link type="text/css" rel="stylesheet" href="css/v1.0/global.css">
</head>
<body>
<div class="ticket-container">
    <form action="{$_home}ticket/checkticket" method="post">
        <div class="ticket-num-typing clearfix">
            <input  type="hidden" name="action" value="tickeinfo"/>
            <input  type="hidden" name="type" value="form"/>
                <label for="ipt-num-typing" class="fl">输入票号:</label>
                <input type="text" class="ipt-typing fl" id="ipt-num-typing" name="ticket_num">
        </div>
        <div class="ticket-btn-wrap">
            <input type="submit" class="ticket-btn-pay btn-col-green" value="立即验证" style="line-height: 30px;background:#17d2b5;">
        </div>
    </form>
</div>
</body>
</html>