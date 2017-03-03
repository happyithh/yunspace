{*{var_dump($page->info)}*}
<!DOCTYPE>
<html>
<head>
    {*{include file="Web_Static::v4.0/html_goto_pc.tpl" url="m/wechat_article"}*}
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <meta name="viewport" content="width=device-width" />
    <meta name="full-screen" content="yes" /><!-- UC强制全屏 -->
    <meta name="x5-fullscreen" content="true" /><!-- QQ强制全屏 -->
    {static "wechat_web/wechat_web.css"}
</head>
<body>
<div class="webanner block_home_slider">
    <div id="home_slider" class="flexslider">
        <ul class="slides">
            {if $hot_list}
            {foreach $hot_list as $k=>$v}
                    <li>
                        <a href="{if $v['is_lnk']==1&&$v['link']}{$v['link']}{else}{$home}wechat_web_article_info?id={$v['id']}{/if}">
                        <div class="slide">
                            <img src="{$v['image']}" alt="{$v['title']}" />
                            <div class="caption">
                                <p class="title">{$v['title']}</p>
                            </div>
                        </div>
                        </a>
                    </li>
                {/foreach}
            {/if}
            {*<li>*}
                {*<div class="slide">*}
                    {*<img src="img/wechat_web/pic_home_slider_1.jpg" alt="" />*}
                    {*<div class="caption">*}
                        {*<p class="title">banner标题2</p>*}
                    {*</div>*}
                {*</div>*}
            {*</li>*}

            {*<li>*}
                {*<div class="slide">*}
                    {*<img src="img/wechat_web/pic_home_slider_1.jpg" alt="" />*}
                    {*<div class="caption">*}
                        {*<p class="title">banner标题3</p>*}
                    {*</div>*}
                {*</div>*}
            {*</li>*}
        </ul>
    </div><!--home_slider-end-->
</div><!--webanner-end-->
<input type="hidden" class="category_id" value="{$request['category_id']}">
<ul class="article_list">
    {if $data}
        {foreach $data as $k=>$v}
            <li data-updateTime="{$v['update_time']}">
                <a href="{if $v['is_lnk']==1&&$v['link']}{$v['link']}{else}{$home}wechat_web_article_info?id={$v['id']}{/if}">
                    <div class="img-wp"><img src="{$v['image']}"></div>
                    <div class="text">
                        <h5>{$v['title']}</h5>
                        <p>{mb_substr($v['introduction'],0,36,'utf-8')}</p>
                    </div>
                </a>
            </li>
        {/foreach}
    {/if}
    {*<li>*}
        {*<a href="javascript:;">*}
            {*<div class="img-wp"><img src="img/wechat_web/img-act.jpg"></div>*}
            {*<div class="text">*}
                {*<h5>云SPACE携手三源色打造汽车电商生态新格局</h5>*}
                {*<p>国内首家商业空间短租平台-云SPACE与中国汽车试驾</p>*}
            {*</div>*}
        {*</a>*}
    {*</li>*}
    {*<li>*}
        {*<a href="javascript:;">*}
            {*<div class="img-wp"><img src="img/wechat_web/img-act.jpg"></div>*}
            {*<div class="text">*}
                {*<h5>云SPACE携手三源色打造汽车电商生态新格局</h5>*}
                {*<p>国内首家商业空间短租平台-云SPACE与中国汽车试驾</p>*}
            {*</div>*}
        {*</a>*}
    {*</li>*}
    {*<li>*}
        {*<a href="javascript:;">*}
            {*<div class="img-wp"><img src="img/wechat_web/img-act.jpg"></div>*}
            {*<div class="text">*}
                {*<h5>云SPACE携手三源色打造汽车电商生态新格局</h5>*}
                {*<p>国内首家商业空间短租平台-云SPACE与中国汽车试驾</p>*}
            {*</div>*}
        {*</a>*}
    {*</li>*}
</ul>
<div class="load-more-wp">
    <a href="JavaScript:;" class="load-more">加载更多</a>
</div>

{include file="Web_Mobile_Static::inc/to_top.tpl"}
{static "core/yunspace.js"}
{static "wechat_web/wechat_web.js"}
{static "wechat_web/jquery.flexslider-min.js"}
{static "wechat_web/wechat_loadingmore.js"}
<script type="text/javascript">
    $(function () {
        //banner轮播
        $('#home_slider').flexslider({
            animation : 'slide',
            controlNav : true,
            directionNav : true,
            animationLoop : true,
            slideshow : true,
            slideshowSpeed: 3000,
            useCSS : false
        });

    });
</script>
</body>
</html>

