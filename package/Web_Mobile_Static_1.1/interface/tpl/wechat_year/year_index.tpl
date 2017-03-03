<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::wechat_year/head_meta.tpl"}
    {static "wechat_year/year.css"}
    {static "wechat_year/wechat_pop.css"}
    {static "wechat_year/year_advance.css"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    <script>
//        if (window.localStorage.p_explan==null) {
//            window.localStorage.p_explan = 1;
////            setTimeout(function () {
////                $('.wechat_pop-bg').fadeIn().after('<div class="popup_bg"></div>');
////                $(".pop_explan").fadeIn();
////            }, 500);
//        }
    </script>
</head>
<body>
{*<div class="content-fix">*}
    <div class="content">
        <div style="position: relative">
            <div class="year_body year_body1">
                {include "Web_Mobile_Static::wechat_year/inc.year_rule.tpl"}
            </div>
            <div class="year_body none year_body2">
                {include "Web_Mobile_Static::wechat_year/inc.year_index.tpl"}
            </div>
        </div>
    </div>
{*</div>*}


{include "Web_Mobile_Static::wechat_year/inc/wechat_pop.tpl"}
{static "v1.0/jquery-1.9.1.min.js"}
{static "core/yunspace.js"}
{static "v1.0/velocity.js"}
{static "wechat_year/year.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>