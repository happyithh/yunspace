<!DOCTYPE html>
<html>
<head>
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/v2.0/alert-messages.css">
    <style>
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
                {if $target === "pass"}
                    <img src="img/v2.0/pass.png"/>
                {elseif $target === "verify"}
                    <img src="img/v2.0/verify.png"/>
                {else}
                    <img src="img/v2.0/reg.png"/>
                {/if}
            </div>
            <div class="msg">
                <p class="title">{$info}</p>

                <p class="back_info">
                    <span id="time">5</span><span id="static-info">&nbsp秒后为您跳转到登录页面，</span><a
                            href="{$url_back}">点此直接进入</a>
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
        window.location.href = '{$url_back}';
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