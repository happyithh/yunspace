<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "qrcode/jquery.qrcode.min.js"}
</head>
<body>
{include file="Web_Static::inc/header.tpl"}
<div class="wrapper">
    <div id="code">

    </div>
</div>

{include file="Web_Static::inc/html_footer.tpl"}
<script>
        $('#code').qrcode( { width: 64,height: 64, text: "http://www.yunspace.com.cn/" } );
</script>
</body>
</html>