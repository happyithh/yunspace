<!DOCTYPE html>
<html>
<head>
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/v2.0/alert-messages.css">
    <style>
        .msg-content .msg-info{
            width: 600px;
        }
        .msg-content .msg-content-outside{
            width:1180px;
        }
        .msg-content .msg-info .icon{
            width: 60px;
            height: 60px;
            float: left;
            margin-top:20px
        }
        .msg-content .msg-info .icon img{
            width: 100%;
            height: 100%;
        }
        .msg-content .msg-info .msg{
            width: 480px;
        }
        .msg-content .msg-info .msg .back_info{
            margin-top: 30px;
        }
        .msg-content .msg-info .msg .back_info a{
            color: #999;
            text-decoration: underline;
        }
        @media (max-width: 1024px) {
            body {
                display: none;
            }
        }
    </style>
</head>
<body>
<!--头部  -->
{include file="Web_Static::v2.0/html_header3.1.tpl"}

<div class="msg-content">
    <div class="msg-content-outside">
        <div class="msg-info">
            <div class="icon">
               <img src="img/v2.0/reg.png"/>
            </div>
            <div class="msg">
                <p class="title">您的需求已成功提交，稍候将有云·Space专业人员为您提供后续服务！</p>

                <p class="back_info">
                    <span id="time">5</span><span id="static-info">&nbsp秒后为您跳转到首页，</span><a
                            href="{$_root}">点此直接进入</a>
                </p>
            </div>
        </div>

    </div>
    <div class="clear"></div>
</div>
<script type="application/javascript">
    function urlBack() {
        {if $isBack}
        window.history.go(-1);
        {else}
        window.location.href = '{$_root}';
        {/if}
    }
    function countDown() {
        var intNum = $('#time').html();
        if (intNum == 1) {
            $("#time").remove();
            $("#static-info").remove();
            clearInterval(timer);
            $('#time').text("");
            urlBack();
        } else {
            $('#time').html(intNum - 1);
        }
    }
    var timer = setInterval('countDown()', 1000);
    if (document.body.clientWidth < 1025) {
        alert('{$info}');
        urlBack();
    }
</script>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>