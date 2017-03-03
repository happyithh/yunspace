<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {*{static "v4.0/re-common.css"}*}
    {static "v4.0/jquery-slide-fade.min.css"}
    {static "v4.0/swiper.3.1.2.min.css"}
    {static "retail/classify.css"}
    {static "retail/retail.css"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="lsyt">
    <div class="lsyt-bn">
        <img src="img/retail/lsyt.jpg" alt="">
    </div>
    <div class="so-join">
        <button>立即加盟</button>
    </div>
</div>
<div class="re-content">
    <div class="part">
        <div class="header header-active">
            <span>云SPACE优势</span>
        </div>
        <div class="body">
            <ul class="icon-list icon-first clearfix">
                <li class="icon1"><br/><br/>5万家商业空间<br/>类型多样，高效匹配</li>
                <li class="icon2"><br/><br/>大数据支持<br/>商业数据精准决策</li>
                <li class="icon3"><br/><br/>一站式拓展<br/>全渠道资源支持</li>
            </ul>
            <ul class="icon-list clearfix">
                <li class="icon4"><br/><br/>消费者引流<br/>百万用户共享经济</li>
                <li class="icon5"><br/><br/>灵活的合作方式<br/>专业流程，按需配备</li>
                <li class="icon6"><br/><br/>资深的团队<br/>丰富的零售实战经验</li>
            </ul>
        </div>
    </div>
</div>
<div class="re-content-two">
    <div class="part">
        <div class="header header-active">
            <span>短租空间</span>
        </div>
        <div class="body">
            <div class="space_img">
                <div class="space_left fl">
                    <a href="{$_home}spaces-category-tags/{Func_Url::str_urlencode('商业广场')}">
                        <img src="img/retail/bnn.jpg" alt="">
                        <p class='p1' data-p="商业广场">商业广场</p>
                    </a>
                </div>
                <div class="space_right fr">
                    <a href="{$_home}spaces-category-tags/{Func_Url::str_urlencode('特色场地')}">
                        <img src="img/retail/bnn2.jpg" alt="">
                        <p class='p1' data-p="特色场地">特色场地</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="re-content">
    <div class="part">
        <div class="header tab double" style="margin-bottom:28px;">
            <span class="tab-active" style="margin-right:90px;">行业资讯</span>
            <span>合作品牌</span>
        </div>
        <div class="body">
            <div class="success-case">
                <ul class="clearfix">
                    {foreach $page->information as $k=>$v}
                    <li {if $k==1 || $k==5}class="special-width"{/if}>
                        <a href="{$_home}retail/information/{Func_NumEncode::e($v['id'])}.html">
                            <img alt="" data-original="{$v['logo']}">
                            <p>{$v['title']}</p>
                        </a>
                    </li>
                  {/foreach}

                </ul>
            </div>
            <div class="success-case none">
                <ul class="clearfix">
                    {foreach $page->cooperationBrand as $k=>$v}
                        <li {if $k==1 || $k==5}class="special-width"{/if}>
                            <a href="{$_home}retail/brand/{Func_NumEncode::e($v['id'])}.html">
                                <img alt="" data-original="{$v['logo']}">
                                <p>{$v['title']}</p>
                            </a>
                        </li>
                    {/foreach}
                </ul>
            </div>
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
                            <img src="img/retail/logo_05.jpg" alt="">
                        </div>
                    </div>

                </div>
                <div class="swiper-button-prev swiper-button-white"></div>
                <div class="swiper-button-next swiper-button-white"></div>
            </div>
        </div>
    </div>
</div>

<div class="company-join">
    <div class="body">
        <div class="header">
            <span>品牌入驻</span>
        </div>
        <div class="error">
            公司名称未填写
        </div>
        <form action="" class="clearfix">
            <div class="form">
                <div class="form-item clearfix">
                    <div class="label">*&nbsp;公司名称</div>
                    <div class="input">
                        <input type="text" placeholder="请填写您的公司名称" data-error="公司名称未填写" name="company">
                    </div>
                </div>
                <div class="form-item clearfix">
                    <div class="label">*&nbsp;品牌名称</div>
                    <div class="input">
                        <input type="text" placeholder="请填写品牌名称" data-error="品牌名称未填写"  name="pinpai">
                    </div>
                </div>
                <div class="form-item clearfix">
                    <div class="label">*&nbsp;开店方式</div>
                    <div class="input">
                        <input type="text" placeholder="请选择开店方式" data-error="开店方式未填写"  name="method">
                    </div>
                </div>
                <div class="form-item clearfix">
                    <div class="label">*&nbsp;开店数量</div>
                    <div class="input">
                        <input type="number" placeholder="请选择开店数量" data-error="开店数量未填写" data-type="number" name="shop_num" min="0">
                    </div>
                </div>
                <div class="form-item clearfix">
                    <div class="label">*&nbsp;你的称呼</div>
                    <div class="input">
                        <input type="text" placeholder="请填写您的真实姓名" data-error="真实姓名未填写" name="username">
                    </div>
                </div>
                <div class="form-item clearfix">
                    <div class="label">*&nbsp;手机号码</div>
                    <div class="input">
                        <input type="text" placeholder="请输入12位有效数字,仅支持中国大陆"  name="join_phone" data-error="手机号码未填写或手机号码格式不正确"  data-type="phone">
                    </div>
                </div>
            </div>
            <button type="button" id="join">立即入驻</button>
        </form>
    </div>
</div>
<div class="join-tip none">
</div>
{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "core/yunspace.js"}
{static "v4.0/swiper.3.1.2.min.js"}
{static "v4.0/jquery.lazyload.min.js"}
{static "retail/retail.js"}
<script>
    $(function() {
        $("img").lazyload({
            effect : "fadeIn"
        });
    });
</script>

</body>
</html>

