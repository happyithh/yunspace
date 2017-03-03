<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::wechat_year/head_meta.tpl"}
    {static "wechat_year/year.css"}
    {static "wechat_year/wechat_pop.css"}
    {static "wechat_year/year_advance.css"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    {*<script>*}
    {*if (window.localStorage.p_explan==null) {*}
    {*window.localStorage.p_explan = 1;*}
    {*setTimeout(function () {*}
    {*$('.wechat_pop-bg').fadeIn().after('<div class="popup_bg"></div>');*}
    {*$(".pop_explan").fadeIn();*}
    {*}, 500);*}
    {*}*}
    {*</script>*}
</head>
<body>
<div class="year_body year_body1">
    {include "Web_Mobile_Static::wechat_year/inc.year_rule.tpl"}
</div>
<div class="year_body year_body2">
    {include "Web_Mobile_Static::wechat_year/inc.year_index.tpl"}
</div>

{include "Web_Mobile_Static::wechat_year/inc/wechat_pop.tpl"}
{static "v1.0/jquery-1.9.1.min.js"}
{static "core/yunspace.js"}
{static "v1.0/velocity.js"}
{static "wechat_year/year.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
<script>

    $(document).ready(function () {
        var __self=this;
//        $(".year_body_advance_bottom").on("click",function(){
            $(this).hide();
            var t=__self.conFirstH;
            var wH=$(window).height();
            $(".year_body").eq(1).removeClass("none");
            $(".year_body1").animate({
                top:"-"+t+"px"
            }, 500,function(){
                $(".year_body2").animate({
                    top: "0px"
                });
            });
            setTimeout(function(){
                $(".year_body2").css({
                    position:"absolute"
                })
            },0);

        $('.wechat_pop-bg').fadeIn().after('<div class="popup_bg"></div>');
        $(".pop_reminder").fadeIn();
    })

</script>
</body>
</html>