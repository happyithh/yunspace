<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/mobile_winchance.v2.0/winchance_mbl.css">
    {static "v1.0/jquery-1.11.1.min.js"}
    <title>文创活动 - 文创项目【云·Space－活动定制专家】</title>
</head>
<body>
{include "Web_Mobile_Static::v1.0/inc.nav.tpl"}
<div class="wch-title">
    <h1>文创活动</h1>
</div>
<div class="w-banner">
    <div class="show_find">
        <div class="show_find_body swiper-container">
            <div class="show_find_body_list swiper-wrapper">
                <div class="show_find_body_li swiper-slide">
                    <img src="img/winchance/w_banner.jpg">
                </div>
            </div>
        </div>
    </div>
</div>

<!--云·space的优势-->
<div class="w-adg">
    <div class="w-adg-cont w-adg-cont1">
        <div class="w-title">
            <h2>云·SPACE平台优势<br><p class="line"></p></h2>
        </div>
        <img src="img/winchance/adg_pt.jpg">
    </div>
    <div class="w-adg-cont w-adg-cont2">
        <div class="w-title">
            <h2 style="border-top:1px solid #e7e7e7">
                云·	SPACE团队优势<br><p class="line"></p>
            </h2>
        </div>
        <img src="img/winchance/adg_td.jpg">
    </div>
</div>

<!--合作活动-->
<div class="w-act">
    <div class="w-title">
        <h2>合作活动<br><p class="line"></p></h2>
    </div>
    {foreach $page->getHotList(5) as $k=>$v}
    <div class="w-act-cont">
        <div class="img">
            {*<img src="img/winchance/hz_img1.jpg">*}
            {*<img src="{Page_Site_Global::displayMedia($v['media'][0]['path'],768,394)}">*}
            <img src="{Page_Site_Global::displayMedia($v['media'][0]['path'],768,520)}">
        </div>
        <div class="col-ct-tit">
            <h3>{$v['title']}</h3>
            <p>{$v['marketing_title']}</p>
        </div>
        <div class="col-ct-mk">
            {foreach $v['tags_info'][0] as $k_tags=>$v_tags}
                <span>{$v_tags}</span>
                {*<span>标签</span>*}
                {*<span>标签</span>*}
                {*<span>标签</span>*}
            {/foreach}
        </div>
        <p>类别：<span>{foreach $category as $ck=>$cv}{if $v['category']==$ck}{$cv}{/if}{/foreach}</span></p>
        <p>来&nbsp;&nbsp;源：<span>{$v['attr']['来源']}</span></p>
        <p>场地面积：<span>{$v['attr']['面积']}</span></p>
        <p>适用人群：<span>{$v['attr']['适用人群']}</span></p>
        {if !empty($v['attr']['预算上限']) && !empty($v['attr']['预算下限'])}
            <p>预算范围：<span>{$v['attr']['预算上限']}元&nbsp;-&nbsp;{$v['attr']['预算下限']}元</span></p>
        {elseif !empty($v['attr']['预算上限']) && empty($v['attr']['预算下限'])}
            <p>预算范围：<span>{$v['attr']['预算上限']}元起</span></p>
        {elseif empty($v['attr']['预算上限']) && !empty($v['attr']['预算下限'])}
            <p>预算范围：<span>0元&nbsp;-&nbsp;{$v['attr']['预算下限']}元</span></p>
        {elseif empty($v['attr']['预算上限']) && empty($v['attr']['预算下限'])}
            <p>预算范围：<span>暂无</span></p>
        {/if}
        {if $k==4}
        <div class="col-ct-btn clearfix" style="border-bottom: none;">
        {else}
        <div class="col-ct-btn clearfix">
        {/if}
            <a class="btn btn-hz" data-id = {$v['id']} href="tel:400-056-0599"><span class="icon-hz"></span>合作咨询</a>
        </div>
    </div>
    {/foreach}
    {*<div class="w-act-cont">*}
        {*<div class="img">*}
            {*<img src="img/winchance/hz_img1.jpg">*}
        {*</div>*}
        {*<div class="col-ct-tit">*}
            {*<h3>CandyCrushSaga糖果大爆炸</h3>*}
            {*<p>圣诞英伦风，糖果嘉年华</p>*}
        {*</div>*}
        {*<div class="col-ct-mk">*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
        {*</div>*}
        {*<p>来&nbsp;&nbsp;源：<span>美国</span></p>*}
        {*<p>场地面积：<span>200平</span></p>*}
        {*<p>适用人群：<span>亲子</span></p>*}
        {*<div class="col-ct-btn clearfix">*}
            {*<a class="btn btn-hz" href="JavaScript:;"><span class="icon-hz"></span>合作咨询</a>*}
        {*</div>*}
    {*</div>*}
    {*<div class="w-act-cont">*}
        {*<div class="img">*}
            {*<img src="img/winchance/hz_img1.jpg">*}
        {*</div>*}
        {*<div class="col-ct-tit">*}
            {*<h3>CandyCrushSaga糖果大爆炸</h3>*}
            {*<p>圣诞英伦风，糖果嘉年华</p>*}
        {*</div>*}
        {*<div class="col-ct-mk">*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
        {*</div>*}
        {*<p>来&nbsp;&nbsp;源：<span>美国</span></p>*}
        {*<p>场地面积：<span>200平</span></p>*}
        {*<p>适用人群：<span>亲子</span></p>*}
        {*<div class="col-ct-btn clearfix">*}
            {*<a class="btn btn-hz" href="JavaScript:;"><span class="icon-hz"></span>合作咨询</a>*}
        {*</div>*}
    {*</div>*}
    {*<div class="w-act-cont">*}
        {*<div class="img">*}
            {*<img src="img/winchance/hz_img1.jpg">*}
        {*</div>*}
        {*<div class="col-ct-tit">*}
            {*<h3>CandyCrushSaga糖果大爆炸</h3>*}
            {*<p>圣诞英伦风，糖果嘉年华</p>*}
        {*</div>*}
        {*<div class="col-ct-mk">*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
        {*</div>*}
        {*<p>来&nbsp;&nbsp;源：<span>美国</span></p>*}
        {*<p>场地面积：<span>200平</span></p>*}
        {*<p>适用人群：<span>亲子</span></p>*}
        {*<div class="col-ct-btn clearfix">*}
            {*<a class="btn btn-hz" href="JavaScript:;"><span class="icon-hz"></span>合作咨询</a>*}
        {*</div>*}
    {*</div>*}
    {*<div class="w-act-cont">*}
        {*<div class="img">*}
            {*<img src="img/winchance/hz_img1.jpg">*}
        {*</div>*}
        {*<div class="col-ct-tit">*}
            {*<h3>CandyCrushSaga糖果大爆炸</h3>*}
            {*<p>圣诞英伦风，糖果嘉年华</p>*}
        {*</div>*}
        {*<div class="col-ct-mk">*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
            {*<span>标签</span>*}
        {*</div>*}
        {*<p>来&nbsp;&nbsp;源：<span>美国</span></p>*}
        {*<p>场地面积：<span>200平</span></p>*}
        {*<p>适用人群：<span>亲子</span></p>*}
        {*<div class="col-ct-btn clearfix">*}
            {*<a class="btn btn-hz" href="JavaScript:;"><span class="icon-hz"></span>合作咨询</a>*}
        {*</div>*}
    {*</div>*}
</div>
<a href="{$_home}winchance/list" class="link-more">查看更多合作活动</a>
{static "core/yunspace.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>