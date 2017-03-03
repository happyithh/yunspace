<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/winchance/list"}
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "home.v3.0/home.css"}
    {static "winchance/winchance.css"}
    {static "winchance/slide.css"}
    {static "v4.0/common.css"}
    {static "js/bootstrap.min.js"}
    {static "js/winchance/winchance.js"}
    {static "winchance/jquery.SuperSlide.2.1.js"}
    <style>
        .footer p a{ font-size: 12px;}
    </style>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
{*{include file="Web_Static::v2.0/html_header3.1.tpl"}*}
<div class="site_location">
    <a href="/winchance/win">文创项目</a><span>&gt;</span>
    <a href="/winchance/list">更多合作项目</a><span></span>
</div>
<!--分类筛选-->
<div class="wch-screening clearfix">
    <div class="hvselected clearfix">
    <p class="fl name">已选条件：</p>
        {if !empty($action1)}
            {foreach $category as $k=>$v}
                {if $action1==$k}
                <p class="fl selected">{$v}<span class="shut">×</span></p>
                {/if}
    {*<p class="fl selected">游戏<span class="shut">×</span></p>*}
    {*<p class="fl selected">小于200㎡<span class="shut">×</span></p>*}
            {/foreach}
        {else}{/if}

    <a class="fr empty" href="/winchance/list">清空所有条件</a>
    </div>
    <div class="first classifying clearfix">
        <div class="fl cont-tit">
            <span class="wicon"></span>
            <span>类别</span>
        </div>
        <div class="fl cont clearfix">
            {foreach $category as $k=>$v}
                {*<div class="category_shang">{$v}</div>*}
                <a href="/winchance/list/{$k}" class="category_shang" {if $action1==$k}style="color:#f28e8e;"{/if}>{$v}</a>
            {/foreach}
            {*<a href="">亲子</a>*}
            {*<a href="">卡通</a>*}
            {*<a href="">艺术</a>*}
            {*<a href="">互动</a>*}
            {*<a href="">市集</a>*}
            {*<a href="">冒险</a>*}
            {*<a href="">科技</a>*}
            {*<a href="">可爱</a>*}
            {*<a href="">时尚</a>*}
            {*<a href="">家庭</a>*}
            {*<a href="">动漫</a>*}
            {*<a href="">影视</a>*}
            {*<a href="">游戏</a>*}
        </div><!--classifying-end-->
        {*<div class="fr clearfix">*}
            {*<a class="multiselect" href="">+多选</a>*}
            {*<a class="more" href="">更多<span class="icon-updown icon-up"></span></a>*}
        {*</div>*}
    </div><!--classifying-end-->
</div><!--wch-screening-end-->


