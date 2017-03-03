<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/raiders-info/{$page->id}.html"}
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "find.v3.0/find_info.css"}
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    <title>云发现</title>
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
<div class="content">



        {include file="Web_Static::find.v3.0/find_right_info.php.tpl"}
        {*筛选*}
        <div class="side-left">
            <div class="find-nav">
                <a href="/">首页</a>&nbsp;>&nbsp;<a href="/raiders">云·发现</a>&nbsp;>&nbsp;
                <a href="/raiders/{$page->topCategory['top_id']}">
                    {foreach $page->allCategory as $key=>$val}
                        {if $val['id'] == $page->topCategory['top_id']}{$val['name']}{/if}
                    {/foreach}
                </a>&nbsp;>&nbsp;{$page->getRaidersDetail['title']}
            </div>

            <div class="side-info-header">
                <div class="side-info-title">
                    {$page->getRaidersDetail['title']}
                </div>
                <div class="side-info-p">
                    {date('Y-m-d H:i:s',$page->getRaidersDetail['create_time'])}&nbsp;&nbsp;&nbsp;&nbsp;{$page->getRaidersDetail['author']}&nbsp;&nbsp;&nbsp;&nbsp;{foreach $page->allCategory as $key=>$val}
                        {if $val['id'] == $page->topCategory['top_id']}{$val['name']}{/if}
                    {/foreach}&nbsp;&nbsp;&nbsp;&nbsp;阅读：{$page->getRaidersDetail['counter_view']}
                </div>
            </div>

<div class="load-content">
    {$str_parent}
