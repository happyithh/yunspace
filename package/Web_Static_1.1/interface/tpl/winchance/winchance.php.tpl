<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/winchance"}
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "home.v3.0/home.css"}
    {static "winchance/winchance.css"}
    {static "winchance/slide.css"}
    {static "v4.0/common.css"}
    {static "js/bootstrap.min.js"}
    {static "winchance/jquery.SuperSlide.2.1.js"}
    {*<title>文创项目</title>*}
    <style>
        .footer p a{ font-size: 12px;}
    </style>
</head>
<body>
{include file="Web_Static::inc/header_1.tpl"}
{include file="Web_Static::inc/public_space.tpl"}
{*{include file="Web_Static::v2.0/html_header3.1.tpl"}*}
<div class="w-banner">
    <div id="carousel-example-generic" class="carousel carousel0 slide" data-ride="carousel">
        <!-- Indicators -->
        <ol class="carousel-indicators carousel-indicators0">
            <li data-target="#carousel-example-generic" data-slide-to="0" class="carousel-gui active"></li>
        </ol>
        <!-- Wrapper for slides -->
        <div class="carousel-inner carousel-inner0" role="listbox"   style="overflow-x: hidden">
            <div class="item active">
                <img src="img/winchance/w-banner.jpg" alt="打破传统格局 将文创项目与商业体态结合">
            </div>
        </div>
        <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only ion-ios-arrow-left" style="display: block;line-height: 360px;font-size: 50px;"></span>
        </a>
        <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            <span class="sr-only ion-ios-arrow-right " style="display: block;line-height: 360px;font-size: 50px;">
            </span>
        </a>
    </div>
</div>

<!--合作活动-->
<div class="clearfix col-act w-1180 js-act-bordernone">
    <div class="clearfix col-title w-pink">
        <div class="icon"></div>
        <div class="txt">
            <h2 class="fl">文创项目</h2>
            {*<div class="fl col-act-kinds">*}
                {*<a href="javascript:;">动漫</a><span>|</span>*}
                {*<a href="javascript:;">刺激</a><span>|</span>*}
                {*<a href="javascript:;">经典</a><span>|</span>*}
                {*<a href="javascript:;">艺术</a><span>|</span>*}
                {*<a href="javascript:;">可爱</a>*}
            {*</div>*}
        </div>
    </div>

    {foreach $page->getHotList(4) as $k=>$v}
    <div class="clearfix col-cont">
        <div class="col-cont-img">
        <div class="bd">
            <ul>
                {foreach $v['media'] as $k_media=>$v_media}
                    <li><a href="javascript:;"><img src="{Page_Site_Global::displayMedia($v_media['path'],460,310)}" /></a></li>
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
        </div>
        {*<div class="col-cont-img">*}

            {*<div id="carousel-example-generic{$k+1}" class="carousel carousel-n slide" data-ride="carousel">*}
                {*<!-- Indicators -->*}
                {*<ol class="carousel-indicators">*}
                    {*<li data-target="#carousel-example-generic{$k+1}" data-slide-to="0" class="carousel-gui active"></li>*}
                    {*<li data-target="#carousel-example-generic{$k+1}" data-slide-to="1" class="carousel-gui"></li>*}
                    {*<li data-target="#carousel-example-generic{$k+1}" data-slide-to="2" class="carousel-gui"></li>*}
                    {*<li data-target="#carousel-example-generic{$k+1}" data-slide-to="3" class="carousel-gui"></li>*}
                {*</ol>*}
                {*<div class="carousel-inner" role="listbox" style="overflow-x: hidden">*}
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
        {*</div><!--col-cont-img-end-->*}
        <div class="col-ct-dtls">
            <div class="col-ct-tit">
                <h3>{$v['title']}</h3>
                <p>{$v['marketing_title']}</p>
                <div class="xuanf">{$v['marketing_title']}</div>
            </div>
            <div class="col-ct-mk">
                {foreach $v['tags_info'][0] as $k_tags=>$v_tags}
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
                <a class="btn btn-hz demandAsk" data-id = {$v['id']} href="JavaScript:;">合作咨询</a>
                {*<a class="btn btn-dn js-load" href="javascript:;" target="_blank">预览/下载</a>*}
                {*<a class="btn btn-dn" href="{$v['accessory']['name']}" target="_blank">预览/下载</a>*}
            </div>
        </div><!--col-ct-tit-end-->
    </div>
    {/foreach}<!--col-cont-end-->

    <a href="{$_root}winchance/list" class="col-act-more" alt="查看更多"></a>
