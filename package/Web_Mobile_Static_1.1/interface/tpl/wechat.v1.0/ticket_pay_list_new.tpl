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
    <div class="ticket-pay-title">
        <h2>您已经选购</h2>
    </div>
    <ul class="ticket-pay-list clearfix">
        {foreach $order_info['order_detail'] as $k=>$v}
        <li  class="clearfix">
            <p class="ticket-list-p"><span class="ticket-name">{$v['ticket_name']}：</span><span  class="ticket-price fr">¥{$v['ticket_price']}</span></p>
            <p class="fr">x{$v['ticket_num']}</p>
        </li>
        {/foreach}
    </ul>
    <div class="ticket-pay-num clearfix">
        <p class="fl">价格总计</p>
        <p class="fr col-magenta">￥{$order_info['order_price']}</p>
    </div>
    <div align="center" id="qrcode">
    </div>
</div>
<script type="text/javascript" src="js/wechat.v1.0/qrcode.js"></script>
<script>
    if('{$code_url}')
    {
        var url = '{$code_url}';
       // console.log('{$code_url}');
        //参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
        var qr = qrcode(10, 'M');
        qr.addData(url);
        qr.make();
        var wording=document.createElement('p');
        wording.innerHTML = "长按图片[识别二维码]付款";
        var code=document.createElement('DIV');
        code.innerHTML = qr.createImgTag();
        var element=document.getElementById("qrcode");
        element.appendChild(wording);
        element.appendChild(code);
    }
</script>
</body>
</html>