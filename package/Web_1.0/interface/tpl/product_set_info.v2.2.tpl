<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/set_info/{$page->id}.html"}
    {include file="inc/html_head.tpl"}
    <link type="text/css" href="css/set-info.css" rel="stylesheet"/>
    <link href='css/jquery.fancybox.css' rel='stylesheet' media="screen"/>
    <link href='css/jcarousel.connected-carousels.css' rel='stylesheet' media="screen"/>
    <script src='js/set-info.js'></script>
    <script src='js/set-info-foucs2.js'></script>
    <script src='js/set-info-foucs.js'></script>
    <script src='js/jquery.fancybox.js'></script>
    <script src='js/jquery.fancybox.pack.js'></script>
    <script src='js/collect.js'></script>
</head>
<body style="position: relative;" data-spy="scroll" data-target="#navbar-example">
{include file="Web_Static::v2.0/html_header3.1.tpl"}

<div class="container-set">
    {*head*}
    <p class="position">
        <a href="/">{$smarty.cookies.city}</a>&nbsp;>&nbsp; <a href="/set_list/">超值套餐</a>&nbsp;>&nbsp;<a href="/set_list/{$page->info['category_id']}">{$page->allCategory[$page->info['category_id']]}</a>&nbsp;>&nbsp;<a href="#">{$page->info['set_name']}</a>
    </p>

    <div class="head">
        <div class="head-left">
            <div class="wrapper">
                <div class="connected-carousels">
                    <div class="stage">
                        <div class="carousel carousel-stage">
                            <ul>
                                {foreach $page->media as $mk=>$mv}
                                    {foreach $mv as $vv}
                                        <li>
                                            {if $vv[2]}
                                                <a href="{$vv[2]}" class="imageBox videoBox" data-fancybox-group="gallery">
                                                    <img src="{Page_Site_Global::displayMedia($vv[1],415,415,2)}" width="415" height="415"
                                                            />
                                                </a>
                                            {else}
                                                <a href="{Page_Site_Global::displayMedia($vv[1],768,0,1)}" class="imageBox"
                                                   data-fancybox-group="gallery">
                                                    <img src="{Page_Site_Global::displayMedia($vv[1],415,415,1)}" width="415" height="415"
                                                            />
                                                </a>
                                            {/if}
                                        </li>
                                    {/foreach}
                                {/foreach}
                            </ul>
                        </div>

                    </div>

                    <div class="navigation">
                        <a href="#" class="prev prev-navigation">&lsaquo;</a>
                        <a href="#" class="next next-navigation">&rsaquo;</a>

                        <div class="carousel carousel-navigation">
                            <ul>
                                {foreach $page->media as $mk=>$mv}
                                    {foreach $mv as $vv}
                                        <li>
                                            {if $vv[2]}
                                                <img src="{Page_Site_Global::displayMedia($vv[1],70,70,2)}" width="70" height="70"/>
                                            {else}
                                                <img src="{Page_Site_Global::displayMedia($vv[1],70,70,1)}" width="70" height="70"
                                                     title="{$info['attr']['城市']}{$info['product_name']}-{$info['attr']['基本信息>适合活动类型']}-{$vv[0]}"/>
                                            {/if}
                                        </li>
                                    {/foreach}
                                {/foreach}
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="head-middle">
            <p class="heading">{$page->info['set_name']}</p>

            <div class="price-area">
                <div class="price-area-left">
                    {if $page->info['detail']['市场价']}
                        <p>
                            市场价：<span>￥{$page->info['detail']['市场价']}
                                {if $page->info['detail']['计价单位']}
                                    /{$page->info['detail']['计价单位']}
                                {/if}
                    </span>
                        </p>
                    {/if}
                    <p>云SPACE特价：
                        <span1>
                            ¥ {$page->info['detail']['套餐价']}
                            {if $page->info['detail']['计价单位']}
                                /{$page->info['detail']['计价单位']}
                            {/if}
                        </span1>
                        {if $page->info['detail']['市场价']}
                            <span2>{intval($page->info['detail']['套餐价']/$page->info['detail']['市场价']*100)/10}
                                折
                            </span2>
                        {/if}
                    </p>
                </div>
                <div class="share">
                    {*<h6>*}
                    {*<a onclick="showBox('{$_assets}')" href="javascript:;"><span class="fa fa-share-alt"></span>&nbsp;分享</a>*}
                    {*</h6>*}
                    <h6>
                        <a data-url="{$_root}ajax_collect" class='collect' data-uid="{$smarty.session.user.id}" data-status
                           data-id="{$page->id}" data-type="set" href="javascript:;"><i
                                    class="glyphicon glyphicon-heart-empty"></i>&nbsp;<span>收藏</span></a>
                    </h6>

                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="essential">
                <table>
                    {if $page->info['attr_index']['标签']}
                        <tr>
                            <td>标签</td>
                            <td>
                               {foreach explode(',',$page->info['attr_index']['标签']) as $val}
                                    {$val}
                                {/foreach}
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td>特色标签：</td>
                        <td>
                            <span class="special_tab">派对</span>
                            <span class="special_tab">酒会</span>
                        </td>
                    </tr>
                    <tr>
                        <td width="70">城市：</td>
                        <td>
                            {$page->info['attr_index']['城市']}
                        </td>
                    </tr>
                    <tr>
                        <td>类别：</td>
                        <td>
                            {$page->info['category_name']}
                        </td>
                    </tr>
                    <tr>
                        <td>人数：</td>
                        <td>
                            {$page->info['attr_index']['人数']|default:'不限'}
                        </td>
                    </tr>
                    <tr>
                        <td>天数：</td>
                        <td>
                            {$page->info['attr_index']['天数']|default:'待定'}
                        </td>
                    </tr>
                    <tr>
                        <td>有效期：</td>
                        <td>
                            {if $page->info['attr_index']['开始时间']}
                                {$page->info['attr_index']['开始时间']}
                                至 {$page->info['attr_index']['结束时间']}
                            {else}
                                待定
                            {/if}
                        </td>
                    </tr>
                    {if $page->info['addr']}
                        <tr>
                            <td>地址：</td>
                            <td>
                                {$page->info['addr']}
                            </td>
                        </tr>
                    {/if}
                    <tr>
                        <td>版本：</td>
                        <td>
                            {foreach $page->otherVersion as $vk=>$vv}
                                <a href="{$_root}set_info/{$vv['id']}.html" class="{if $page->info['version']==$vv['version']}quality-btn {else}luxurious-btn{/if}">{$vv['version']}</a>
                            {/foreach}
                        </td>
                    </tr>
                </table>
                <div class="clearfix"></div>
            </div>
            <div class="bty-btn-group">
                {if $page->isBegin&&!$page->isEnd }
                    <a href="{$_root}product_set_booking?id={$page->id}" class="btn-buy"{$key}>
                        预定下单
                    </a>
                    {*<a href="{$_root}order_booking?id={$page->id}&booking_type=2" class="btn-buy"{$key}>*}
                    {*预定下单*}
                    {*</a>*}
                {elseif $page->isEnd}
                    <a href="javascript:;" class="btn-buy"{$key}>
                        已经结束
                    </a>
                {else}
                    <a href="javascript:;" class="btn-buy disabled"{$key}>
                        敬请期待
                    </a>
                {/if}
                <a data-toggle="modal" href="#openDemanAsk" ask_id="{$page->id}" ask_type="5" class="btn-consult demandAsk">预约咨询</a>

                <div class="clear"></div>
            </div>
        </div>
        <div class="head-right">
            <div class="supplier-brief">
                商户简介
            </div>
            <div class="supplier-logo">
                <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html">
                    {if $page->vendorInfo['logo']}
                        <input type="hidden" class="vendorCodeLogo"
                               src="{Page_Site_Global::displayLogo($page->vendorInfo['logo'],135,135)}">
                    {else}
                        <input type="hidden" class="vendorCodeLogo" src="{$_assets}img/logo_a.png">
                    {/if}
                    <img class="vendorlogo" src="{Page_Site_Global::displayLogo($page->vendorInfo['logo'],135,135)}">
                </a>
            </div>
            <div class="supplier-name">
                <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html">{$page->vendorInfo['vendor_name']}</a><br/>
                {if $page->vendorInfo['vendor_remarks']['签约状态']}
                    <span><img  src="img/product_set/supplier-title.jpg"/></span>
                {/if}

                <span1>
                    服务评分：{$page->vendorInfo['vendor_remarks']['内部评分']|default:'待定'}</span1>
                <span1>
                    服务区域：{$page->vendorInfo['attr']['城市']}</span1>
                <span1>
                    服务类型：{$page->vendorInfo['category_name']}</span1>
                <span1>
                    公司规模：{$page->vendorInfo['attr']['公司规模']}</span1>
                <span1>
                    活动标签：{$page->vendorInfo['attr']['活动类型']}</span1>
                <span1>
                    行业标签：{$page->vendorInfo['attr']['服务行业']}</span1>

            </div>
            <a href="{$_root}vendor_info/{$page->vendorInfo['id']}.html" class="supplier-btn1">进入商户</a>

        </div>
        <div class="clearfix"></div>
    </div>
    {*best-match*}
    {*<div class="best-match">*}
    {*<div class="best-match-title">最佳搭配</div>*}
    {*<div class="best-match-content">*}
    {*<ul>*}
    {*<li>*}
    {*<div><a href="#"><img src="img/product_set/match.jpg "/></a></div>*}
    {*<p><a href="#">奢居会发布会套餐</a></p>*}
    {*</li>*}
    {*<li>*}
    {*<div><a href="#"><img src="img/product_set/match1.jpg "/></a></div>*}
    {*<p><a href="#">Fingermoving发布会套餐</a></p>*}
    {*</li>*}
    {*<li>*}
    {*<div><a href="#"><img src="img/product_set/match2.jpg "/></a></div>*}
    {*<p><a href="#">海上电影沙龙套餐</a></p>*}
    {*</li>*}
    {*<li>*}
    {*<div><a href="#"><img src="img/product_set/match3.jpg "/></a></div>*}
    {*<p><a href="#">路演活动套餐</a></p>*}
    {*</li>*}
    {*</ul>*}
    {*</div>*}
    {*</div>*}
    {*content*}
    <div class="content_set">
        {*content-left*}
        <div class="content_set_left">
            {*content-set-guide*}
            <div id="introduction"></div>
            <div class="content_set_guide">
                <ul>
                    <li><a href="#" id="nav11" class="active">商品介绍</a>
                    </li>
                    <li><a href="#" id="nav21">服务日程</a></li>
                    <li><a href="#" id="nav31">活动案例</a></li>
                    <li><a href="#" id="nav41">预定须知</a></li>
                </ul>
            </div>

            {*introduction*}
            <div class="introduction">
                <div class="content_title">
                    <img src="img/product_set/introduction.jpg "/>
                </div>
                {if $page->info['des']}
                    <div class="des" style="padding: 0 0 30px 0; line-height: 1.8em">
                        {$page->info['des']}
                    </div>
                {/if}
                <ul>
                    <li>
                        <div class="introduction-left">
                            活动场地
                        </div>
                        <div class="introduction-right">
                            <a href="{$_root}service_info/{$page->space_info['id']}.html" class="package_product">
                                {$page->space_info['product_name']}
                            </a>
                        </div>
                        <div class="clearfix"></div>
                    </li>
                    {foreach $page->space_info['tags'] as $vk=>$vv}
                        <li>
                            <div class="introduction-left">
                                {$vk}
                            </div>
                            <div class="introduction-right">
                                {foreach $vv as $vvk=>$vvv}
                                    <div>
                                    <span>{$vvv['tags_name']}
                                        ：</span>
                                        {$page->space_info['attr_new'][$vvk]}
                                    </div>
                                {/foreach}
                            </div>
                            <div class="clearfix"></div>
                        </li>
                    {/foreach}

                    {if $page->space_info['des']}
                        <li>
                            <div class="introduction-left">
                                服务描述
                            </div>
                            <div class="introduction-right1">
                                {$page->space_info['des']}
                            </div>
                            <div class="clearfix"></div>
                        </li>
                    {/if}
                </ul>
            </div>
            <div id="schedule"></div>
            <div class="schedule">
                <div class="content_title">
                    <img src="img/product_set/schedule.jpg "/>
                </div>
                <ul class="s-list">
                    <li>
                        <div class="s-stroke">
                            <div class="s-fill"></div>
                        </div>
                        <p class="s-time">08:00 - 12:00</p>
                        <p class="s-des">培训会第一场，建议摆成不规则的分组桌型</p>
                        <img src="img/product_set/02.jpg" alt="">
                    </li>
                    <li>
                        <div class="s-stroke">
                            <div class="s-fill"></div>
                        </div>
                        <p class="s-time">08:00 - 12:00</p>
                        <p class="s-des">培训会第一场，建议摆成不规则的分组桌型</p>
                        <img src="img/product_set/02.jpg" alt="">
                    </li>
                    <li>
                        <div class="s-stroke">
                            <div class="s-fill"></div>
                        </div>
                        <p class="s-time">08:00 - 12:00</p>
                        <p class="s-des">培训会第一场，建议摆成不规则的分组桌型</p>
                        <img src="img/product_set/02.jpg" alt="">
                    </li>
                </ul>
            </div>
            {*service*}
            <div>
                <div class="set_service">
                    {$page->info['detail_des']}
                    {*<table cellspacing="0" cellpadding="0" interlaced="enabled">*}
                    {*<colgroup>*}
                    {*<col width="178" style="width: 237px;">*}
                    {*<col width="283" style="width: 377px;">*}
                    {*</colgroup>*}
                    {*<tbody>*}
                    {*<tr height="26" class="ue-table-interlace-color-single firstRow" style="height: 35px;">*}
                    {*<td height="35" colspan="2" style="word-break: break-all;"><strong>套餐信息（{$page->info['version']}）</strong></td>*}
                    {*</tr>*}
                    {*<tr height="26" class="ue-table-interlace-color-double" style="height: 35px;">*}
                    {*<td width="197" height="35" style="border-top-style: none;">套餐简介<br>&nbsp;</td>*}
                    {*<td width="852" style="border-top-style: none; border-left-style: none; word-break: break-all;">*}
                    {*{$page->info['des']}*}
                    {*</td>*}
                    {*</tr>*}
                    {*<tr height="26" class="ue-table-interlace-color-single" style="height: 35px;">*}
                    {*<td width="197" height="35" style="border-top-style: none;">服务清单</td>*}
                    {*<td width="852" style="border-top-style: none; border-left-style: none; word-break: break-all;">*}
                    {*{$page->info['detail']['清单']}*}
                    {*</td>*}
                    {*</tr>*}
                    {*<tr height="26" class="ue-table-interlace-color-double" style="height: 35px;">*}
                    {*<td width="197" height="35" style="border-top-style: none;">服务描述<br>&nbsp;</td>*}
                    {*<td width="852" style="border-top-style: none; border-left-style: none; word-break: break-all;">*}
                    {*{$page->info['detail_des']}</td>*}
                    {*</tr>*}

                    {*</tbody>*}
                    {*</table>*}
                </div>
            </div>
            {*case*}
            <div id="case"></div>
            <div class="case">
                <div class="content_title">
                    <img src="img/product_set/case.jpg "/>
                </div>
                <ul>
                    {if $page->eventInfo}
                        {foreach $page->eventInfo as $key =>$val}
                            <li>
                                <div class="case-left">
                                    <a href="{$_root}event_info/{$val['id']}.html">
                                        <img src="{Page_Site_Global::displayMedia($val['case_logo'],170,0,1)}">
                                    </a>
                                </div>
                                <div class="case-right">
                                    <p class="case-title">
                                        <a href="{$_root}event_info/{$val['id']}.html">{$val['case_name']}</a>
                                    </p>

                                    <p class="case-content">{$val['des']} </p>
                                </div>
                                <div class="clearfix"></div>
                            </li>
                        {/foreach}
                    {else}
                        <li>
                            该套餐暂无相关案例
                            <div class="clearfix"></div>
                        </li>
                    {/if}
                </ul>
            </div>
            {*notice*}
            <div id="notice"></div>
            <div class="notice">
                <div class="content_title">
                    <img src="img/product_set/notice.jpg "/>
                </div>
                {include "Web::inc/product_set_process.tpl" }
            </div>
        </div>
        {*content-right*}
        <div class="content_set_right">
            <div class="groom-title">
                同类推荐
            </div>
            <ul>
                {foreach $page->sameCategory as $ck=>$cv}
                    <li>
                        <div>
                            <a href="{$_root}set_info/{$cv['id']}.html">
                                {if $cv['logo']}
                                    <img src="{Page_Site_Global::displayMedia($cv['logo'],200,150,1)}" title="{$cv['set_name']}"/>
                                {else}
                                    <img src="img/product_set/supplier-logo.jpg" width="200" height="150" title="{$cv['set_name']}"/>
                                {/if}
                            </a>
                        </div>
                        <p>
                            <a href="{$_root}set_info/{$cv['id']}.html">{mb_substr(strip_tags($cv['set_name']),0,20,'utf-8')}</a>
                        </p>
                    </li>
                {/foreach}
            </ul>
        </div>
        <div class="clearfix"></div>
    </div>

</div>

{include file="inc/html_share.tpl"}
{include file="inc/html_demand_ask.tpl"}
<div style="margin-top:50px;" class="mt50"></div>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
</body>
</html>