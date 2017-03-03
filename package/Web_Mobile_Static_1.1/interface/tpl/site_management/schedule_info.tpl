<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::site_management/inc.meta.tpl"}
    <link rel="stylesheet" href="plugins/font-awesome/css/font-awesome.min.css">
    {static "v1.0/global.css"}
    {static "site_management/schedule_info_show.css"}
    {static "site_management/footer.css"}
    {static "v1.0/data-picker.css"}
</head>
<body>
<div class="schedule_info"  yun="site_management/schedule_show.js::init">
    {*{if empty($action)}*}
    <section class="schedule_info_panel">{include "Web_Mobile_Static::site_management/inc.schedule_info_show.tpl"}</section>
    {*{else}*}
    <section class="schedule_info_panel none">{include "Web_Mobile_Static::site_management/inc.schedule_info_change.tpl"}</section>
    {*{/if}*}
</div>
<div class="site_error">
</div>
{*{include "Web_Mobile_Static::site_management/inc.footer.tpl"}*}
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "v1.0/velocity.js"}

</body>
</html>