<!doctype html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.css"/>
    <link href="css/v1.0/list.css" rel="stylesheet">
</head>
<body>
<div class="top search-style">
    <div class="top_left">
        <a href="javascript:history.go(-1)"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <form action="?" method="post">
        <input type="hidden" name="searchtype" value="{Core::$urls['action']}" >
        <div class="search">
            <div class="search-left"><img src="img/v1.0/list_06.png" /></div>
            <div class="search_center">
                <input type="text" name="keyword" class="search-input" placeholder="搜索空间/服务/供应商名称/地址等">
            </div>
        </div>
        <div class="top_right">
            <button type="submit"><i class="ion-ios-search-strong"></i></button>
        </div>
    </form>
</div>
<div class="history" style="margin-top: 50px;">
    <p class="history-title">历史记录</p>
    <p class="history-clear"><a href="#">清除</a></p>
    <div class="clear"></div>
</div>
<div class="history-content">
    <ul>
        {foreach $list as $k=>$v}
        <li><a href="../{Core::$urls['action']|default:"m/space"}/?keyword={$v['search_title']}" >{$v['search_title']}</a></li>
        {/foreach}
    </ul>
</div>
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>