</div>


            {*w文章内容*}
            {*<div class="side-info-content">*}
                {*{$page->getRaidersDetail['cont']}*}
            {*</div>*}
            {*<div class="side-act-info" style="background: #f2f2f2;overflow: hidden">*}
                {*<div class="space-p">场地信息</div>*}
                {*<div class="space-code-img fl">*}
                    {*<img src="" alt="">*}
                {*</div>*}
                {*<div class="space-code fl">*}
                    {*<div class="space-code-title">*}
                        {*七叶香山*}
                    {*</div>*}
                    {*<div class="space-code-more">*}
                        {*服务标签：<a href="">商业发布</a>&nbsp;<a href="">文体娱乐</a>&nbsp;<a href="">新品发布会</a>&nbsp;<a href="">晚会年会</a>&nbsp;<a href="">主题展览</a>*}
                    {*</div>*}
                    {*<ul class="space-code-info-li">*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：</span>*}
                            {*<span class="space-code-info-li-p">北京</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">使用面积：</span>*}
                            {*<span class="space-code-info-li-p">100平米</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">行政区域：</span>*}
                            {*<span class="space-code-info-li-p">虹口区</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">空间层高：</span>*}
                            {*<span class="space-code-info-li-p">4.2米</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">所属商圈：</span>*}
                            {*<span class="space-code-info-li-p">外滩、海宁、和平公园</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">容纳人数：</span>*}
                            {*<span class="space-code-info-li-p">500人</span>*}
                        {*</li>*}
                        {*<li class="clear"></li>*}
                    {*</ul>*}
                    {*<div class="space-code-look">*}
                        {*<a href="">*}
                            {*查看详情&nbsp;>*}
                        {*</a>*}
                    {*</div>*}
                {*</div>*}
            {*</div>*}
            {*<div class="side-info-content">*}
                {*{$page->getRaidersDetail['cont']}*}
            {*</div>*}
            {*<div class="side-act-info" style="background: #f2f2f2;overflow: hidden">*}
                {*<div class="space-p">场地信息</div>*}
                {*<div class="space-code-img fl">*}
                    {*<img src="" alt="">*}
                {*</div>*}
                {*<div class="space-code fl">*}
                    {*<div class="space-code-title">*}
                        {*七叶香山*}
                    {*</div>*}
                    {*<div class="space-code-more">*}
                        {*服务标签：<a href="">商业发布</a>&nbsp;<a href="">文体娱乐</a>&nbsp;<a href="">新品发布会</a>&nbsp;<a href="">晚会年会</a>&nbsp;<a href="">主题展览</a>*}
                    {*</div>*}
                    {*<ul class="space-code-info-li">*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：</span>*}
                            {*<span class="space-code-info-li-p">北京</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">使用面积：</span>*}
                            {*<span class="space-code-info-li-p">100平米</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">行政区域：</span>*}
                            {*<span class="space-code-info-li-p">虹口区</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">空间层高：</span>*}
                            {*<span class="space-code-info-li-p">4.2米</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">所属商圈：</span>*}
                            {*<span class="space-code-info-li-p">外滩、海宁、和平公园</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">容纳人数：</span>*}
                            {*<span class="space-code-info-li-p">500人</span>*}
                        {*</li>*}
                        {*<li class="clear"></li>*}
                    {*</ul>*}
                    {*<div class="space-code-look">*}
                        {*<a href="">*}
                            {*查看详情&nbsp;>*}
                        {*</a>*}
                    {*</div>*}
                {*</div>*}
            {*</div>*}




            {if !empty($page->getRaidersDetail['detail_des'][0])}
            <div class="side-act-info">
                <p>信息</p>
                <p>{$page->getRaidersDetail['detail_des'][0]}</p>
                <p>{$page->getRaidersDetail['detail_des'][1]}</p>
                <p>{$page->getRaidersDetail['detail_des'][2]}</p>
                <p>{$page->getRaidersDetail['detail_des'][3]}</p>
            </div>
            {/if}




            {*<div class="side-act-info" style="background: #f2f2f2;overflow: hidden">*}
                {*<div class="space-p">场地信息</div>*}
                {*<div class="space-code-img fl">*}
                    {*<img src="" alt="">*}
                {*</div>*}
                {*<div class="space-code fl">*}
                    {*<div class="space-code-title">*}
                        {*七叶香山*}
                    {*</div>*}
                    {*<div class="space-code-more">*}
                        {*服务标签：<a href="">商业发布</a>&nbsp;<a href="">文体娱乐</a>&nbsp;<a href="">新品发布会</a>&nbsp;<a href="">晚会年会</a>&nbsp;<a href="">主题展览</a>*}
                    {*</div>*}
                    {*<ul class="space-code-info-li">*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">城&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;市：</span>*}
                            {*<span class="space-code-info-li-p">北京</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">使用面积：</span>*}
                            {*<span class="space-code-info-li-p">100平米</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">行政区域：</span>*}
                            {*<span class="space-code-info-li-p">虹口区</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">空间层高：</span>*}
                            {*<span class="space-code-info-li-p">4.2米</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">所属商圈：</span>*}
                            {*<span class="space-code-info-li-p">外滩、海宁、和平公园</span>*}
                        {*</li>*}
                        {*<li>*}
                            {*<span class="space-code-info-li-t">容纳人数：</span>*}
                            {*<span class="space-code-info-li-p">500人</span>*}
                        {*</li>*}
                        {*<li class="clear"></li>*}
                    {*</ul>*}
                    {*<div class="space-code-look">*}
                        {*<a href="">*}
                            {*查看详情&nbsp;>*}
                        {*</a>*}
                    {*</div>*}
                {*</div>*}
            {*</div>*}





            <div class="side-code">
                <p class="code1">关键词：
                    {foreach $page->getRaidersDetail['tags_info'] as $k=>$v}
                        <a href="/raiders/tags/{$v}" target="_blank" style="color: #5babfc;">{$v}</a>
                    {*{$page->getRaidersDetail['tags_info']}*}
                    {/foreach}
                </p>
                {*<p class="code2">责任编辑：{$page->getRaidersDetail['author']}</p>*}
            </div>

            <div class="zan-click" yun="find.v3.0/find-right.js::zanAdd@click" data-title_id="{$page->getRaidersDetail['id']}">
                <div class="zan-img">
                    <img src="img/find.v3.0/hand1.png" alt="">
                    <img src="img/find.v3.0/hand2.png" alt=""  class="none">
                </div>
                <div class="zan-num">{$page->getRaidersDetail['counter_praise']}</div>
            </div>

            <div class="info-share">
                <div class="share-add" yun="find.v3.0/find-right.js::shareAdd@click">
                    <span class="ion-android-add"></span>
                </div>
                <div class="code-weixin">
                    <div class="code-weixin-img">
                        {*<img src="" alt="">*}
                    </div>
                    <div class="code-weixin-p">
                        扫一扫二维码即可分享本文章
                    </div>
                </div>
                <ul class="share-img bdsharebuttonbox" data-tag="share_1">
                    <li>
                        <a  href="javascript:;"  class="share-weixin">
                            <img src="img/find.v3.0/iconfont-weixin.png" alt="">
                        </a>

                    </li>
                    <li>
                        <a href="http://connect.qq.com/widget/shareqq/index.html?url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-qq.png" alt="">
                        </a>

                    </li>
                    <li>
                        <a href="http://share.baidu.com/s?type=text&searchPic=1&sign=on&to=tsina&url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-xinlang.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="http://share.baidu.com/s?type=text&searchPic=0&sign=on&to=renren&url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-renren.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="http://share.baidu.com/s?type=text&searchPic=0&sign=on&to=twi&url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-twitter.png" alt="">
                        </a>
                    </li>
                    <li>
                        <a href="http://share.baidu.com/s?type=text&searchPic=0&sign=on&to=douban&url=" class="share-link">
                            <img src="img/find.v3.0/iconfont-doubanc.png" alt="">
                        </a>
                    </li>
                </ul>
                <span>分享到</span>
            </div>
            <div class="side-footer">
                <div class="side-footer-header">
                    <div class="side-footer-title">相关阅读</div>
                    <div class="side-footer-line"></div>
                </div>
                <ul class="side-footer-about">
                    {foreach $page->getRelationRead as $key=>$val}
                    <li>
                        <a href="/raiders-info/{$val['id']}.html">
                            <div class="li-square"></div>
                            <span>
                                {if mb_strwidth($val['title'],'UTF-8')>36}
                                    {mb_strimwidth($val['title'],0,36,'……','UTF-8')}
                                {else}
                                    {$val['title']}
                                {/if}
                            </span>
                        </a>
                    </li>
                    {/foreach}
                </ul>

            </div>
            <div class="side-footer" style="margin-top:5px;">
                <div class="side-footer-header">
                    <div class="side-footer-title">{if $page->getRelationProduct[0]['vendor_id']}热门场地{else}相关场地{/if} <a style="float: right;color:#b3b3b3" href="/space">更多></a></div>
                    <div class="side-footer-line"></div>
                </div>
                <ul class="side-footer-recommend">
                    {foreach $page->getRelationProduct as $k=>$v}
                        {if $k==2}
                            <li style="margin-right: 0px;">
                        {else}
                            <li>
                        {/if}
                        <a href="/service_info/{$v['id']}.html" target="_blank">
                            <div class="side-footer-recommend-li-img">
                                <img src="{Page_Site_Global::displayMedia($v['logo'],771,810)}" alt="{$v['product_name']}">
                            </div>
                            <div class="side-footer-recommend-li-cover">
                            </div>
                            <div class="side-footer-recommend-li-p1">{mb_strimwidth($v['product_name'],0,28,'','UTF-8')}</div>
                            <div class="side-footer-recommend-li-p2">{mb_strimwidth($v['addr'],0,34,'','UTF-8')}</div>
                            {if $v['price']>10000}
                            <div class="side-footer-recommend-li-link none">
                                {round($v['price']/100)}{$v['attr_index']['计价单位']|default:'元/天'}
                            </div>
                            {else}
                            <div class="side-footer-recommend-li-link none look-info">
                                查看详情
                            </div>
                            {/if}
                        </a>
                    </li>
                    {/foreach}
                </ul>
            </div>
        </div>



</div>
{*<script>*}
{*window._bd_share_config = {*}
{*common : {*}
{*bdText : '自定义分享内容',*}
{*bdDesc : '自定义分享摘要',*}
{*bdUrl : '自定义分享url地址',*}
{*bdPic : '自定义分享图片'*}
{*},*}
{*share : [{*}
{*"bdSize" : 30*}
{*}],*}
{*slide : [{*}
{*bdImg : 0,*}
{*bdPos : "right",*}
{*bdTop : 100*}
{*}],*}
{*//        image : [{*}
{*//            viewType : 'list',*}
{*//            viewPos : 'top',*}
{*//            viewColor : 'black',*}
{*//            viewSize : '16',*}
{*//            viewList : ['qzone','tsina','huaban','tqq','renren']*}
{*//        }],*}
{*selectShare : [{*}
{*"bdselectMiniList" : ['','','kaixin001','bdxc','tqf']*}
{*}]*}
{*}*}
{*with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];*}
{*</script>*}
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{*{static "core/yunspace.js"}*}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>