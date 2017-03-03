<!DOCTYPE html>
<html>
<head>
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/register-2.css">
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
{include 'Web::inc/header_nav.tpl'}

<div class="content">
    <div class="wrap con clearfix banner_wrap">
        <div class="register_person">
            <div class="reg_end">

                <p class="info_title">
                    <span><i class="fa fa-lightbulb-o"></i></span>{$info}
                </p>

                <p class="back_info">
                    <a href="{$url_back}" class="">如果您的浏览器没有自动跳转，请点击此链接<span id="time">3</span></a>
                </p>
                {*{if $url_back}*}
                {*<a href="{$url_back}">*}
                {*<button>返回注册前的页面</button>*}
                {*</a>*}
                {*{else}*}
                {*<a href="{$_root}">*}
                {*<button>返回网站首页</button>*}
                {*</a>*}
                {*{/if}*}
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<script type="application/javascript">
    function a() {
        {if $isBack}
        window.history.go(-1);
        {else}
        window.location.href = '{$url_back}';
        {/if}

    }
    function a2() {
        var intNum = $('#time').html();
        $('#time').html(intNum - 1);
    }
    setInterval('a2()', 1000);
    setTimeout('a()', 3000);
    if (document.body.clientWidth < 1025) {
        alert('{$info}');
        a();
    }
</script>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>