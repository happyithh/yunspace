<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link type="text/css" rel="stylesheet" href="css/wechat.v1.0/ticket.css">
    <link type="text/css" rel="stylesheet" href="css/v1.0/global.css">
    <script src="js/v1.0/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="js/wechat.v1.0/Jquery.qrcode.js"></script>
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
                <input type="hidden" name="codeurl"
                       value="http://{Core::$urls['host']}{$_home}ticket/checkticket?action=tickeinfo&type=code&ticket_num={$vv['ticket_num']}">

                <div class="code-img">
                    <div id="qrcode{$kk+1}">
                    </div>
                </div>
            </li>
        {/foreach}
    </ul>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("li").each(function () {
            var codeurl = $(this).find('input').val();
            var codeid = $(this).find('div.code-img').find('div').attr('id');
            createQrCode(codeurl, codeid);
        });
    });
    function createQrCode(text, codeid) {
        var qrsize = $('#' + codeid);
        console.log(text, codeid, $('#' + codeid + ' canvas').length);
        if ($('#' + codeid + ' canvas').length > 0) {
            return false;
        }
        //生成二维码
        qrsize.qrcode({
            // logoSrc		: '{$_assets}images/up.png',			//水印图片A
            //logoBgProp	: 0.2,				//水印大小 按图片比例
            text: text,		//扫描出的名称
            //	url			:"";
            width: 120,	//二维码宽度
            height: 120,	//二维码高度
            correctLevel: QRErrorCorrectLevel.M,
            background: "#ffffff",		//二维码第一种颜色
            foreground: "#000000"			//二维码第二种颜色
        });
        qrsize.children().css({
            'background': '#fff'
        });	//设置阴影
    }
</script>
</body>
</html>