<!--合作活动-->
<div class="clearfix col-act w-1180">

    {foreach $page->getWinList['rows'] as $k => $v}
    <div class="clearfix col-cont">
        <div class="col-cont-img">
            <div class="bd">
                <ul>
                    {foreach $v['media'] as $k_media=>$v_media}
                    <li><a href="javascript:;"><img src="{Page_Site_Global::displayMedia($v_media['path'],920,620)}" /></a></li>
                    {/foreach}
                </ul>
            </div>
            <div class="pnBtn prev">
                <span class="blackBg"></span>
                <a class="arrow" href="javascript:void(0)"></a>
            </div>
            <div class="pnBtn next">
                <span class="blackBg"></span>
                <a class="arrow" href="javascript:void(0)"></a>
            </div>
            {*<div id="carousel-example-generic{$k+1}" class="carousel carousel-n slide" data-ride="carousel">*}
                {*<!-- Indicators -->*}
                {*<ol class="carousel-indicators">*}
                    {*<li data-target="#carousel-example-generic{$k+1}" data-slide-to="0" class="carousel-gui active"></li>*}
                    {*<li data-target="#carousel-example-generic{$k+1}" data-slide-to="1" class="carousel-gui"></li>*}
                    {*<li data-target="#carousel-example-generic{$k+1}" data-slide-to="2" class="carousel-gui"></li>*}
                    {*<li data-target="#carousel-example-generic{$k+1}" data-slide-to="3" class="carousel-gui"></li>*}
                {*</ol>*}
                {*<!-- Wrapper for slides -->*}
                {*<div class="carousel-inner" role="listbox"   style="overflow-x: hidden">*}
                    {*{foreach $v['media'] as $k_media=>$v_media}*}
                        {*<div class="{if $k_media==0}item active{else}item{/if}">*}
                            {*<img src="{Page_Site_Global::displayMedia($v_media['path'],810,310)}" alt="云SPACE, 一场经典的活动 = 好创意 + 好场地">*}
                        {*</div>*}
                    {*{/foreach}*}
                {*</div>*}
                {*<div class="carousel-bg"></div>*}

                {*<a class="left carousel-control" href="#carousel-example-generic{$k+1}" role="button" data-slide="prev">*}
                    {*<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>*}
                    {*<span class="sr-only ion-ios-arrow-left" style="display: block;line-height: 310px;font-size: 50px;"></span>*}
                {*</a>*}
                {*<a class="right carousel-control" href="#carousel-example-generic{$k+1}" role="button" data-slide="next">*}
                    {*<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>*}
            {*<span class="sr-only ion-ios-arrow-right " style="display: block;line-height: 310px;font-size: 50px;">*}
            {*</span>*}
                {*</a>*}
            {*</div>*}
        </div><!--col-cont-img-end-->
        <div class="col-ct-dtls">
            <div class="col-ct-tit">
                <h3>{$v['title']}</h3>
                <p>{$v['marketing_title']}</p>
                <div class="xuanf">{$v['marketing_title']}</div>
            </div>
            <div class="col-ct-mk">
                {foreach $v['tags_info'][0] as $k_tags => $v_tags}
                <span>{$v_tags}</span>
                {*<span>标签</span>*}
                {*<span>标签</span>*}
                {*<span>标签</span>*}
                {/foreach}
            </div>
            <p>类&nbsp;&nbsp;别：<span>{foreach $category as $ck=>$cv}{if $v['category']==$ck}{$cv}{/if}{/foreach}</span></p>
            <p>来&nbsp;&nbsp;源：{$v['attr']['资源来自国家']}</p>
            <p>场地面积：{$area_array[$v['area']]}平米</p>
            <p>适用人群：{$v['conform_crowd']}</p>
            {if !empty($v['attr']['预算上限']) && !empty($v['attr']['预算下限'])}
                <p>预算范围：<span>{$v['attr']['预算上限']}元&nbsp;-&nbsp;{$v['attr']['预算下限']}元</span></p>
            {elseif !empty($v['attr']['预算上限']) && empty($v['attr']['预算下限'])}
                <p>预算范围：<span>{$v['attr']['预算上限']}元起</span></p>
            {elseif empty($v['attr']['预算上限']) && !empty($v['attr']['预算下限'])}
                <p>预算范围：<span>0元&nbsp;-&nbsp;{$v['attr']['预算下限']}元</span></p>
            {elseif empty($v['attr']['预算上限']) && empty($v['attr']['预算下限'])}
                <p>预算范围：<span>暂无</span></p>
            {/if}
            <div class="col-ct-btn">
                <a class="btn btn-hz demandAsk" data-id="{$v['id']}" href="JavaScript:;">合作咨询</a>
                {*<a class="btn btn-dn" href="{$v['accessory']['name']}" target="_blank">预览/下载</a>*}
            </div>
        </div><!--col-ct-tit-end-->
    </div>
    {/foreach}<!--col-cont-end-->
   <!--col-cont-end-->
    <!--页码部分-->
    {if $page->getWinList['page']['dt'] !=0}
        <div class="pagers">
            {if $page->getWinList['page']['dpll']}
                <a href="{$page->getWinList['page']['dup']}1" title="First">第一页</a>
                <a href="{$page->getWinList['page']['dup']}{$page->getWinList['page']['dp']-1}"
                   title="Prev">上一页</a>
            {else}
                <a href="" class="prev first gray"><span>&laquo;&nbsp;</span>第一页</a>
                <a href="" class="prev gray">&lt;&nbsp;上一页</a>
            {/if}
            {for $i=$page->getWinList['page']['dpl'] to $page->getWinList['page']['dpr']}
                <a href="{$page->getWinList['page']['dup']}{$i}"{if $i==$page->getWinList['page']['dp']} class="active"{/if}>{$i}</a>
            {/for}

            {if $page->getWinList['page']['dprr']}
                <a href="{$page->getWinList['page']['dup']}{$page->getWinList['page']['dp']+1}"
                   title="Next">下一页&nbsp;&gt;</a>
                <a href="{$page->getWinList['page']['dup']}{$page->getWinList['page']['dtp']}"
                   title="Last">最后页&nbsp;&raquo;</a>
            {else}
                <a href="" class="next gray">下一页&nbsp;&gt;</a>
                <a href="" class="next last gray">最后页<span>&nbsp;&raquo;</span></a>
            {/if}
        </div>
    {else}
        <div class=" fl clearfix no-r-raider">
            {include file="Web::inc/service_list_fl_no_result.tpl"}
        </div>
    {/if}
</div><!--col-act-end-->



<script>

    /* 把最后一个放到第一个前面，然后通过外层ul来显示第一个 */
    jQuery(".col-cont-img .bd li").first().before( jQuery(".slider .bd li").last() );
    /* 调用SuperSlide */
    jQuery(".col-cont-img").slide({ mainCell:".bd ul", effect:"leftLoop",  autoPlay:false, vis:3, autoPage:true, trigger:"click"});

    //当大banner只有一个图片时，左右按钮等隐藏
    if ($('.carousel-inner0').children().length < 2) {
        $('.carousel0 .carousel-control').hide();
        $('.carousel-indicators0').hide();
    }

    //大banner去掉自动播放功能
    $('.carousel-n').carousel({
        pause: true,
        interval: false
    })
    //小banner上的透明遮罩
    $('.carousel').hover(function () {
        $(this).find('.carousel-bg').toggle();
    });

    //合作活动列表最后一个元素去边框
    $('.col-act .col-cont:last-child').css('border','none');
</script>
{static "winchance/win_pop.js"}
{include file="Web_Static::winchance/inc/pop_consl.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>