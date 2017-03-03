<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/baike/{Func_Url::str_urlencode($page->info['space_name'])}"}
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "space_info/slide.css"}
    {static "space_info/space_info.css"}
    {*{static "js/bootstrap.min.js"}*}
    {static "space_info/space_info.js"}
    {static "space_info/space_inquiry.js"}
    {static "space_info/get_more.js"}
    {static "space_info/look_price.js"}
    {static "space_info/map.js"}
    {static "space_info/jquery.nav.js"}
    {static "space_info/jquery.easing.min.js"}
    {*{static "v2.0/Jquery.qrcode.js"}*}
    {*{static "v2.0/qrcode.js"}*}
    {*{static "space_info/jquery.easing.min.js"}*}
    {*<!--悬浮底部对齐-->*}
    {*{static "space_info/common.js"}*}
</head>
<!--引用百度地图API-->
<script>
    var productName,productId;
    productName = '{$page->info['space_name']}';
    productId = {$page->id};
    $(function(){
        $('#nav').onePageNav();
    });
</script>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}


<div class="site_location">
    <a href="javascript:;">场地百科</a><span>&gt;</span>
    <a href="javacript:;" class="baike_city">{$page->info['city']}</a><span>&gt;</span>
    <a href="javascript:;">{$page->info['space_name']}</a>
</div>
<div class="space-banner">
    {if $page->info['logo']}
    <div class="space-banner-img">
            <img src="{Page_Site_Global::displayMedia($page->info['logo'],"1920","")}">
    </div>
        <div class="banner-bg" style="opacity: 0.2"></div>
    {else}
        <div class="banner-bg"></div>
    {/if}
    <div class="banner-info">
        <div class="title">
            <p>{$page->info['seo_title']}</p>
            <h1 class="space_name">{$page->info['space_name']}</h1>
        </div>

        <div class="bottom">
            <p class="local_addr">{$page->info['city']}市&nbsp;&nbsp;{$page->info['addr']}</p>
            <p>{$page->info['special_tags']}</p>
        </div>
    </div>
