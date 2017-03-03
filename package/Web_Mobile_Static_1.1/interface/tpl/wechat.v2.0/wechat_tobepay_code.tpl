<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <title>{$order_info['event_info']['title']}[云·Space 活动售票]</title>
</head>
<body>
<style >
    #qrcode img{
        width: 200px;
        height: 200px;
    }
</style>

<div align="center" id="qrcode">
</div>

{*<a href="" class="bg-green booking-btn">立即支付</a>*}
<script src="js/wechat.v2.0/qrcode.js"></script>
<script>
    if('{$code_url}')
    {
        var url = '{$code_url}';
        //参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
        var qr = qrcode(10, 'M');
        qr.addData(url);
        qr.make();
        var wording=document.createElement('p');
//        wording.innerHTML = "";
        var code=document.createElement('DIV');
        code.innerHTML = qr.createImgTag();
        var element=document.getElementById("qrcode");
//        element.appendChild(wording);
        element.appendChild(code);
    }
</script>
</body>
</html>