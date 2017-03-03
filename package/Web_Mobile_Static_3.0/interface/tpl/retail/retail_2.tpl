<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_pc.tpl" url="retail"}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes"/>
    <meta name="x5-fullscreen" content="true"/>

    <!--<link href="css/reset.css" tppabs="css/reset.css?v=1.3" rel="stylesheet" type="text/css">-->
    <!--<link href="css/mod.css" tppabs="css/mod.css" rel="stylesheet" type="text/css">-->
    {static "retail_m/mod.css"}
    {static "retail_m/reset.css"}
    {static "retail_m/retail_m.css"}
    {static "v3.0/font-awesome.min.css"}
    {static "v3.0/swiper.3.1.2.min.css"}
    <script type="text/javascript" src="js/retail_m/jquery-1.8.2.min.js"></script>
    <style>

    </style>
</head>
<body data-form="{$_root}form">
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<img src="img/retail/bn_01.jpg" alt="" hidden/>
<div style="display:none;" id="div_fx_describe">文字描述</div>
<div id="loading" class="loading">
    <div class="loadbox">
        <div class="loadlogo"></div>
        <div class="loadbg"></div>
    </div>
</div>
<div class="p-index main" style="max-height:none!important:height:auto!important">
    <p>
        <!--上下滚动 start-->

    </p>
    <section class="m-page">
        <section class="part1">
            <div class="top-bn">
                <div class="logo">
                    <img src="img/retail/logo.png" alt="">
                </div>
                <h1 style="font-size:25px;">零售<br/>短租</h1>
                <div class="des">
                    <p class="p1">新场景、低成本、去库存、测市场、助推广、开店快</p>

                    <p class="p2">找到适合你的商业短租场地</p>
                </div>
                <div class="so">
                    <button class="so-join">提交需求</button>
                </div>
            </div>
        </section>
    </section>

    <section class="m-page hide">
        <div class="m-img" >
        <section class='part2'>
            <div class="step-des" style="display: table;padding-top:0">
                <div style="display: table-cell;vertical-align:middle">
                    <ul class="step-list">
                        <li class="">
                            <span class="p">提交需求</span>
                        </li>
                        <li class="">
                            <span class="p">匹配场地&场景</span>
                        </li>
                        <li class="">
                            <span class="p">确定合作方式</span>
                        </li>
                        <li class="">
                            <span class="p">品牌/内容落地</span>
                        </li>
                        <li class="">
                            <span class="p">申请加入V+品牌库</span>
                        </li>
                        <li class="">
                            <span class="p">平台战略推广与支持</span>
                        </li>
                    </ul>
                    <div class="step-bn">
                        <img src="img/retail/des_03.jpg" alt="">
                    </div>
                </div>

            </div>
        </section>
            </div>
    </section>



    <section class="m-page hide">
        <div class="m-img" >
            <section class="part3">
                <header>提交需求场地</header>
                <div >
                    <div>

                        {include file="Web_Mobile_Static::retail/inc/step_one.tpl"}
                        {include file="Web_Mobile_Static::retail/inc/step_two.tpl"}
                        {include file="Web_Mobile_Static::retail/inc/step_three.tpl"}
                    </div>
                </div>
                <p class="step1-error"></p>
            </section>
            <section class="part4">
                <div class="retail_img">
                    <nav class="clearfix" id="img-change">
                        <a href="javascript:;" class="tab-active" style="width:100%">最新动态</a>
                        {*<a href="javascript:;">品牌案例</a>*}
                    </nav>
                    {if count($page->information)>0}
                        <ul class="list clearfix none">
                            {foreach $page->information as $k=>$v}
                                {if $k==0 || $k==5}
                                    <li class="first">
                                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"
                                           data-title="{$v['title']}">
                                            <img alt="" src="{Page_Site_Global::displayMedia($v['logo'],500,208)}">
                                        </a>
                                    </li>
                                {elseif $k==1 || $k==6}
                                    <li class="second">
                                        {foreach $v as $kk=>$vv}
                                            <a href="{$_home}article/{Func_NumEncode::e($vv['id'])}.html"
                                               data-title="{$vv['title']}">
                                                <img  alt="" src="{Page_Site_Global::displayMedia($vv['logo'],165,123)}">
                                            </a>
                                            {*<a href="{$_home}article/{Func_NumEncode::e($vv['id'])}.html"*}
                                            {*data-title="{$vv['title']}">*}
                                            {*<img src="" alt=""*}
                                            {*data-original="{Page_Site_Global::displayMedia($vv['logo'],165,123)}">*}
                                            {*</a>*}
                                        {/foreach}
                                    </li>
                                {else}
                                    <li class="three">
                                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"
                                           data-title="{$v['title']}">
                                            <img  alt=""
                                                  src="{Page_Site_Global::displayMedia($v['logo'],165,249)}">
                                        </a>
                                    </li>
                                {/if}
                            {/foreach}

                            {*<li class="second">*}
                            {*<img src="" alt="">*}
                            {*<img src="" alt="">*}
                            {*</li>*}
                            {*<li class="three"><img src="" alt=""></li>*}
                            {*<li class="four"><img src="" alt=""></li>*}
                            {*<li class="first"><img src="" alt=""></li>*}
                            {*<li class="second">*}
                            {*<img src="" alt="">*}
                            {*<img src="" alt="">*}
                            {*</li>*}
                            {*<li class="three"><img src="" alt=""></li>*}
                            {*<li class="four"><img src="" alt=""></li>*}
                            {*<li class="first"><img src="" alt=""></li>*}
                            {*<li class="second">*}
                            {*<img src="" alt="">*}
                            {*<img src="" alt="">*}
                            {*</li>*}
                            {*<li class="three"><img src="" alt=""></li>*}
                            {*<li class="four"><img src="" alt=""></li>*}
                            {*<li class="first"><img src="" alt=""></li>*}
                            {*<li class="second">*}
                            {*<img src="" alt="">*}
                            {*<img src="" alt="">*}
                            {*</li>*}
                            {*<li class="three"><img src="" alt=""></li>*}
                            {*<li class="four"><img src="" alt=""></li>*}
                        </ul>
                    {/if}
                    {if count($page->cooperationBrand)>0}
                        <ul class="list clearfix none">

                            {foreach $page->cooperationBrand as $k=>$v}
                                {if $k==0 || $k==5}
                                    <li class="first">
                                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"
                                           data-title="{$v['title']}">
                                            <img  alt="" src="{Page_Site_Global::displayMedia($v['logo'],500,208)}">
                                        </a>
                                    </li>
                                {elseif $k==1 || $k==6}
                                    <li class="second">
                                        {foreach $v as $kk=>$vv}
                                            <a href="{$_home}article/{Func_NumEncode::e($vv['id'])}.html"
                                               data-title="{$vv['title']}">
                                                <img  alt="" src="{Page_Site_Global::displayMedia($vv['logo'],165,123)}">
                                            </a>
                                            {*<a href="{$_home}article/{Func_NumEncode::e($vv['id'])}.html"*}
                                            {*data-title="{$vv['title']}">*}
                                            {*<img src="" alt=""*}
                                            {*data-original="{Page_Site_Global::displayMedia($vv['logo'],165,123)}">*}
                                            {*</a>*}
                                        {/foreach}
                                    </li>
                                {else}
                                    <li class="three">
                                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"
                                           data-title="{$v['title']}">
                                            <img  alt=""    src="{Page_Site_Global::displayMedia($v['logo'],165,249)}">
                                        </a>
                                    </li>
                                {/if}
                            {/foreach}

                            {*<li class="first" data-title="dasdasdasdasdasddasdasdasdasdasddasdasdasdasdasddasdasdasdasdasd"><img src=""*}
                            {*alt="">*}
                            {*</li>*}
                            {*<li class="second">*}
                            {*<img src="" alt="">*}
                            {*<img src="" alt="">*}
                            {*</li>*}
                            {*<li class="three"><img src="" alt=""></li>*}
                            {*<li class="four"><img src="" alt=""></li>*}
                            {*<li class="first"><img src="" alt=""></li>*}
                            {*<li class="second">*}
                            {*<img src="" alt="">*}
                            {*<img src="" alt="">*}
                            {*</li>*}
                            {*<li class="three"><img src="" alt=""></li>*}
                            {*<li class="four"><img src="" alt=""></li>*}
                            {*<li class="first"><img src="" alt=""></li>*}
                            {*<li class="second">*}
                            {*<img src="" alt="">*}
                            {*<img src="" alt="">*}
                            {*</li>*}
                            {*<li class="three"><img src="" alt=""></li>*}
                            {*<li class="four"><img src="" alt=""></li>*}
                            {*<li class="first"><img src="" alt=""></li>*}
                            {*<li class="second">*}
                            {*<img src="" alt="">*}
                            {*<img src="" alt="">*}
                            {*</li>*}
                            {*<li class="three"><img src="" alt=""></li>*}
                            {*<li class="four"><img src="" alt=""></li>*}
                        </ul>
                    {/if}
                    <div></div>
                </div>
            </section>
            <div class="part5" style="">
                <div class="company">
                    <header style="margin-bottom:30px;">合作伙伴</header>
                    <a href="javascript:;" ><img src="img/retail/pany_03.png" ></a>
                </div>
            </div>
        </div>
    </section>

    {*<section class="m-page hide" >*}
        {*<div class="m-img" >*}

        {*</div>*}
    {*</section>*}
    {*<section class="m-page hide" >*}
        {*<div class="m-img" ><a href="http://www.yunspace.com.cn/m/set_info/17.html" ><img src="../tasting/images/005.jpg" ></a></div>*}
    {*</section>*}
    {*<section class="m-page hide" >*}
        {*<div class="m-img" >*}

        {*</div>*}

    {*</section>*}

    <!--<section class="m-page hide">-->
    <!--<div class="m-img">-->
    <!--<p>-->
    <!--<video src="/upload/video/fbh.m4v" type="video/mp4" width="100%" height="100%" id="video1" onclick="playPause()">-->
    <!--对不起，您的浏览器不支持！！-->
    <!--</video>-->
    <!--</p>-->
    <!--</div>-->
    <!--</section>-->

    <section class='u-arrow'>
        <p><img src="img/retail/btn01_arrow.png"/></p>
    </section>
    <p><!--上下滚动代码 end-->
    </p>