</div>
<div class="container clearfix">
    <div class="space-content fl clearfix" id="test">
        <div class="space-dtl">
            <div class="title">
                <h2>{$page->info['space_name']}</h2>
                <p>{$page->info['seo_title']}</p>
            </div>
            <div class="cont clearfix">
                <div class="cont-tsadd fl">
                    <h5><span>场</span>地特色</h5>
                    <p>{$page->info['special_tags']}</p>
                </div>
                <div class="cont-tsadd fl">
                    <h5><span>详</span>细地址</h5>
                    <p>{$page->info['city']}&nbsp;&nbsp;{$page->info['addr']}</p>
                </div>
            </div>
        </div><!--space-dtl-end-->

        <!--目录-->
        <div class="space-list">
            <div class="tit">目录</div>
            <div id="nav1">
                <ul class="side-list side-list1 clearfix">
                    <li class="list1 lione" >
                        <a href="#key1">
                            <span></span>
                            <p>场地图片</p>
                        </a>
                        <span class="line"></span>
                    </li>

                    <li class="list2 lione">
                        <a href="#key2">
                            <span></span>
                            <p>基础信息</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list3 lione">
                        <a href="#key4">
                            <span></span>
                            <p>活动案例</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list4 lione">
                        <a href="#key5">
                            <span></span>
                            <p>场地位置</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list5 lione">
                        <a href="#key6">
                            <span></span>
                            <p>场地简介</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list6 lione">
                        <a href="#key7">
                            <span></span>
                            <p>附属空间</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!--场地图片-->
        <div class="comn" id="key1">
            <div class="comn-title clearfix">
                <i class="icon-img"></i><span>场地图片</span>
            </div>

            <div class="comn-space-img clearfix">
                <a href="javascript:;" class="load-img none">
                    <img data-src="" title="" data-number="" src="">
                </a>
                <a href="javascript:;" class="loading-img none" onclick="return false;"><div class="loading"></div></a>
                {foreach $spaceMedia['media_data'] as $k=>$v}
                    <a href="javascript:;">
                        {*{if isset($page->spaceItem[0]) && $page->spaceItem[0]['is_thc']}{Page_Site_Global::displayMedia($v['path'],850,545,1,'thc')}{else}{Page_Site_Global::displayMedia($v['path'],850,545,1)}{/if}*}
                        <img data-src="{if isset($page->spaceItem[0]) && $page->spaceItem[0]['is_thc']}{Page_Site_Global::displayMedia($v['path'],850,545,1,'thc')}{else}{Page_Site_Global::displayMedia($v['path'],850,545,1)}{/if}" title="{$page->info['space_name']}&nbsp;&nbsp;({$v['tags']})" data-number="{$k+1}" src="{if isset($page->spaceItem[0]) && $page->spaceItem[0]['is_thc']}{Page_Site_Global::displayMedia($v['path'],294,252,1,'thc')}{else}{Page_Site_Global::displayMedia($v['path'],294,252,1)}{/if}">
                    </a>
                {/foreach}
                {if count($spaceMedia['media_data'])%3 ==1}
                    <a href="javascript:;"><div class="loading"></div></a>
                    <a href="javascript:;"><div class="loading"></div></a>
                {elseif count($spaceMedia['media_data'])%3 ==2}
                    <a href="javascript:;"><div class="loading"></div></a>
                {/if}
            </div>
            <!--加载更多按钮-->
            {if count($page->spaceMedia)>9}
                <a href="javascript:;" class="load-more-btn" data-count-media="{count($page->spaceMedia)}" data-start-num="{$spaceMedia['start_num']}">
                    <span>加载更多</span>
                    <img src="img/space_info/icon-pull.png" width="13" height="13">
                </a>
            {/if}

        </div><!--comn-end-->
        <!--场地图片弹窗-->
        <div class="pop-img">
            <div class="close js-close"></div>
            <div class="title clearfix">
                <h3 class="img_title"></h3>
                <p><span class="img_number">1</span>/{count($page->spaceMedia)}</p>
            </div>
            <div class="img">
                <img src="img/space_info/space_img1.jpg">
            </div>
        </div>

        <!--基本信息-->
        <div class="comn" id="key2">
            <div class="comn-title clearfix">
                <i class="icon-msg"></i><span>基本信息</span>
            </div>

            <ul class="comn-space-msg space-ul clearfix">
                {foreach $page->tags  as $tk=>$tv}
                    {*{if $tk== 77 || $tk== 78 || $tk== 93}*}
                        <li  class="clearfix">
                            <div class="tit">{$tv['parent_name']}</div>
                            <div class="cont">
                                {foreach $tv as $ttk=>$ttv}
                                    {if $ttk != "parent_name"}
                                        <p>
                                            {$ttk}：{str_replace(',','、',$ttv)}
                                        </p>
                                    {/if}
                                {/foreach}
                            </div>
                            <div class="clearfix"></div>
                        </li>
                    {*{/if}*}
                {/foreach}
            </ul>
        </div>

        {*<!--场地规格-->*}
        {*<div class="comn" id="key3">*}
            {*<div class="comn-title clearfix">*}
                {*<i class="icon-specs"></i><span>场地规格</span>*}
            {*</div>*}

            {*<ul class="comn-space-specs space-ul clearfix">*}
                {*{foreach $page->tags  as $tk=>$tv}*}
                    {*{if $tk!= 77 && $tk!= 78 && $tk!= 93}*}
                        {*<li  class="clearfix">*}
                            {*<div class="tit">{$tv['parent_name']}</div>*}
                            {*<div class="cont">*}
                                {*{foreach $tv as $ttk=>$ttv}*}
                                    {*{if $ttk != "parent_name"}*}
                                        {*<p>*}
                                            {*{$ttk}：{str_replace(',','、',$ttv)}*}
                                        {*</p>*}
                                    {*{/if}*}
                                {*{/foreach}*}
                            {*</div>*}
                            {*<div class="clearfix"></div>*}
                        {*</li>*}
                    {*{/if}*}
                {*{/foreach}*}
            {*</ul>*}
        {*</div><!--comn-->*}

        <!--活动案例-->
        {if $page->caseList}
            <div class="comn" id="key4">
                <div class="comn-title clearfix">
                    <i class="icon-case"></i><span>活动案例</span>
                </div>

                <ul class="comn-space-case space-ul clearfix">
                    {foreach $page->caseList as $k=>$v}
                        {*{if $k < 6}*}
                            <li class="clearfix">
                                <a class="img" href="javascript:;">
                                    <img src="{Page_Site_Global::displayMedia($v['logo'],293,290,1)}">
                                </a>
                                <div class="mask-bg"></div>
                                <a target="_blank" href="http://{Core::$urls['host']}/raiders-info/{$v['id']}.html" class="text">
                                    <h5>{$v['title']}</h5>
                                    <p>{mb_substr(strip_tags($v['des']),0,40,'utf-8')}...</p>
                                </a>
                            </li>
                        {*{/if}*}
                    {/foreach}
                    {if count($page->caseList)%3 ==1}
                        <li class="clearfix"><div class="loading"></div></li>
                        <li class="clearfix"><div class="loading"></div></li>
                    {elseif count($page->caseList)%3 ==2}
                        <li class="clearfix"><div class="loading"></div></li>
                    {/if}

                </ul>
            </div><!--comn-->
        {/if}
        <div class="comn" id="key5">
            <div class="comn-title clearfix">
                <i class="icon-map"></i><span>场地位置</span>
            </div>

            <div class="comn-space-map space-ul">
                <!--百度地图容器-->
                <div id="map"></div>
            </div>
        </div><!--comn-->

        <!--产地简介-开始-->
        <div class="comn" id="key6">
            <div class="comn-title clearfix">
                <i class="icon-intro"></i><span>场地简介</span>
            </div>

            <div class="comn-space-intro space-ul clearfix">
                <p>{strip_tags($page->info['des'])}</p>
            </div>
        </div><!--comn-->

        <!--子空间-->
        {if $itemList}
        <div class="comn" id="key7">
            <div class="comn-title clearfix">
                <i class="icon-subspace"></i><span>附属空间</span>
            </div>
            <ul class="comn-space-subspace clearfix">
                {foreach $itemList as $k=>$v}
                    <li class="clearfix">
                            <a href="{$_root}service_info/{$v['product_id']}.html">
                                <h5><span>0{$k+1}</span><i>|</i>{$v['item_name']}</h5>
                            </a>
                            <p>面积： {$v['size']}m² </p>
                            <p>可容纳人数：
                                {if $v['min_people']==$v['max_people']}
                                    {if $v['min_people'] < 50}
                                        50人以下
                                    {else}
                                        {$v['min_people']}人
                                    {/if}
                                {else}
                                    {$v['min_people']} ~ {$v['max_people']}人
                                {/if}
                            </p>
                            <p>参考价：
                                {if $v['min_price']==$v['max_price'] && $v['min_price'] < 100}
                                    <span class="item_price">面议</span>
                                {elseif $_COOKIE['look_price_phone']}
                                    {if $v['min_price']==$v['max_price']}
                                        ¥<span>{$v['min_price']}</span>元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                    {else}
                                        ¥<span>{$v['min_price']} ~ {$v['max_price']}</span>元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                    {/if}
                                {else}
                                    <span class="js-look-price item_look_price" href="javascript:;">查看参考价</span>
                                    <span class="hide item_price_show">
                                        {if $v['min_price']==$v['max_price']}
                                            ¥<span>{$v['min_price']}</span>元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                        {else}
                                            ¥<span>{$v['min_price']} ~ {$v['max_price']}</span>元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}
                                        {/if}
                                    </span>
                                {/if}
                                {*{if $v['min_price']==$v['max_price']}*}
                                    {*{if $v['min_price'] < 100}*}
                                        {*<span>面议</span>*}
                                    {*{else}*}
                                        {*¥<span>{$v['min_price']}</span>元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}*}
                                    {*{/if}*}
                                {*{else}*}
                                    {*¥<span>{$v['min_price']} ~ {$v['max_price']}</span>元 / {if $v['price_unit']}{$v['price_unit']}{else}天{/if}*}
                                {*{/if}*}
                            </p>
                    </li>
                    {if ($k+1)%3==0}
                        <li class="line clearfix"></li>
                    {/if}
                {/foreach}
                {if count($itemList)%3 ==1}
                    <li class="clearfix"><div class="loading"></div></li>
                    <li class="clearfix"><div class="loading"></div></li>
                {elseif count($itemList)%3 ==2}
                    <li class="clearfix"><div class="loading"></div></li>
                {/if}
            </ul>
        </div><!--comn-->
        {/if}
        <!--询价流程-开始-->
        {*<div class="comn">*}
            {*<div class="comn-title clearfix">*}
                {*<i class="icon-process"></i><span>询价流程</span>*}
            {*</div>*}

            {*<div class="comn-space-process space-ul">*}
                {*<img src="img/space_info/process_img.jpg">*}
            {*</div>*}
        {*</div><!--comn-->*}
    </div><!--space-content-end-->
    <div class="wrap" style="width: 250px;float:right;">
        <div class="side-nav" >
            <a href="/inquiry" class="inquiry-order" id="inquiryOrder">
                <span class="circle1">15</span>
            </a>
            <div class="title">
                <h6>词条目录</h6>
                <p></p>
            </div>
            <div id="nav">
                <ul class="side-list clearfix">
                    <li class="list1 lione" >
                        <a href="#key1">
                            <span></span>
                            <p>图片</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list2 lione">
                        <a href="#key2">
                            <span></span>
                            <p>信息</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list3 lione">
                        <a href="#key4">
                            <span></span>
                            <p>案例</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list4 lione">
                        <a href="#key5">
                            <span></span>
                            <p>地图</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list5 lione">
                        <a href="#key6">
                            <span></span>
                            <p>简介</p>
                        </a>
                        <span class="line"></span>
                    </li>
                    <li class="list6 lione">
                        <a href="#key7">
                            <span></span>
                            <p>空间</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="space-right fr sidebar clearfix">
            <!--询价-->
            <div class="inquiry-comn clearfix">
                <div class="link-look">

                {if $page->averagePrice['min_price']==$page->averagePrice['max_price'] && $page->averagePrice['min_price'] < 100}
                    <div class="ref-price">
                        <p class="p3">场地平均租赁价格：<span>面议</span></p>
                    </div>
                {elseif $_COOKIE['look_price_phone']}
                    <div class="ref-price">
                        <p class="p1">参考价：
                            <strong>
                                {if $page->averagePrice['min_price']==$page->averagePrice['max_price']}
                                    {$page->averagePrice['min_price']}
                                {else}
                                    {$page->averagePrice['min_price']} ~ {$page->averagePrice['max_price']}
                                {/if}
                            </strong>
                            <span>
                                元 / {if $page->averagePrice['price_unit']}{$page->averagePrice['price_unit']}{else}天{/if}
                            </span>
                        </p>
                        <p class="p2">*参考价为该场地平均租赁价格</p>
                    </div>
                {else}
                    <a class="js-look-price" href="javascript:;">查看参考价</a>
                    <div class="ref-price hide">
                        <p class="p1">参考价：
                            <strong>
                                {if $page->averagePrice['min_price']==$page->averagePrice['max_price']}
                                    {$page->averagePrice['min_price']}
                                {else}
                                    {$page->averagePrice['min_price']} ~ {$page->averagePrice['max_price']}
                                {/if}
                            </strong>
                            <span>
                                元 / {if $page->averagePrice['price_unit']}{$page->averagePrice['price_unit']}{else}天{/if}
                            </span>
                        </p>
                        <p class="p2">*参考价为该场地平均租赁价格</p>
                    </div>
                {/if}
                    <p>感兴趣可以加入询价单，批量询价：</p>
                </div>

                <a class="inquiry-btn" href="#" id="addToOrder">+ 加入询价单</a>
                <div class="inquiry-step clearfix">
                    <span>批量提交</span>
                    <span>获得报价</span>
                    <span>直接联系</span>
                </div>
                <div class="inquiry-more">
                    <a class="more js-more" ask_name="{$page->spaceName}" ask_type="7" href="javascript:;"><span></span>了解更多</a>
                    {*<a class="order" href="mailto:815608528@qq.com"><span></span>编辑词条</a>*}
                    <a class="order" href="javascript:;" onclick='alert("您可以发送要编辑的信息到baike@yunspace.com.cn")'><span></span>编辑词条</a>
                </div>

                <!--官方公共平台二维码-->
                <div class="qr-code clearfix">
                    <div class="code-img fl">
                        <img src="img/space_info/qr_code.jpg">
                        <p>云·SPACE订阅号</p>
                    </div>
                    <div class="code-img fr">
                        <img src="" class="current_code" data-url="http://qr.topscan.com/api.php?el=l&w=200&m=10&text=http://{Core::$urls['host']}/baike/{Func_Url::str_urlencode($page->spaceName)}">
                        <p>当前二维码</p>
                    </div>
                </div>
            </div><!--inquiry-comn-end-->


            <!--广告-->
                <div yun='pa/pa.js::add' yun-name="Space PageA"></div>

            <!--ad广告-结束-->
        </div>
        <!--space-right-end-->
    </div>
</div><!--container-end-->
{include file="Web_Static::spacepedia/inc/pop_consult.tpl"}
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
<script type="text/javascript" src="http://developer.baidu.com/map/custom/stylelist.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
</body>
</html>