</div><!--col-act-end-->

<!--其他进行中的活动-->
<div class="clearfix col-act-other w-1180">
    <div class="clearfix col-title w-green">
        <div class="icon"></div>
        <div class="txt">
            <h2>其他进行中的活动</h2>
        </div>
    </div>

    <ul class="clearfix col-cont col-act-list">
        {*{foreach $page->getOtherList as $k=>$v}*}
        <li>
            <a class="img" target="_blank" href="/article/2740972.html"><img src="img/winchance/qianlonghao.jpg"></a>
            <div class="text">
                <a href="/raiders-info/2970.html" target="_blank">
                    <h5>《乾隆号，下一个江南》</h5>
                    <p>超时空潮玩艺术大展</p>
                    <div class="shade"></div>
                </a>
            </div>
        </li>
        <li>
            <a class="img" target="_blank" href="/article/2833240.html"><img src="img/winchance/zuichun.jpg"></a>
            <div class="text">
                <a href="/raiders-info/3400.html" target="_blank">
                    <h5>疯狂达利亮相外滩十八号</h5>
                    <p>六大亮点带你先睹为快</p>
                    <div class="shade"></div>
                </a>
            </div>
        </li>
        <li>
            <a class="img" target="_blank" href="/article/2837274.html"><img src="img/winchance/halibote.jpg"></a>
            <div class="text">
                <a href="/raiders-info/3420.html" target="_blank">
                    <h5>哈利波特全球巡回展来上海</h5>
                    <p>魔法世界大门即将开启</p>
                    <div class="shade"></div>
                </a>
            </div>
        </li>
        <li>
            <a class="img" target="_blank" href="/article/2746424.html"><img src="img/winchance/shenjingbing.jpg"></a>
            <div class="text">
                <a href="/raiders-info/2994.html" target="_blank">
                    <h5>魔都首届“精神病展”</h5>
                    <p>99%的人表示看不懂</p>
                    <div class="shade"></div>
                </a>
            </div>
        </li>
        <li>
            <a class="img" target="_blank" href="/article/2635045.html"><img src="img/winchance/tuomasi.jpg"></a>
            <div class="text">
                <a href="/raiders-info/2536.html" target="_blank">
                    <h5>托马斯70周年星动天地游</h5>
                    <p>无限想象力的奇妙世界</p>
                    <div class="shade"></div>
                </a>
            </div>
        </li>
        {*{/foreach}*}

    </ul><!--col-cont-end-->

    <a href="{$_root}sites/200" class="col-more">查看更多…</a>
</div><!--col-act-other-end-->

<!--云·space的优势-->
<div class="col-adg w-1180">
    <div class="clearfix col-title w-yellow">
        <div class="icon"></div>
        <div class="txt">
            <h2>云·SPACE的优势</h2>
        </div>
    </div>

    <div class="clearfix col-cont">
        <div class="col-adg-ct col-adg-pt">
            <h3>平台优势</h3>
            <ul class="col-adg-ul clearfix">
                <li>
                    <img src="img/winchance/adg2.png">
                    <p>全面整合文创资源<br><span style="font-size: 16px;">(已有合作版权近50家)</span></p>
                </li>
                <li>
                    <img src="img/winchance/adg1.png">
                    <p>一站式采购<br>省心又省力</p>
                </li>
                <li>
                    <img src="img/winchance/adg3.png">
                    <p>全方位合作模式<br>高人气 & 高收益</p>
                </li>
                <li>
                    <img src="img/winchance/adg4.png">
                    <p>极大减少版权费<br>有效降低运营成本</p>
                </li>
                <li>
                    <img src="img/winchance/adg5.png">
                    <p>全国性平台<br>多城市全面推广</p>
                </li>
            </ul>
        </div>
        <div class="col-adg-ct col-adg-td">
            <h3>团队优势</h3>
            <ul class="col-adg-ul clearfix">
                <li>
                    <img src="img/winchance/adg6.png">
                    <p><span>10</span>年商业地产运营经验</p>
                </li>
                <li>
                    <img src="img/winchance/adg7.png">
                    <p><span>7</span>年创意领域实际操作经验</p>
                </li>
                <li>
                    <img src="img/winchance/adg8.png">
                    <p>丰富的广告创意&活动执行经验</p>
                </li>
            </ul>
        </div>

    </div><!--col-cont-end-->