</div>
<div class="to-top"></div>
{*<a href="tel:400-056-0599" class="my-bar-bigbtn" style="background: #51bb30; width: 40px; height: 40px; padding: 10px;  font-size: 16px; line-height: 20px;border-radius: 50%; display: block; position: fixed; bottom: 20px; right: 20px;  z-index: 1000; text-align: center; color: #fff;">*}
    {*电话<br>咨询</a>*}
{*<a href="javascript:history.go(-1)" class="round-button-back"style="display: none; position: fixed; width: 40px;opacity:0.8;height: 40px; padding: 10px;border-radius: 50%;bottom: 80px; right: 20px;  z-index: 1000;background-color: #eaeaea">*}
    {*<img src="../../../package/Web_Mobile_1.0/interface/assets/mobile/images/list/back.png"/> </a>*}
{*<!--音乐-->*}
<script>
    window.onload = function () {
        var id = document.getElementById("loading");
        setTimeout(function () {
            document.body.removeChild(id)
        }, 1000);
        var urlPara = window.location.search;
        if(urlPara === "?phone"){
            $(".round-button-back").show();
        }
    }
</script>

{static "core/yunspace.js"}
{static "v3.0/block.1.0.1.js"}
<script type="text/javascript" src="js/retail_m/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="js/retail_m/page_scroll_bx.js"></script>

{static "retail_m/retail_m.js"}
<div style="display: none">
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?db9aca0f09ae15c89745a79b5c8599bf";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>
    <script type="text/javascript">
        var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3Fc400699d328ada7f4739a7a5bb91acdd' type='text/javascript'%3E%3C/script%3E"));
    </script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=44414322" charset="UTF-8"></script>
</div>
</body>
</html>