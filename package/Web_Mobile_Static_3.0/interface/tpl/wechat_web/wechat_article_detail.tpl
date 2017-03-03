{*{var_dump($page->info)}*}
<!DOCTYPE>
<html>
<head>
    {*{include file="Web_Static::v4.0/html_goto_pc.tpl" url="m/wechat_article"}*}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="viewport" content="width=device-width" />
    <meta name="full-screen" content="yes" /><!-- UC强制全屏 -->
    <meta name="x5-fullscreen" content="true" /><!-- QQ强制全屏 -->
    {static "wechat_web/wechat_web.css"}
</head>
<body>
<div class="wechat-cont-text">
    <h2>{$data['title']}</h2>
    <div>{$data['content']}</div>
    {*<p>云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局</p>*}
    {*<img height="200" src="" alt="图片">*}
    {*<p>云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局</p>*}
    {*<p>云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云SPACE携手三源色打造汽车电商神态新格局云</p>*}
</div>

{include file="Web_Mobile_Static::inc/to_top.tpl"}
{static "core/yunspace.js"}
</body>
</html>