</div><!--col-adg-end-->

<!--合作案例-->
<div class="col-case-bg">
    <div class="col-case w-1180">
        <div class="clearfix col-title w-dlgreen">
            <div class="icon"></div>
            <div class="txt">
                <h2>合作案例</h2>
            </div>
        </div>

        <ul class="clearfix col-cont">
            {*{foreach $page->getWinCase as $k=>$v}*}
            {*<li>*}
                {*<a href="{$_root}raiders-info/{$v['id']}.html">*}
                    {*<div class="img"><img src="{Page_Site_Global::displayMedia($v['logo'],282,188)}" ></div>*}
                    {*<div class="text">*}
                        {*<h5>{if mb_strlen($v['title'],'UTF-8')>17}*}
                                {*{mb_substr($v['title'],0,17,'utf-8')}...*}
                            {*{else}{$v['title']}*}
                            {*{/if}</h5><!--这里做一下字数限制，不超过2行（看完删掉注释）-->*}
                        {*<div class="time">{$v['create_time']}</div>*}
                        {*<p>*}
                            {*{if mb_strlen($v['des'],'UTF-8')>46}*}
                            {*{mb_substr($v['des'],0,46,'utf-8')}...*}
                            {*{else}{$v['des']}*}
                            {*{/if}*}
                        {*</p><!--这里做一下字数限制，不超过4行（看完删掉注释）-->*}
                    {*</div>*}
                {*</a>*}
            {*</li>*}
                <li>
                    <a href="/article/2877629.html" target="_blank">
                        <div class="img"><img src="img/winchance/lufugong.jpg" ></div>
                        <div class="text">
                            <h5>卢浮宫珍藏版画展</h5><!--这里做一下字数限制，不超过2行（看完删掉注释）-->
                            <div class="time">2015-10-14</div>
                            <p>近距离欣赏到“卢浮宫十大名画”：《蒙娜丽莎》、《最后的晚餐》、《自由引导人民》等众多耳熟能详的大师作品（版画），此次展览还有…</p><!--这里做一下字数限制，不超过4行（看完删掉注释）-->
                        </div>
                    </a>
                </li>
            <li>
                <a href="/article/2877438.html" target="_blank">
                    <div class="img"><img src="img/winchance/huanqiugang.jpg" ></div>
                    <div class="text">
                        <h5>艳遇环球港</h5><!--这里做一下字数限制，不超过2行（看完删掉注释）-->
                        <div class="time">2015-10-14</div>
                        <p>一年一度乞巧节，如果你足够幸运，已经遇到了对的ta那么恭喜你，从此之后，你在人来人往中，不会因为渺小和平凡而感到心慌，如果你…
                        </p><!--这里做一下字数限制，不超过4行（看完删掉注释）-->
                    </div>
                </a>
            </li>
            {*{/foreach}*}

        </ul><!--col-cont-end-->
    </div><!--col-case-end-->
</div>

<!--合作伙伴-->
<div class="col-partners w-1180">
    <div class="clearfix col-title w-purple">
        <div class="icon"></div>
        <div class="txt">
            <h2>合作伙伴</h2>
        </div>
    </div>

    <div class="col-cont">
        <img src="img/winchance/win-logo.jpg">
    </div><!--col-cont-end-->
</div><!--col-partners-end-->

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
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::winchance/inc/pop_consl.tpl"}
{include file="Web_Static::winchance/inc/pop_viewpdf.tpl"}
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::inc/html_footer.tpl"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>