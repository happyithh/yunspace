<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    {static "v1.0/global.css"}
    {static "site_management/footer.css"}
    {static "site_management/site_m.css"}
</head>
<body>
<header class="site_header">
    <div class="clear_float">
            <div class="header_left">
                &nbsp;
            </div>
        <div class="header_middle">
            场地管理
        </div>
        <div class="header_right">
            &nbsp;
        </div>
    </div>
</header>
<div class="clear"></div>
<div class="content_m mt50">
     <ul class="site_name">
         {*<a href="test1-1"><li class="site_name_title_left">场地名称</li></a>*}
         {*<a href="test1-1"><li class="site_name_title_right">子空间数</li></a>*}
         <li class="site_name_title_left">场地名称</li>
         <li class="site_name_title_right">子空间数</li>


         {foreach $space_pedia as $k=>$v}
         <li class="site_name_left1">{$v['space_name']}</li>
         <a href="/m/test_site/basic_info?space_pedia_id={$k}"> <li class="site_name_right1">{count($v['item_id'])}个
             <span class="icon-angle-right"></span>
         </li></a>
         {/foreach}

         <div class="clear"></div>
     </ul>
</div>








{include "Web_Mobile_Static::site_management/inc.footer.tpl"}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
</body>
</html>