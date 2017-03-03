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
        <a href="{$_home}">首页</a>{if count($page->baikeInfo['space_name'])>0} > <a href="{$_home}site/{Func_Url::str_urlencode($page->baikeInfo['space_name'])}">{$page->baikeInfo['space_name']}</a>{/if} > <a href="" class="active">{$page->info['title']}</a>
    </div>
    <div class="clearfix">
        <div class="article-content">
            <div class="article-title clearfix">
                {*{var_dump($page->info['paperType'])}*}
                <h2 class="clearfix" style="margin-bottom:20px;"><i class="fl icon-a {if $page->info['paperType']=='doc'}icon-word{elseif $page->info['paperType']=='xls'}icon-excel{elseif $page->info['paperType']=='ppt'}icon-ppt{elseif $page->info['paperType']=='pdf'}icon-pdf{/if}"></i><span class="fl">{$page->info['title']}</span></h2>
                <div class=" clearfix des">
                        <span>{$page->info['author']|default:"云SPACE"}</span>
                        <span>{date('Y-m-d',$page->info['create_time'])}</span>
                        <span>浏览量 {$page->info['counter_view']}</span>
                        {*<span>评论</span>*}
                </div>
            </div><!--article-title-end-->

            <div class="article-cont">
                {$page->info['cont']}
                {if $page->info['accessory']['name']}
                <div class="download-btn-wrap">
                    <p>当前<span> {$page->info['download']} 人下载</span></p>
                    <a href="JavaScript:;" data-id="{$page->info['id']}" data-title="{$page->info['accessory']['name']}" class="download-btn accessory">
                        <i class="icon-a icon-dload"></i>
                        下载/预览
                    </a>
                </div>
                {/if}
            </div><!--article-cont-end-->

            <div class="article-recommend">
                <h3>你可能喜欢</h3>
                <div class="collection-title clearfix">
                    <div class="title-list">
                        <a href="javascript:;" class="current"}>活动方案</a>
                        <a href="javascript:;" >策划技巧</a>
                        <a href="javascript:;" >演讲稿</a>
                        <a href="javascript:;" >营销传播</a>
                    </div>
                </div>
                <ul class="article-recommend-cont">
                    {foreach $page->paperActivity as $k=>$v}
                    <li class="clearfix"><i class="fl icon-a
                    {if $v['paperType']=='doc'}icon-word{elseif $v['paperType']=='xls'}icon-excel{elseif $v['paperType']=='ppt'}icon-ppt{elseif $v['paperType']=='pdf'}icon-pdf{/if}">

                    </i><a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a></li>
                    {*<li class="clearfix"><i class="fl icon-a icon-excel"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                    {*<li class="clearfix"><i class="fl icon-a icon-ppt"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                    {*<li class="clearfix"><i class="fl icon-a icon-pdf"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                    {/foreach}
                </ul>
                <ul class="article-recommend-cont none">
                    {foreach $page->paperPlanning as $k=>$v}
                        <li class="clearfix"><i class="fl icon-a
                    {if $v['paperType']=='doc'}icon-word{elseif $v['paperType']=='xls'}icon-excel{elseif $v['paperType']=='ppt'}icon-ppt{elseif $v['paperType']=='pdf'}icon-pdf{/if}">

                            </i><a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a></li>
                        {*<li class="clearfix"><i class="fl icon-a icon-excel"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                        {*<li class="clearfix"><i class="fl icon-a icon-ppt"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                        {*<li class="clearfix"><i class="fl icon-a icon-pdf"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                    {/foreach}
                </ul>
                <ul class="article-recommend-cont none">
                    {foreach $page->paperSpeech as $k=>$v}
                        <li class="clearfix"><i class="fl icon-a
                    {if $v['paperType']=='doc'}icon-word{elseif $v['paperType']=='xls'}icon-excel{elseif $v['paperType']=='ppt'}icon-ppt{elseif $v['paperType']=='pdf'}icon-pdf{/if}">

                            </i><a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a></li>
                        {*<li class="clearfix"><i class="fl icon-a icon-excel"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                        {*<li class="clearfix"><i class="fl icon-a icon-ppt"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                        {*<li class="clearfix"><i class="fl icon-a icon-pdf"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                    {/foreach}
                </ul>
                <ul class="article-recommend-cont none">
                    {foreach $page->paperMarketing as $k=>$v}
                        <li class="clearfix"><i class="fl icon-a
                    {if $v['paperType']=='doc'}icon-word{elseif $v['paperType']=='xls'}icon-excel{elseif $v['paperType']=='ppt'}icon-ppt{elseif $v['paperType']=='pdf'}icon-pdf{/if}">

                            </i><a href="{$_home}article/{Func_NumEncode::e($v['id'])}.html">{$v['title']}</a></li>
                        {*<li class="clearfix"><i class="fl icon-a icon-excel"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                        {*<li class="clearfix"><i class="fl icon-a icon-ppt"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                        {*<li class="clearfix"><i class="fl icon-a icon-pdf"></i><a href="">这是深圳最有特色的16家书店，你去过几家？</a></li>*}
                    {/foreach}
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
<script>
    $(document).ready(function () {
        $(".accessory").click(function(){
            var id = $(this).data('id');
            var  title = $(this).data('title');
            console.log(id,title);
            YunSpace.api('raiders/download.jsonp', {
                id:id
            },function (data) {
                if(data.status == 1){
                    window.location.href="http://{Core::$urls['host']}"+title;
                }else{
                    top.alert(data.msg);
                }
            });
        });
        $(".title-list").find("a").each(function(index,dom) {
            $(dom).hover(function(){
                $(".title-list").find("a").removeClass('current');
                $(this).addClass('current');
                $(".article-recommend-cont").addClass('none');
                $(".article-recommend-cont").eq(index).removeClass('none');
            },function(){

            })
        })
    });
</script>
</body>
</html>