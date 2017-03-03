<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/retail"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {*{static "v4.0/re-common.css"}*}
    {static "v4.0/jquery-slide-fade.min.css"}
    {static "v4.0/swiper.3.1.2.min.css"}
    {static "retail/classify.css"}
    {static "retail/retail.css"}
    {static "retail/retail_new.css"}
</head>
<body data-form="{$_root}form">
{include file="Web_Static::inc/header_1.tpl"}
<div class="lsyt">
    <div class="lsyt-bn">
        <img src="img/retail/lsxiaoji.jpg" alt="阳光鸡">
    </div>
    <div class="so-join">
        <button>立即提交需求</button>
    </div>
</div>
<div class="step-content">
    <ul class="step-list">
        <li>
            <p>提交需求</p>
        </li>
        <li class="si1">
            <p>匹配场地&场景</p>
        </li>
        <li class="si2"><p>确定合作方式</p></li>
        <li class="si3"><p>品牌/内容落地</p></li>
        <li class="si4"><p>申请加入V+品牌库</p></li>
        <li class="si5"><p>平台战略推广与支持</p></li>
    </ul>
</div>
<div class="re-content-two">
    <div class="part">
        <div class="header header-active">
            <span>提交场地需求</span>
        </div>
        {include file="Web_Static::retail/inc/retail_step1.tpl"}
        {include file="Web_Static::retail/inc/retail_step2.tpl"}
        {include file="Web_Static::retail/inc/retail_step3.tpl"}

    </div>
</div>

<div class="re-content">
    <div class="part">
        <div class="header tab double">
            <span class="tab-active">最新动态</span>
            {*<span>品牌案例</span>*}
        </div>
        <div class="body">
            <div class="success-case">
                <ul class="clearfix">
                    {foreach $page->information as $k=>$v}
                    <li {if $k==1 || $k==5}class="special-width"{/if}>
                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                            {if $k==1 || $k==5}
                            <img alt="" src="{Page_Site_Global::displayMedia($v['logo'],666,305)}">
                            {else}
                                <img alt="" src="{Page_Site_Global::displayMedia($v['logo'],333,305)}">
                            {/if}
                            <p>{$v['title']}</p>
                        </a>
                    </li>
                  {/foreach}

                </ul>
            </div>
            {*<div class="success-case none">*}
                {*<ul class="clearfix">*}
                    {*{foreach $page->cooperationBrand as $k=>$v}*}
                        {*<li {if $k==1 || $k==5}class="special-width"{/if}>*}
                            {*<a href="{$_home}retail/brand/{Func_NumEncode::e($v['id'])}.html" target="_blank">*}
                                {*{if $k==1 || $k==5}*}
                                    {*<img alt="" src="{Page_Site_Global::displayMedia($v['logo'],666,305)}">*}
                                {*{else}*}
                                    {*<img alt="" src="{Page_Site_Global::displayMedia($v['logo'],333,305)}">*}
                                {*{/if}*}
                                {*<p>{$v['title']}</p>*}
                            {*</a>*}
                        {*</li>*}
                    {*{/foreach}*}
                {*</ul>*}
            {*</div>*}
        </div>
    </div>

</div>
<div class="re-content2">
    <div class="part2">
        <div class="header">
            <span>合作伙伴</span>
        </div>
        <div class="body">
            <div class="company_painter">
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <img src="img/retail/logo_01.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_02.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_03.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_04.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_5_03.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_06.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_07.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_08.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_09.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_10.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_11.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_12.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_13.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_15.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_16.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_17.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_18.jpg" alt="">
                        </div>
                        <div class="swiper-slide">
                            <img src="img/retail/logo_19.jpg" alt="">
                        </div>
                    </div>

                </div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </div>
    </div>
</div>

{*<div class="company-join">*}
    {*<div class="body">*}
        {*<div class="header">*}
            {*<span>品牌入驻</span>*}
        {*</div>*}
        {*<div class="error">*}
            {*公司名称未填写*}
        {*</div>*}
        {*<form action="" class="clearfix">*}
            {*<div class="form">*}
                {*<div class="form-item clearfix">*}
                    {*<div class="label">*&nbsp;公司名称</div>*}
                    {*<div class="input">*}
                        {*<input type="text" placeholder="请填写您的公司名称" data-error="公司名称未填写" name="company">*}
                    {*</div>*}
                {*</div>*}
                {*<div class="form-item clearfix">*}
                    {*<div class="label">*&nbsp;品牌名称</div>*}
                    {*<div class="input">*}
                        {*<input type="text" placeholder="请填写品牌名称" data-error="品牌名称未填写"  name="pinpai">*}
                    {*</div>*}
                {*</div>*}
                {*<div class="form-item clearfix">*}
                    {*<div class="label">*&nbsp;开店方式</div>*}
                    {*<div class="input">*}
                        {*<input type="text" placeholder="请选择开店方式" data-error="开店方式未填写"  name="method">*}
                    {*</div>*}
                {*</div>*}
                {*<div class="form-item clearfix">*}
                    {*<div class="label">*&nbsp;开店数量</div>*}
                    {*<div class="input">*}
                        {*<input type="number" placeholder="请选择开店数量" data-error="开店数量未填写" data-type="number" name="shop_num" min="0">*}
                    {*</div>*}
                {*</div>*}
                {*<div class="form-item clearfix">*}
                    {*<div class="label">*&nbsp;你的称呼</div>*}
                    {*<div class="input">*}
                        {*<input type="text" placeholder="请填写您的真实姓名" data-error="真实姓名未填写" name="username">*}
                    {*</div>*}
                {*</div>*}
                {*<div class="form-item clearfix">*}
                    {*<div class="label">*&nbsp;手机号码</div>*}
                    {*<div class="input">*}
                        {*<input type="text" placeholder="请输入12位有效数字,仅支持中国大陆"  name="join_phone" data-error="手机号码未填写或手机号码格式不正确"  data-type="phone">*}
                    {*</div>*}
                {*</div>*}
            {*</div>*}
            {*<button type="button" id="join">立即入驻</button>*}
        {*</form>*}
    {*</div>*}
{*</div>*}
<div class="join-tip none">
</div>
{include file="Web_Static::inc/code.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "v4.0/block.1.0.1.js"}
{static "v4.0/swiper.3.1.2.min.js"}
{static "v4.0/jquery.lazyload.min.js"}
{static "retail/retail.js"}
{static "retail/retail_new.js"}

</body>
</html>

