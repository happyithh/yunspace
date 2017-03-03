<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/raiders-info/{$page->id}.html"}
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    {include file="Web_Static::v2.0/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/v2.0/common.css">
    <link rel="stylesheet" type="text/css" href="css/raiders/raiders-info.css">
    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/comment.css"/>

    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/bootstrap.min.css"/>

    <link rel="stylesheet" href="{$_root}yun/plugins/comment/css/ionicons.min.css"/>
    <link rel="stylesheet" href="css/v1.0/global.css"/>
    {*<script src="{$_root}yun/plugins/comment/js/comment.js"></script>*}
    {*<script src="{$_root}yun/plugins/comment/js/yunspace.js"></script>*}
    <script src="http://cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="http://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
</head>

<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="containers">
    <p class="back111"><a href="javascript:history.go(-1)"><<返回</a> </p>
    <p class="locate"><a href="{$root}">首页</a>&nbsp;>&nbsp;<a href="{$root}/raiders/">活动攻略</a>
        &nbsp;>&nbsp;
        {*<a href="{$root}/raiders/{$page->getRaidersDetail['category_id']}">{$page->allCategory[$page->getRaidersDetail['category_id']]['name']}</a>*}

        <a href="{$root}/raiders/{$page->getRaidersDetail['category_id']}">{$page->getRaidersDetail['category_name']}</a>

        &nbsp;>&nbsp;
        <a href="#">{$page->getRaidersDetail['title']}</a></p>

    <div class="raiders-info-left">
        <div class="raiders-info-title">{$page->getRaidersDetail['title']}</div>
        <ul class="raiders-pags">
            {*<li>专题分类：<span class="pag1">{$page->allCategory[$page->getRaidersDetail['category_id']]['name']}</span></li>*}
            <li id="classify">专题分类：<span class="pag1">{$page->getRaidersDetail['category_name']}</span></li>
            <li id="meankid">关键词：<span class="pag2">{implode(',',json_decode($page->getRaidersDetail['tags_info']))}</span></li>
            <li>作者：<span class="pag3">{$page->getRaidersDetail['author']}</span></li>
            <li>时间：<span class="pag2">{Date('Y-m-d H:i:s',$page->getRaidersDetail['create_time'])}</span></li>
            <li>阅读：<span class="pag4">{$page->getRaidersDetail['counter_view']}</span></li>
            <div class="clear"></div>
        </ul>
        <div class="raider-info-content">
            {$page->getRaidersDetail['cont']}
        </div>
        <div style="clear:both"></div>
        <div class="raiders-info-more raiders-info-line">
            <a href="{$_root}raiders">< 查看过去24小时发布的资讯</a>
        </div>
        <div class="raiders-info-share">
            <div class="raiders-info-share-left">
                <div class="raider-info-share-text">
                    分享到：
                </div>
                <div class="raider-info-share-icon">
                    {literal}
                        <div class="bdsharebuttonbox"><a href="#" class="bds_more" data-cmd="more"></a><a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a><a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a><a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a><a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a><a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信"></a></div>
                        <script>window._bd_share_config={"common":{"bdSnsKey":{},"bdText":"","bdMini":"2","bdMiniList":false,"bdPic":"","bdStyle":"0","bdSize":"32"},"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>  {/literal}
                </div>
            </div>
            <div class="raiders-info-share-right">
                <div class="comment-chat">
                    <a href="javascript:;" yun="comment/js/comment.js::wow@click" class="js-wow">
                        {*<span {if empty($page->getPraise['praise']) || $page->getPraise['praise']==0}class="glyphicon glyphicon-thumbs-up wow-1"{else}class="glyphicon glyphicon-thumbs-up wow-1 wow-active"{/if}}"></span>*}
                        <span {if $page->getRaidersDetail['counter_praise']>0}class="glyphicon glyphicon-thumbs-up wow-1 wow-active"{else}class="glyphicon glyphicon-thumbs-up wow-1"{/if}}"></span>
                    </a>
                    <p class="wow-num-1" style="margin-top: 3px;" title_id="{$page->getRaidersDetail['id']}">{$page->getRaidersDetail['counter_praise']}</p>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="reading">
            <div class="reading-title">
                相关阅读
            </div>
            <ul class="reading-content">
                {foreach $page->getRelationRead as $key=>$val}
                    <li><a href="{$_root}raiders-info/{$val['id']}.html">{mb_substr($val['title'],0,30,'utf-8')}</a></li>
                {/foreach}
            </ul>
        </div>
        {*<div class="comment">*}
            {*<div class="comment-title">*}
                {*精彩评论*}
            {*</div>*}
            {*<div class="comment-content">*}
                {*<div class="comment-pic">*}
                    {*{if $page->getPhoto['avatar']}*}
                        {*<img id="photo" src="{$page->getPhoto['avatar']}">*}
                    {*{else}*}
                        {*<img id="photo" src="img/raiders-info/tx1.jpg">*}
                    {*{/if}*}
                {*</div>*}
                {*<div class="comment-back-input">*}
                    {*<input type="text" class="comment-back-input-content">*}
                {*</div>*}
                {*<a href="javascript:;" yun="comment/js/comment.js::comment@click" class="call-back-submit" user_id="{$__user['id']}" from_type="1" parent_id="" from_id={$page->id}>评论</a>*}

                {*<div class="clear"></div>*}
            {*</div>*}
            {*<ul class="comment-list">*}
                {*{foreach $page->getCommentList['rows'] as $c}*}
                    {*<li>*}
                        {*<div class="comment-slide">*}
                            {*<div class="comment-img">*}
                                {*{if $c['avatar']}*}
                                    {*<img title="头像" src="{Page_Site_Global::displayMedia($c['avatar'],'50','50')}">*}
                                {*{else}*}
                                    {*<img src="img/chat.v1.0/lufei.jpg" alt=""/>*}
                                {*{/if}*}
                            {*</div>*}
                        {*</div>*}
                        {*<div class="comment-body">*}
                            {*<div class="comment-head clearfix" >*}
                                {*<div class="comment-person">*}
                                    {*{$c['fullname']}*}
                                {*</div>*}
                                {*<div class="comment-time">*}
                                    {*{Date('Y-m-d H:i:s',$c['create_time'])}*}
                                {*</div>*}
                            {*</div>*}

                            {*<div class="comment-content">*}
                                {*<p>{$c['cont']}</p>*}
                            {*</div>*}
                            {*<div class="comment-chat">*}
                                {*<a href="javascript:;"  yun="comment/js/comment.js::wowComment@click">*}
                                    {*<span {if in_array({$c['id']},$page->getCommentpraise)}class="glyphicon glyphicon-thumbs-up wow-2 wow-active"{else}class="glyphicon glyphicon-thumbs-up wow-2"{/if}></span>*}
                                    {*<p class="wow-num-2" comment_id="{$c['id']}" {if in_array({$c['id']},$page->getCommentpraise)}comment-praise="1"{else}comment-praise="0"{/if}>{$c['count_praise']}</p>*}
                                {*</a>*}
                            {*</div>*}
                            {*<div class="comment-back">*}
                                {*<div class="comment-back-input">*}
                                    {*<input type="text" class="comment-back-input-content"/>*}
                                {*</div>*}
                                {*<div class="call-submit clearfix">*}
                                    {*<a href="javascript:;"  yun="comment/js/comment.js::callBackWithComment@click"  class="call-back-submit js-call1" data-username="{$c['fullname']}" user_id="{$__user['id']}" from_type="1" parent_id="{$c['id']}" from_id={$page->id}>回复</a>*}
                                {*</div>*}
                            {*</div>*}
                        {*</div>*}
                    {*</li>*}
                {*{/foreach}*}
            {*</ul>*}
            {*{if $page->getCommentList['page']['dt'] !=0}*}
                {*<div class="pagers">*}
                    {*{if $page->getCommentList['page']['dpll']}*}
                        {*<a href="{$page->getCommentList['page']['dup']}1" title="First">第一页</a>*}
                        {*<a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dp']-1}"*}
                           {*title="Prev">上一页</a>*}
                    {*{else}*}
                        {*<a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>*}
                        {*<a href="" class="prev gray">&lt;&nbsp;上一页</a>*}
                    {*{/if}*}
                    {*{for $i=$page->getCommentList['page']['dpl'] to $page->getCommentList['page']['dpr']}*}
                        {*<a href="{$page->getCommentList['page']['dup']}{$i}"{if $i==$page->getCommentList['page']['dp']} class="active"{/if}>{$i}</a>*}
                    {*{/for}*}

                    {*{if $page->getCommentList['page']['dprr']}*}
                        {*<a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dp']+1}"*}
                           {*title="Next">下一页</a>*}
                        {*<a href="{$page->getCommentList['page']['dup']}{$page->getCommentList['page']['dtp']}"*}
                           {*title="Last">最后页</a>*}
                    {*{else}*}
                        {*<a href="" class="next gray">下一页&nbsp;&gt;</a>*}
                        {*<a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>*}
                    {*{/if}*}
                {*</div>*}
            {*{else}*}
                {*<div class=" fl clearfix " style="width:930px;text-align: center;" id="shafa">*}
                    {*来抢沙发哦~~*}
                {*</div>*}
            {*{/if}*}
        {*</div>*}
        <div class="clear"></div>
    </div>
    <div class="raiders-info-right">
        <div class="list_right">
            <div class="list_right_title">
                {if $page->getCommentLinks}
                相关套餐/场地
            </div>
            {foreach $page->getCommentLinks as $k=>$v}
                <div class="list_right_body">
                    <div class="t_content1">
                        {*{var_dump($v['url'])}*}
                        <a href="{$v[0]['url']}">
                            {if $v[0]['logo']}
                                <img src='{Page_Site_Global::displayMedia($v[0]['logo'],220,153)}' title='{if !empty($v[0]['set_name'])}
                                {$v[0]['set_name']}{else}{$v[0]['product_name']}{/if}'>
                            {else}
                                <img src="{Core::$urls['assets']}img/logo_a.png" title="{if !empty($v[0]['set_name'])}{$v[0]['set_name']}
                                {else}{$v[0]['product_name']}{/if}">
                            {/if}
                        </a>
                        <a href="{$v[0]['url']}"><span>{if !empty($v[0]['set_name'])}{$v[0]['set_name']}{else}{$v[0]['product_name']}{/if}</span></a>

                    </div>
                </div>
            {/foreach}
            {/if}
        </div>
</div>
            <div class="brand_list_right">
            <div class="weixin_left">
                <img src="img/raiders-info/weixin.jpg" alt="云space公众号">
            </div>
            <div class="weixin_right">
                <p class="weixin_p1"><span><img src="img/raiders-info/weixin_icon.jpg" alt="微信icon"> </span>微信扫一扫</p>
                <p class="weixin_p2">关注云SPACE公众号</p>
            </div>
            <div class="clear"></div>
            </div>
    </div>
    <div class="clear"></div>
</div>
{*{static "js/comment.js"}*}
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>