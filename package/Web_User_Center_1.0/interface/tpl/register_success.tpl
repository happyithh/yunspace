<!DOCTYPE html>
<html>
<head>
    {include 'Web::inc/html_head.tpl'}
    <link rel="stylesheet" type="text/css" href="css/register-2.css">
</head>
<body>
<!--头部  -->
{include 'Web::inc/header_nav.tpl'}

<div class="content">
    <div class="wrap con clearfix banner_wrap">
        <div class="register_person">
            <div class="reg_header">
                <div class="one" style="background:#24252f;border-radius:18px;">
                    1
                </div>
                <p>设置账户信息</p>
                <img src="images/u70_line.png" alt=""/>

                <div class="two">2</div>
                <p>注册成功</p>
            </div>
            <div class="clear"></div>
            <div class="reg_end">
                <h1>注册成功</h1>

                <p>
                    您可以<a href="user_admin/">前往我的云Space中心</a>内添加更多信息以完善账户安全性及获取更多增值服务！
                </p>
                {if $url_back}
                    <a href="{$url_back}">
                        <button>返回注册前的页面</button>
                    </a>
                {else}
                    <a href="{$_root}">
                        <button>返回网站首页</button>
                    </a>
                {/if}
            </div>
        </div>
    </div>
    <div class="clear"></div>
</div>
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>