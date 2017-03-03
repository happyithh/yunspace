<!DOCTYPE html>
<html lang="en">
<head>
    {include "Web_Mobile_Static::wechat_year/head_meta.tpl"}
    {static "wechat_year/year.css"}
    {static "wechat_year/wechat_pop.css"}
    <script>
        <!--当页面加载时弹出-->
        //        window.onload=(function(){
        //            setTimeout(function(){
        //                $('.wechat_pop-bg').fadeIn().after('<div class="popup_bg"></div>');
        //                $(".pop_explan").fadeIn();
        //            },500);
        //        });
    </script>
    <title>【年底福利】云SPACE创意年会投票有奖</title>
</head>
<body>


{*<div class="wechat_pop-bg hide" style="display: block;">*}

    <div class=" pop_vdrd pop_reminder">
        <br />
        <h1>温馨提示</h1>
        <div class="h1-line"></div>
        <p>您已给{if $vote_year==1}文艺表演{elseif $vote_year==2}度假旅游{elseif $vote_year==3}创意内容{elseif $vote_year==4}特色餐饮{/if}年会主题投过票啦~</p>

        <h2>关注云·SPACE微信订阅号<strong>yunspace2013</strong><br>回复“年会”申请加群<br>进群等待每周一的抽奖</h2>

        <div class="qrcode">
            <img class="img1" src="/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/yun_code.jpg">
            <img class="img2" src="/package/Web_Mobile_Static_1.1/interface/assets/img/wechat_year/yun_code_text.jpg">
        </div>
        <h2><a href="{$_home}year"> 返回年会专题>></a></h2>
    </div>



<div class="copy">
    <p>Copyright©2015</p>
    <p>云·SPACE 沪ICP备12039278号-2</p>
</div>

<div class="consult-btn-wrap" style="display: block">
    <a class="consult-btn js-btn js-consult-btn" href="javascript:;">我要办年会</a>
</div>
<script>
    $(function(){
        $(document).unbind('scroll');
    });
</script>
{include "Web_Mobile_Static::wechat_year/inc/wechat_pop.tpl"}
{static "v1.0/jquery-1.9.1.min.js"}
{static "core/yunspace.js"}
{static "wechat_year/year.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>