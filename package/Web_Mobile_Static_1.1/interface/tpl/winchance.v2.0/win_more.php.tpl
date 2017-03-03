<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/mobile_winchance.v2.0/winchance_mbl.css">
    {static "v1.0/jquery-1.11.1.min.js"}
    {include file="Web_Mobile_Static::winchance/inc.winchance_meta.tpl"}
    <title>文创活动 - 文创活动【云·Space－商业空间短租平台】</title>
</head>
<body>
<!--标题-->
<div class="win-title">
    <a href="{$_home}winchance" class="icon-back"></a>
    <p>合作活动</p>
</div>
<!--合作活动-->
{if $winchance_list}
<div class="w-act" id="content">
    {foreach $winchance_list as $key => $value}
    <div class="w-act-cont" data-createTime="{$value['create_time']}">
        <div class="img">
            {*<img src="{Page_Site_Global::displayMedia($value['media'][0]['path'],768,394)}">*}
            <img src="{Page_Site_Global::displayMedia($value['media'][0]['path'],768,520)}">
        </div>
        <div class="col-ct-tit">
            <h3>{$value['title']}</h3>
            <p>{$value['marketing_title']}</p>
        </div>
        <div class="col-ct-mk">
            {foreach $value['tags_info'][0] as $k_tags=>$v_tags}
                <span>{$v_tags}</span>
            {/foreach}
        </div>
        <p>类别：<span>{foreach $category as $ck=>$cv}{if $value['category']==$ck}{$cv}{/if}{/foreach}</span></p>
        <p>来&nbsp;&nbsp;源：<span>{$value['attr']['来源']}</span></p>
        <p>场地面积：<span>{$value['attr']['面积']}</span></p>
        <p>适用人群：<span>{$value['attr']['适用人群']}</span></p>
        {if !empty($value['attr']['预算上限']) && !empty($value['attr']['预算下限'])}
            <p>预算范围：<span>{$value['attr']['预算上限']}元&nbsp;-&nbsp;{$value['attr']['预算下限']}元</span></p>
        {elseif !empty($value['attr']['预算上限']) && empty($value['attr']['预算下限'])}
            <p>预算范围：<span>{$value['attr']['预算上限']}元起</span></p>
        {elseif empty($value['attr']['预算上限']) && !empty($value['attr']['预算下限'])}
            <p>预算范围：<span>0元&nbsp;-&nbsp;{$value['attr']['预算下限']}元</span></p>
        {elseif empty($value['attr']['预算上限']) && empty($value['attr']['预算下限'])}
            <p>预算范围：<span>暂无</span></p>
        {/if}
        {if count($winchance_list)<5 && $key==count($winchance_list)-1}
        <div class="col-ct-btn clearfix" style="border-bottom: none;">
            {else}
            <div class="col-ct-btn clearfix">
                {/if}
                <a class="btn btn-hz" href="tel:400-056-0599"><span class="icon-hz"></span>合作咨询</a>
            </div>
        </div>
        {/foreach}
</div>
<div class="load-more">加载中...</div>
{/if}
{static "core/yunspace.js"}
{static "winchance.v2.0/mobile_winchance.js"}
{include "Web_Static::v2.0/html_tj.tpl"}
</body>
</html>