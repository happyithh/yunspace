    <meta name=”viewport” content=”width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no”/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no,minimal-ui" name="viewport" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta content="telephone=no" name="format-detection" />
    <meta name="browsermode" content="application" />
    <meta name="x5-orientation" content="portrait" />
    <meta name="x5-page-mode" content="app" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    {if isset($seo) && !empty($seo)}
        <title>{$seo['网页标题']}</title>
        <meta name="keywords" content="{$seo['网页关键词']}"/>
        <meta name="description" content="{$seo['网页简介']}"/>
    {else}
        {if isset($type) && $type=='wechat_article'}
            <title>微信文章采集</title>
        {else}
            <title>{$page->seo['网页标题']}</title>
        {/if}
        <meta name="keywords" content="{$page->seo['网页关键词']}"/>
        <meta name="description" content="{$page->seo['网页简介']}"/>
    {/if}
    {static "v3.0/common.css"}
    {static "js/jquery-1.9.1.min.js"}
    {static "v1.0/nav.css"}
    {static "index.v3.0/index.v2.0.js"}
    <link rel="stylesheet" href="/package/Web_Mobile_Static_1.1/interface/assets/plugins/ionicons-master/css/ionicons.min.css">
