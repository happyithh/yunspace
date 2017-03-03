<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/jquery-migrate-1.2.1.js"}
    {static "v4.0/common.css"}
    {static "baike.v1.0/baike_common.css"}
    {static "fancybox/fancybox.css"}
    {static "baike.v1.0/baike.css"}
    {static "baike.v1.0/banner.js"}

</head>
<body>
    {include file="Web_Static::inc/header_1.tpl"}
    {include file="Web_Static::site/inc/baike_no_banner.tpl"}
<span class="media_all none">{$json_media}</span>
<div class="container">
{include file="Web_Static::article/inc/article.tpl"}
</div>
</body>
</html>
