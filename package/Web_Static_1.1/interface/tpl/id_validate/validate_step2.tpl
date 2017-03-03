<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "id_validate/validate.css"}
</head>
<body>
{include file="Web_Static::id_validate/inc/validate_head.tpl"}
<div class="wrapper">
    <div class="container">
        <div class="tab-menu">
            <a href="?type=personal" class="active fl">个人认证</a>
            <a href="?type=company" class="fr">企业认证</a>
        </div>

        <div class="validate-cont clearfix">
            <ul class="step-ul clearfix">
                <li>
                    <div class="cont">
                        <span>1</span>
                        <p>身份信息认证</p>
                    </div>
                    <div class="icon-right">&gt;&gt;&gt;&gt;&gt;</div>
                </li>
                <li class="active">
                    <div class="cont">
                        <span>2</span>
                        <p>认证成功</p>
                    </div>
                </li>
            </ul>

            <div class="step2-cont clearfix">
                <div class="val-img-success fl"><img src="img/id_validate/val_icon_success.png"></div>
                <div class="val-text fl">
                    <h2>恭喜信息成功提交，已成功激活您的云SPACE通行证账号！</h2>
                    <p>系统将在<span class="last_time">6</span>秒后为您跳转到我的云Space中心</p>
                    <a href="{$url_back}">如果您的浏览器没有自动跳转，请点此链接</a>
                </div>
            </div>
        </div><!--validate-cont-end-->
    </div><!--container-end-->
</div>
<script>
    $(document).ready(function () {
        var sms_interval;
            var count = 1;
            var sum = 6;
        var obj = $(".last_time");
        obj.html(parseInt(sum - count) );
        sms_interval = setInterval(function () {
            if (count == 6) {
                window.location.href= '{$url_back}';
                clearInterval(sms_interval);
            } else {
                obj.html(parseInt(sum - count));
            }
            count++;
        }, 1000);
    })
</script>
{static "id_validate/id_validate.js"}
{include file="Web_Static::id_validate/inc/validate_foot.tpl"}
</body>
</html>