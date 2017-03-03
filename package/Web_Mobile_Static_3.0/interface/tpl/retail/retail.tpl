<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v4.0/html_goto_pc.tpl" url="retail"}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="full-screen" content="yes"/>
    <meta name="x5-fullscreen" content="true"/>
    {static "retail_m/retail_m.css"}
    {static "v3.0/font-awesome.min.css"}
    {static "v3.0/swiper.3.1.2.min.css"}
</head>
<body data-form="{$_root}form">
<div class="swiper-container">
    <div class="swiper-wrapper">
        <div class="swiper-slide">
            <section class="part1">
                <div class="top-bn">
                    <div class="logo">
                        <img src="img/retail/logo.png" alt="">
                    </div>
                    <h1>零售<br/>短租</h1>
                    <div class="des">
                        <p class="p1">新场景、低成本、去库存、测市场、助推广、开店快</p>

                        <p class="p2">找到适合你的商业短租场地</p>
                    </div>
                    <div class="so">
                        <button class="so-join">提交需求</button>
                    </div>
                    <p class="to-up">
                        <i class="fa fa-chevron-up" aria-hidden="true"></i>
                    </p>
                </div>
            </section>
        </div>
        <div class="swiper-slide">
            <section class='part2'>
            <div class="step-des">
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
                <p class="to-up">
                    <i class="fa fa-chevron-up" aria-hidden="true"></i>
                </p>
            </div>
            </section>
        </div>
        <div class="swiper-slide">
            <section class="part3">
                <header>提交需求场地</header>
                {include file="Web_Mobile_Static::retail/inc/step_one.tpl"}
                {include file="Web_Mobile_Static::retail/inc/step_two.tpl"}
                {include file="Web_Mobile_Static::retail/inc/step_three.tpl"}
                <p class="step1-error"></p>
            </section>
            <section class="part4">
                <div class="retail_img">
                    <nav class="clearfix" id="img-change">
                        <a href="javascript:;" class="tab-active">最新动态</a>
                        <a href="javascript:;">品牌案例</a>
                    </nav>
                    {if count($page->information)>0}
                        <ul class="list clearfix none">
                            {foreach $page->information as $k=>$v}
                                {if $k==0 || $k==5}
                                    <li class="first">
                                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html"
                                           data-title="{$v['title']}">
                                            <img alt="" data-original="{Page_Site_Global::displayMedia($v['logo'],500,208)}">
                                        </a>
                                    </li>
                                {elseif $k==1 || $k==6}
                                    <li class="second">
                                        {foreach $v as $kk=>$vv}
                                            <a href="{$_home}article/{Func_NumEncode::e($vv['id'])}.html"
                                               data-title="{$vv['title']}">
                                                <img  alt=""
                                                      data-original="{Page_Site_Global::displayMedia($vv['logo'],165,123)}">
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
                                                  data-original="{Page_Site_Global::displayMedia($v['logo'],165,249)}">
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
            <footer class="part5">
                <div class="company">
                    <header>合作伙伴</header>
                    <div class="company-list">
                        <ul class="clearfix">
                            <li><img src="img/retail/pn_03.png" alt=""></li>
                            <li><img src="img/retail/pn_05.png" alt=""></li>
                            <li><img src="img/retail/pn_07.png" alt=""></li>
                            <li><img src="img/retail/pn_12.png" alt=""></li>
                            <li><img src="img/retail/pn_13.jpg" alt=""></li>
                        </ul>
                    </div>
                </div>
            </footer>
            <div class="to-top"></div>
        </div>
    </div>
</div>





{static "core/yunspace.js"}
{static "retail_m/swiper.3.1.2.min.js"}
{static "v3.0/block.1.0.1.js"}
{static "retail_m/retail_m.js"}

<script>

</script>
</body>
</html>
