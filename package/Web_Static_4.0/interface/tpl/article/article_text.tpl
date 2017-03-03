<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "articles/article.css"}
    {static "v4.0/pop-list.css"}
    {static "v4.0/recommend.css"}

</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
<div class="wrapper">
    <div class="crumb">
        <a href="{$_home}">首页</a><a href="{$_home}site/{Func_Url::str_urlencode($page->baikeInfo['space_name'])}">公司库</a> > <a href="" class="active">奢居会派对会所</a>
    </div>
    <div class="clearfix">
        <div class="article-content">
            <div class="article-title clearfix">
                <h2 class="clearfix"><i class="fl icon-a"></i><span class="fl">这是深圳最有特色的16家书店，你去过几家？</span></h2>
                <div class="list clearfix">
                    <p class="name">小懒猫</p>
                    <p>暂无评价</p><span></span>
                    <p>3人阅读</p><span></span>
                    <p>0次下载</p><span></span>
                    <p>暂无介绍</p>
                </div>
            </div><!--article-title-end-->
            <div class="article-cont">
                <div class="article-cont-text">
                    <p>阅读是现代城市生活不可或缺的部分，一个城市里，做得最好的书店总是能在很大程度上反映出这个城市的文化品质。24小时书店，一家通宵营业的书店；荒野书店，年轻人的秘密基地；西西弗，当年连锁民营书店留下来的火种尚书吧，深圳文化人的沙龙……近几年，作家签售。</p>
                </div>
                <div class="download-btn-wrap">
                    <p>当前<span>30人下载</span></p>
                    <a href="" class="download-btn">
                        <i class="icon-a icon-dload"></i>
                        下载/预览
                    </a>
                </div>
            </div><!--article-cont-end-->
            <div class="article-recommend">
                <h3>你可能喜欢</h3>
                <div class="collection-title clearfix">
                    <div class="title-list">
                        <a href="" class="current">场地库</a>
                        <a href="">项目库</a>
                        <a href="">公司库</a>
                        <a href="">文库</a>
                    </div>
                </div>
                <ul class="article-recommend-cont">
                    <li class="clearfix"><i class="fl icon-a icon-word"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>
                    <li class="clearfix"><i class="fl icon-a icon-excel"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>
                    <li class="clearfix"><i class="fl icon-a icon-ppt"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>
                    <li class="clearfix"><i class="fl icon-a icon-pdf"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>
                </ul>
            </div>
        </div>
        <div class="art-aside">
            {*相关百科*}
            {if $page->baikeInfo['space_name']}
                <div class="aside-top top-img-wrap">
                    <a href="{$_home}site/{$page->baikeInfo['space_name']}" class="list-a">
                        <img src="{Page_Site_Global::displayMedia($page->baikeInfo['logo'],322,195)}" alt="">
                        <span class="mask"></span>
                        <span class="title">{$page->baikeInfo['space_name']}</span>
                        {*<div class="line"></div>*}
                        <span class="sub-title">{$page->baikeInfo['addr']}</span>
                        <div class="numb">
                            <div class="numb-in">
                                <p class="fr numb-right">{$page->baikeInfo['sum']}</p>
                                <p class="fl numb-left">{$page->baikeInfo['click']}</p>
                            </div>
                        </div>
                    </a>
                </div>
            {/if}
            {*精品推荐*}
            <div class="recomend">
                <div class="recomend-title"><span>精选推荐</span></div>
                <div class="recomend-list">
                    {foreach $page->isGoodArticle as $k=>$v}
                        <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" target="_blank">
                            <div class="recomend-list-li clearfix">
                                <div class="recomend-li-left fl">
                                    <div class="recomend-p"><span>{$v['title']}</span></div>
                                    <div class="recomend-time"><span>{Func_Time::Format($v['create_time'])}</span></div>
                                </div>
                                <div class="recomend-li-right fr">
                                    <img src="{Page_Site_Global::displayMedia($v['logo'],"80","57")}" alt="">
                                </div>
                            </div>
                        </a>
                    {/foreach}
                </div>
            </div>
            <div class="aside-tags">
                {if $page->baikeTags}
                    {foreach $page->baikeTags as $k=>$v}
                        <a href="{$_home}site/{$page->baikeInfo['space_name']}-最新-{$k}-tags/{$v}" target="_blank">{$v}</a>
                    {/foreach}
                {/if}
            </div>
            {*最新文章*}
            <div class="fixed-wrap">
                <div class="fixed-piece" id="fixedPiece">
                    <div class="recomend-title mb20"><span>最新文章</span></div>
                    <ul class="consult-list">
                        {foreach $page->isNewArticle as $k=>$v}
                            <li>
                                <h3>
                                    <a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html" class="consult-li" target="_blank">
                                        <div class="circle"></div>
                                        <div class="title"><span>{$v['title']}</span></div>
                                        <div class="time"><span>{Func_Time::Format($v['create_time'])}</span></div>
                                    </a>
                                </h3>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
{include file="Web_Static::inc/public_space.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{static "article/article.js"}
{static "core/yunspace.js"}
</body>
</html>