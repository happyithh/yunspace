<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::index.v1.0/inc.head_index.tpl"}
    <link rel="stylesheet" href="css/vendor_info.v1.0/vendor-info.css"/>
</head>
<body>
<div class="top">
    <div class="top_left">
        <a href="{$_home}"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">预约咨询</div>
</div>
<div class="popup-vendor-join popup-content">
    <form action="{$_root}demand_submit/vendor_join" method="post">
        <ul>
            <li>
                <p>您的称呼</p>

                <div class="content">
                    <input type="text" placeholder="请输入您的姓名" name="data[您的称呼]">
                </div>
            </li>

            <li>
                <p>您的联系方式</p>

                <div class="content">
                    <input type="text" placeholder="输入您的联系方式：手机号或者电话" name="data[联系方式]">
                </div>
            </li>
            <li>
                <p>您想咨询的内容</p>
                <div class="content">
                    <textarea type="text" placeholder="请输入您想咨询的内容" name="data[咨询内容]" rows="3"></textarea>
                </div>
            </li>

            <li style="margin-top: 80px;">
                <button class="submit-button">立即提交</button>
            </li>
            <li>
                <a href=tel:4000560599">
                    <div class="contact-num">服务热线:&nbsp&nbsp400-056-0599</div>
                </a>
            </li>
        </ul>
        <p class="fuwuhao_img"><img src="img/vendor_info.v1.0/fuwuhao.jpg"> </p>
        <p class="fuwuhao_word">关注云·SPACE服务号，获取最新回复</p>
    </form>
</div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>