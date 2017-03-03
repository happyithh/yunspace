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
    {static "retail/retail_information.css"}
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="retail-information clearfix">
    <div class="main-content fl">
        <div class="bn_2">
            <img src="{Page_Site_Global::displayMedia($page->info['logo'],796,467)}" alt="">
            <p>{$page->info['title']}</p>

           <div class="share-block clearfix">

            <div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
               <span>分享到:</span>
           </div>
        </div>
        <div class="message">
            <div class="all-content">
                {$page->info['cont']}
            </div>
            <div class="zan">
                <a href="javascript:;" class=""  data-id="{$page->info['id']}"><span>{$page->info['counter_praise']}</span></a>
            </div>
            <div class="code-all">
                <ul class="clearfix">
                    {foreach $page->info['tags_info'] as $k=>$v}
                    <li><a href="">{$v}</a></li>
                    {/foreach}

                </ul>
            </div>
            <div class=" clearfix share-block-bottom">
                <span class="fl">分享到:</span>
                <div class="bdsharebuttonbox fl"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
            </div>

        </div>
        <div class="content-recommend">
            <div class="small-title">精心推荐</div>
            <div class="success-case">
                <ul class="clearfix">
                    {foreach $page->recommend as $k=>$v}
                    <li {if $k==1}class="special-width"{/if}>
                        <a href="{$_home}retail/information/{Func_NumEncode::e($v['id'])}.html">
                            <img  alt="" data-original="{if $k!=1}{Page_Site_Global::displayMedia($v['logo'],265,248)}{else}{Page_Site_Global::displayMedia($v['logo'],532,248)}{/if}">
                            <p>{$v['title']}</p>
                        </a>
                    </li>
                    {/foreach}
                </ul>
            </div>
        </div>
    </div>
    {include file="Web_Static::retail/inc.slide.tpl"}
</div>





{include file="Web_Static::inc/html_footer.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{static "core/yunspace.js"}
{static "retail/retail_painter.js"}
{static "v4.0/jquery.lazyload.min.js"}
<script>window._bd_share_config= { "common": { "bdSnsKey": { } ,"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"24" } ,"share": { } } ;with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>

<script>
    $(function() {
        $("img").lazyload({
            effect : "fadeIn"
        });
    });
</script>

</body>
</html>

