<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/"}
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "home.v3.0/data-picker.css"}
    {static "home.v3.0/homepage.js"}
    {static "home.v3.0/home.css"}
</head>
<body yun-src="/yun/plugins/">
{include file="Web_Static::v2.0/html_header3.1.tpl"}
{include file="Web_Static::home.v3.0/carousel3.0.tpl"}
<div class="contain">
<ul class="mao-all hide">
    <li><a href="#p1" class="mao">1F</a></li>
    <li><a href="#p2" class="mao">2F</a></li>
    <li><a href="#p3" class="mao">3F</a></li>
    <li><a href="#p4" class="mao">4F</a></li>
    <li><a href="#p5" class="mao">5F</a></li>
    <li><a href="#p6" class="mao">6F</a></li>
    <li><a href="#p7" class="mao">7F</a></li>
    <li><a href="/winchance" class="mao" style="line-height: 20px;" target="_blank">文创合作</a></li>
</ul>
<div class="tag">
    <ul>
        <li>
            <a href="#p1" class="tag-link">
                <div class="icon-tip">
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/A1.png" alt="">
                    </div>
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/B1.png" alt="">
                    </div>
                </div>
            </a>
        </li>
        <li>
            <a href="#p2" class="tag-link">
                <div class="icon-tip">
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/A2.png" alt="">
                    </div>
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/B2.png" alt="">
                    </div>
                </div>
            </a>
        </li>
        <li>
            <a href="#p3" class="tag-link">
                <div class="icon-tip">
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/A3.png" alt="">
                    </div>
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/B3.png" alt="">
                    </div>
                </div>
            </a>
        </li>
        <li>
            <a href="#p4" class="tag-link">
                <div class="icon-tip">
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/A4.png" alt="">
                    </div>
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/B4.png" alt="">
                    </div>
                </div>
            </a>
        </li>
        <li>
            <a href="#p5" class="tag-link">
                <div class="icon-tip">
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/A5.png" alt="">
                    </div>
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/B5.png" alt="">
                    </div>
                </div>
            </a>
        </li>
        <li>
            <a href="#p6" class="tag-link">
                <div class="icon-tip">
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/A6.png" alt="">
                    </div>
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/B6.png" alt="">
                    </div>
                </div>
            </a>
        </li>
        <li>
            <a href="#p7" class="tag-link">
                <div class="icon-tip">
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/A7.png" alt="">
                    </div>
                    <div class="t-l-icon">
                        <img src="img/home.v3.0/B7.png" alt="">
                    </div>
                </div>
            </a>
        </li>
    </ul>
</div>
<div class="home-ga">
    <div yun='pa/pa.js::add' yun-name="HomeA"></div>
</div>
<div class="recommend-product">
    <div id="p1" class="p-mao"></div>
    <div class="rec-header">
        <p class="rec-title">1F&nbsp;精心推荐 <span>&nbsp;一键搞定一场活动</span></p>
        <div class="rec-header-img">
            <img src="img/home.v3.0/line.jpg" alt="">
        </div>
    </div>
    {*{var_dump({$recommend[0]['url']})}*}
    <div class="rec-img-1">
        {if $recommend[0]['url']}
            <div class="rec-img-1-img relatives cover-t">
                <a href="{$recommend[0]['url']}">
                    <div class="cov"></div>
                    <div class="cov-title">{$recommend[0]['title']}</div>
                    <div class="cov-des">{$recommend[0]['content']}</div>
                </a>
                <div class="cov-btn">
                    <a href="{$recommend[0]['categoryUrl']}" >{$recommend[0]['category']}</a>
                </div>
                <img src="{$recommend[0]['path']}" alt="{$recommend[0]['title']}">
            </div>
        {else}
            <div class="rec-img-1-img relatives cover-t">
                <a href="http://www.yunspace.com.cn/raiders">
                    <div class="cov"></div>
                    <div class="cov-title">云·发现</div>
                    <div class="cov-des">每天发现城市新玩法</div>
                </a>
                <div class="cov-btn">
                    <a href="{$_root}raiders" >进入云·发现</a>
                </div>
                <img src="img/home.v3.0/01.jpg" alt="">
            </div>
        {/if}
        <ul class="rec-img-1-list relatives">
            <li><a href="/raiders/1">活动咨询</a></li>
            <li><a href="/raiders/23">活动攻略</a></li>
            <li><a href="/raiders/6">活动案例</a></li>
            <li><a href="/raiders/12">活动文库</a></li>
            <li><a href="/raiders/18">活动创意</a></li>
            <li><a href="/raiders/3">行业动态</a></li>
        </ul>
    </div>
    <div class="rec-img-2">
        {if $recommend[1]['url']}
            <div class="rec-img-2-1 relatives cover-t">
                <a href="{$recommend[1]['url']}">
                    <div class="cov"></div>
                    <div class="cov-title">{$recommend[1]['title']}</div>
                    <div class="cov-des">{$recommend[1]['content']}</div>
                </a>
                <div class="cov-btn">
                    <a href="{$recommend[1]['categoryUrl']}" >{$recommend[1]['category']}</a>
                </div>
                <img src="{$recommend[1]['path']}" alt="{$recommend[1]['title']}">
            </div>
        {else}
            <div class="rec-img-2-1 relatives cover-t">
                <a href="http://www.yunspace.com.cn/year">
                    <div class="cov"></div>
                    <div class="cov-title">年会</div>
                    <div class="cov-des">这些年会方式你知道吗</div>
                </a>
                <div class="cov-btn">
                    <a href="http://www.yunspace.com.cn/year" >进入云·创意</a>
                </div>
                <img src="img/home.v3.0/02151109.jpg" alt="年会">
            </div>
        {/if}
        {if $recommend[2]['url']}
            <div class="rec-img-2-2 relatives cover-t">
                <a href="{$recommend[2]['url']}">
                    <div class="cov"></div>
                    <div class="cov-title">{$recommend[2]['title']}</div>
                    <div class="cov-des">{$recommend[2]['content']}</div>
                </a>
                <div class="cov-btn">
                    <a href="{$recommend[2]['categoryUrl']}" >{$recommend[2]['category']}</a>
                </div>
                <img src="{$recommend[2]['path']}" alt="{$recommend[2]['title']}">
            </div>
        {else}
            <div class="rec-img-2-2 relatives cover-t">
                <a href="http://www.yunspace.com.cn/winchance">
                    <div class="cov"></div>
                    <div class="cov-title">文化创意</div>
                    <div class="cov-des">将文创项目与商业体态的完美结合</div>
                </a>
                <div class="cov-btn">
                    <a href="http://www.yunspace.com.cn/winchance" >进入云·项目</a>
                </div>
                <img src="img/home.v3.0/06151109.jpg" alt="文化创意">
            </div>
        {/if}
        {if $recommend[3]['url']}
            <div class="rec-img-2-3 relatives cover-t">
                <a href="{$recommend[3]['url']}">
                    <div class="cov"></div>
                    <div class="cov-title">{$recommend[3]['title']}</div>
                    <div class="cov-des">{$recommend[3]['content']}</div>
                </a>
                <div class="cov-btn">
                    <a href="{$recommend[3]['categoryUrl']}" >{$recommend[3]['category']}</a>
                </div>
                <img src="{$recommend[3]['path']}" alt="{$recommend[3]['title']}">
            </div>
        {else}
            <div class="rec-img-2-3 relatives cover-t">
                <a href="http://www.yunspace.com.cn/raiders-info/4696.html">
                    <div class="cov"></div>
                    <div class="cov-title">欢乐</div>
                    <div class="cov-des">韩国最牛喜剧陪你一起跨年</div>
                </a>
                <div class="cov-btn">
                    <a href="http://www.yunspace.com.cn/raiders-info/4696.html" >进入云·活动</a>
                </div>
                <img src="img/home.v3.0/04151109.jpg" alt="欢乐">
            </div>
        {/if}
    </div>
    <div class="rec-img-3">
        {if $recommend[4]['url']}
            <div class="rec-img-3-1 relatives cover-t">
                <a href="{$recommend[4]['url']}">
                    <div class="cov"></div>
                    <div class="cov-title">{$recommend[4]['title']}</div>
                    <div class="cov-des">{$recommend[4]['content']}</div>
                </a>
                <div class="cov-btn">
                    <a href="{$recommend[4]['categoryUrl']}" >{$recommend[4]['category']}</a>
                </div>
                <img src="{$recommend[4]['path']}" alt="{$recommend[4]['title']}">
            </div>
        {else}
            <div class="rec-img-3-1 relatives cover-t">
                <a href="http://www.yunspace.com.cn/raiders-info/4466.html">
                    <div class="cov"></div>
                    <div class="cov-title">露台</div>
                    <div class="cov-des">魔都的这些地方你不可错过</div>
                </a>
                <div class="cov-btn">
                    <a href="http://www.yunspace.com.cn/raiders-info/4466.html" >进入云·空间</a>
                </div>
                <img src="img/home.v3.0/03151109.jpg" alt="露台">
            </div>
        {/if}
        {if $recommend[5]['url']}
            <div class="rec-img-3-2 relatives cover-t">
                <a href="{$recommend[5]['url']}">
                    <div class="cov"></div>
                    <div class="cov-title">{$recommend[5]['title']}</div>
                    <div class="cov-des">{$recommend[5]['content']}</div>
                </a>
                <div class="cov-btn">
                    <a href="{$recommend[5]['categoryUrl']}" >{$recommend[5]['category']}</a>
                </div>
                <img src="{$recommend[5]['path']}" alt="{$recommend[5]['title']}">
            </div>
        {else}
            <div class="rec-img-3-2 relatives cover-t">
                <a href="http://www.yunspace.com.cn/baike/Art%5ESpace%E8%89%BA%E6%9C%AF%E7%A9%BA%E9%97%B4">
                    <div class="cov"></div>
                    <div class="cov-title">Art+Space</div>
                    <div class="cov-des">时尚创意商业文化的“海派”新天地</div>
                </a>
                <div class="cov-btn">
                    <a href="http://www.yunspace.com.cn/baike/Art%5ESpace%E8%89%BA%E6%9C%AF%E7%A9%BA%E9%97%B4" >进入云·空间</a>
                </div>
                <img src="img/home.v3.0/05151109.jpg" alt="Art+Space">
            </div>
        {/if}
    </div>
</div>
<div class="home-ga">
        <div yun='pa/pa.js::add' yun-name="HomeB"></div>
</div>
<div class="product-con">
    <div class="p-mao" id="p2"></div>
    <div class="product-con-header">
        <div class="p-c-h-title">
            <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#f3548e">2F&nbsp;</p>
            <div style="float:left;padding-top: 12px;font-size: 20px;">
                <img src="img/home.v3.0/t2.png" alt="">
            </div>
            <p>
                超值套餐
            </p>
        </div>
        <ul class="more-list">
            <li><a href="/set_list/{$_COOKIE['city_key']}-2">发布会</a></li>
            <li><a href="/set_list/{$_COOKIE['city_key']}-8">亲子</a></li>
            <li><a href="/set_list/{$_COOKIE['city_key']}-4">年会</a></li>
            <li><a href="/set_list/{$_COOKIE['city_key']}-1">派对酒会</a></li>
            <li><a href="/set_list/{$_COOKIE['city_key']}-6">会议沙龙</a></li>
            <li>
                <a href="/set_list/{$_COOKIE['city_key']}">
                    更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                </a>
            </li>
        </ul>
    </div>
    <ul class="pro-con-body">
        {foreach $hotSet as $k=>$val}
            {if $k <4}
                <li  {if $k==3}style="margin-right: 0px!important"{/if}>
                    <a href="/set_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayMedia($val['logo'],275,310)}" alt="{$val['set_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['set_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['marketing_title']}{mb_substr($val['marketing_title'],0,15,'utf-8')}{elseif $val['attr_index']['套餐特色']}{$val['attr_index']['套餐特色']}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {*{if $_COOKIE['look_price_phone']}*}
                                {if $val['set_price']>100}
                                    {$val['set_price']}&nbsp;&nbsp;元/{$val['detail']['计价单位']|default:'天'}
                                {else}
                                    <a href="/set_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {*{else}*}
                                {*<a href="/set_info/{$val['id']}.html">查看详情</a>*}
                            {*{/if}*}
                        </div>
                    </a>
                </li>
            {/if}
            {if $k>=4}
                <li  style="margin-top: 20px;">
                    <a href="/set_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayLogo($val['logo'],275,310)}" alt="{$val['set_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['set_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['marketing_title']}{mb_substr($val['marketing_title'],0,15,'utf-8')}{elseif $val['attr_index']['套餐特色']}{$val['attr_index']['套餐特色']}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                             {*{if $_COOKIE['look_price_phone']}*}
                                {if $val['set_price']>100}
                                    {$val['set_price']}&nbsp;&nbsp;元/{$val['detail']['计价单位']|default:'天'}
                                {else}
                                    <a href="/set_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {*{else}*}
                                {*<a href="/set_info/{$val['id']}.html">查看详情</a>*}
                            {*{/if}*}
                        </div>
                    </a>
                </li>
            {/if}
        {/foreach}
    </ul>
</div>
<div class="home-ga">
    <div yun='pa/pa.js::add' yun-name="HomeC"></div>
</div>
<div class="product-con">
    <div id="p3" class="p-mao"></div>
    <div class="product-con-header">
        <div class="p-c-h-title">
            <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#7dc346">3F&nbsp;</p>
            <div style="float:left;padding-top: 12px;">
                <img src="img/home.v3.0/t3.png" alt="">
            </div>
            <p style="color:#7dc346">
                秀场展馆
            </p>
        </div>
        <ul class="more-list">
            <li><a href="/space/{$_COOKIE['city_key']}-113-49-tags/商业发布#list_content">商业发布</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-113-49-tags/展览展示#list_content">展览展示</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-113-49-tags/新品发布会#list_content">新品发布会</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-113-49-tags/文体娱乐#list_content">文体娱乐</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-113-49-tags/演场演出#list_content">演场演出</a></li>
            <li>
                <a href="/space/{$_COOKIE['city_key']}-113">
                    更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                </a>
            </li>
        </ul>
    </div>
    {*{var_dump($show_exhibition_hall)}*}
    <ul class="pro-con-body">
        {foreach $show_exhibition_hall as $k=>$val}
            {if $k <4}
                <li {if $k==3}style="margin-right: 0px!important"{/if}>
                    <a href="/service_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayMedia($val['logo'],275,310)}" alt="{$val['product_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['product_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['attr_index']['特色标签']}{$val['attr_index']['特色标签']}{elseif $val['addr']}{mb_substr($val['addr'],0,15,'utf-8')}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {if $_COOKIE['look_price_phone']}
                                {if $val['price']>100}
                                    {$val['price']}&nbsp;&nbsp;{$val['attr_index']['计价单位']|default:'元/天'}
                                {else}
                                    <a href="/service_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {else}
                                <a href="/service_info/{$val['id']}.html">查看详情</a>
                            {/if}
                        </div>
                    </a>
                </li>
            {/if}
            {if $k >=4}
                <li style="margin-top: 20px;">
                    <a href="/service_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayLogo($val['logo'],275,310)}" alt="{$val['product_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['product_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['attr_index']['特色标签']}{$val['attr_index']['特色标签']}{elseif $val['addr']}{mb_substr($val['addr'],0,15,'utf-8')}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {if $_COOKIE['look_price_phone']}
                                {if $val['price']>100}
                                    {$val['price']}&nbsp;&nbsp;{$val['attr_index']['计价单位']|default:'元/天'}
                                {else}
                                    <a href="/service_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {else}
                                <a href="/service_info/{$val['id']}.html">查看详情</a>
                            {/if}
                        </div>
                    </a>
                </li>
            {/if}
        {/foreach}
    </ul>
</div>
{*{var_dump($advertising)}*}
<div class="home-ga">
    <div yun='pa/pa.js::add' yun-name="HomeD"></div>
</div>
<div class="product-con">
    <div id="p4" class="p-mao"></div>
    <div class="product-con-header">
        <div class="p-c-h-title">
            <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#feaf88">4F&nbsp;</p>
            <div style="float:left;padding-top: 12px;">
                <img src="img/home.v3.0/t4.png" alt="">
            </div>
            <p style="color:#feaf88">
                商业广场
            </p>
        </div>
        <ul class="more-list">
            <li><a href="/space/{$_COOKIE['city_key']}-114-49-tags/商业发布#list_content">商业发布</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-114-49-tags/展览展示#list_content">展览展示</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-114-49-tags/演场演出#list_content">演场演出</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-114-49-tags/推广路演#list_content">推广路演</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-114-49-tags/行业博览会#list_content">行业博览会</a></li>
            <li>
                <a href="/space/{$_COOKIE['city_key']}-114">
                    更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                </a>
            </li>
        </ul>
    </div>
    <ul class="pro-con-body">
        {foreach $commercial_plaza as $k=>$val}
            {if $k <4}
                <li  {if $k==3}style="margin-right: 0px!important"{/if}>
                    <a href="/service_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayMedia($val['logo'],275,310)}" alt="{$val['product_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['product_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['attr_index']['特色标签']}{$val['attr_index']['特色标签']}{elseif $val['addr']}{mb_substr($val['addr'],0,15,'utf-8')}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {if $_COOKIE['look_price_phone']}
                                {if $val['price']>100}
                                    {$val['price']}&nbsp;&nbsp;{$val['attr_index']['计价单位']|default:'元/天'}
                                {else}
                                    <a href="/service_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {else}
                                <a href="/service_info/{$val['id']}.html">查看详情</a>
                            {/if}
                        </div>
                    </a>
                </li>
            {/if}
            {if $k >=4}
                <li style="margin-top: 20px;">
                    <a href="/service_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayLogo($val['logo'],275,310)}" alt="{$val['product_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['product_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['attr_index']['特色标签']}{$val['attr_index']['特色标签']}{elseif $val['addr']}{mb_substr($val['addr'],0,15,'utf-8')}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {if $_COOKIE['look_price_phone']}
                                {if $val['price']>100}
                                    {$val['price']}&nbsp;&nbsp;{$val['attr_index']['计价单位']|default:'元/天'}
                                {else}
                                    <a href="/service_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {else}
                                <a href="/service_info/{$val['id']}.html">查看详情</a>
                            {/if}
                        </div>
                    </a>
                </li>
            {/if}
        {/foreach}
    </ul>
</div>
<div class="home-ga">
    <div yun='pa/pa.js::add' yun-name="HomeE"></div>
</div>
<div class="product-con">
    <div id="p5" class="p-mao"></div>
    <div class="product-con-header">
        <div class="p-c-h-title">
            <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#4fddaf">5F&nbsp;</p>
            <div style="float:left;padding-top: 12px;">
                <img src="img/home.v3.0/t5.png" alt="">
            </div>
            <p style="color:#4fddaf">
                高端会所
            </p>
        </div>
        <ul class="more-list">
            <li><a href="/space/{$_COOKIE['city_key']}-119-49-tags/主题派对#list_content">主题派对</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-119-49-tags/商业发布#list_content">商业发布</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-119-49-tags/宴会会议#list_content">宴会会议</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-119-49-tags/展览展示#list_content">展览展示</a></li>
            <li><a href="/space/{$_COOKIE['city_key']}-119-49-tags/文体娱乐#list_content">文体娱乐</a></li>
            <li>
                <a href="/space/{$_COOKIE['city_key']}-119">
                    更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                </a>
            </li>
        </ul>
    </div>
    <ul class="pro-con-body">
        {foreach $high_end_club as $k=>$val}
            {if $k <4}
                <li  {if $k==3}style="margin-right: 0px!important"{/if}>
                    <a href="/service_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayMedia($val['logo'],275,310)}" alt="{$val['product_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['product_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['attr_index']['特色标签']}{$val['attr_index']['特色标签']}{elseif $val['addr']}{mb_substr($val['addr'],0,15,'utf-8')}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {if $_COOKIE['look_price_phone']}
                                {if $val['price']>100}
                                    {$val['price']}&nbsp;&nbsp;{$val['attr_index']['计价单位']|default:'元/天'}
                                {else}
                                    <a href="/service_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {else}
                                <a href="/service_info/{$val['id']}.html">查看详情</a>
                            {/if}
                        </div>
                    </a>
                </li>
            {/if}
            {if $k >=4}
                <li style="margin-top: 20px;">
                    <a href="/service_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayLogo($val['logo'],275,310)}" alt="{$val['product_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['product_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['attr_index']['特色标签']}{$val['attr_index']['特色标签']}{elseif $val['addr']}{mb_substr($val['addr'],0,15,'utf-8')}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {if $_COOKIE['look_price_phone']}
                                {if $val['price']>100}
                                    {$val['price']}&nbsp;&nbsp;{$val['attr_index']['计价单位']|default:'元/天'}
                                {else}
                                    <a href="/service_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {else}
                                <a href="/service_info/{$val['id']}.html">查看详情</a>
                            {/if}
                        </div>
                    </a>
                </li>
            {/if}
        {/foreach}
    </ul>
</div>
<div class="home-ga">
    <div yun='pa/pa.js::add' yun-name="HomeF"></div>
</div>
<div class="product-con">
    <div id="p6" class="p-mao"></div>
    <div class="product-con-header">
        <div class="p-c-h-title">
            <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#fa3458">6F&nbsp;</p>
            <div style="float:left;padding-top: 12px;">
                <img src="img/home.v3.0/t6.png" alt="">
            </div>
            <p style="color:#fa3458">
                配套服务
            </p>
        </div>
        <ul class="more-list">
            <li><a href="/service/{$_COOKIE['city_key']}-2">硬体搭建</a></li>
            <li><a href="/service/{$_COOKIE['city_key']}-9">设备租赁</a></li>
            <li><a href="/service/{$_COOKIE['city_key']}-146">多媒体制作</a></li>
            <li><a href="/service/{$_COOKIE['city_key']}-7">演出人力</a></li>
            <li><a href="/service/{$_COOKIE['city_key']}-6">物料制作</a></li>
            <li>
                <a href="/service">
                    更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                </a>
            </li>
        </ul>
    </div>
    <ul class="pro-con-body">
        {foreach $recommend_service as $k=>$val}
            {if $k <4}
                <li  {if $k==3}style="margin-right: 0px!important"{/if}>
                    <a href="/service_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayMedia($val['logo'],275,310)}" alt="{$val['product_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['product_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['vendor_name']}{mb_substr($val['vendor_name'],0,15,'utf-8')}{elseif $val['attr_index']['特色标签']}{$val['attr_index']['特色标签']}{elseif $val['addr']}{mb_substr($val['addr'],0,15,'utf-8')}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {*{if $_COOKIE['look_price_phone']}*}
                                {if $val['price']>100}
                                    {$val['price']}&nbsp;&nbsp;{$val['attr_index']['计价单位']|default:'元/天'}
                                {else}
                                    <a href="/service_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {*{else}*}
                                {*<a href="/service_info/{$val['id']}.html">查看详情</a>*}
                            {*{/if}*}
                        </div>
                    </a>
                </li>
            {/if}
            {if $k >=4}
                <li style="margin-top: 20px;">
                    <a href="/service_info/{$val['id']}.html">
                        <img src="{Page_Site_Global::displayLogo($val['logo'],275,310)}" alt="{$val['product_name']}">
                        <div class="product-name-title">
                        </div>
                        <div class="p-name">
                            <p class="p-n-d-1">{mb_substr($val['product_name'],0,15,'utf-8')}</p>
                            <p class="p-n-d-2">{if $val['attr_index']['特色标签']}{$val['attr_index']['特色标签']}{elseif $val['addr']}{mb_substr($val['addr'],0,15,'utf-8')}{/if}</p>
                        </div>
                        <div class="p-n-d-3 hide">
                            {*{if $_COOKIE['look_price_phone']}*}
                                {if $val['price']>100}
                                    {$val['price']}&nbsp;&nbsp;{$val['attr_index']['计价单位']|default:'元/天'}
                                {else}
                                    <a href="/service_info/{$val['id']}.html">立即询价</a>
                                {/if}
                            {*{else}*}
                                {*<a href="/service_info/{$val['id']}.html">查看详情</a>*}
                            {*{/if}*}
                        </div>
                    </a>
                </li>
            {/if}
        {/foreach}
    </ul>
</div>
<div class="home-ga">
    <div yun='pa/pa.js::add' yun-name="HomeG"></div>
</div>
<div class="product-con">
    <div id="p7" class="p-mao"></div>
    <div class="product-con-header">
        <div class="p-c-h-title">
            <p style="line-height: 60px;font-size: 25px;margin-left: 0px;color:#78c4dc">7F&nbsp;</p>
            <div style="float:left;padding-top: 14px;">
                <img src="img/home.v3.0/t7.png" alt="">
            </div>
            <p style="color:#78c4dc">
                云·发现
            </p>
        </div>
        <ul class="more-list">
            <li><a href="/raiders/1">活动方案</a></li>
            <li><a href="/raiders/6">经典案例</a></li>
            <li><a href="/raiders/7">经验分享</a></li>
            <li><a href="/raiders/8">精选专题</a></li>
            <li><a href="/raiders/9">活动资讯</a></li>
            <li>
                <a href="">
                    更多 <span class="ion-ios-arrow-right"></span><span class="ion-ios-arrow-right"></span>
                </a>
            </li>
        </ul>
    </div>
    {*<div class="pro-con-body">*}
    <div  style="margin-top: 20px;">
        <div class="function-content">
            <div class="function-list">
                <div class="function-title">活动资讯</div>
                <ul class="function-list-content">
                    {foreach $strategy_1 as $key =>$val}
                        <li>
                            <a href="{$_root}article/{Func_NumEncode::e($val['id'])}.html">{$val['title']}</a>
                        </li>
                    {/foreach}
                </ul>
            </div>
            <div class="function-list">
                <div class="function-title">活动攻略</div>
                <ul class="function-list-content">
                    {foreach $strategy_2 as $key =>$val}
                        <li>
                            <a href="{$_root}article/{Func_NumEncode::e($val['id'])}.html">{$val['title']}</a>
                        </li>
                    {/foreach}
                </ul>
            </div>
            <div class="function-list">
                <div class="function-title">活动案例</div>
                <ul class="function-list-content">
                    {foreach $strategy_3 as $key =>$val}
                        <li>
                            <a href="{$_root}article/{Func_NumEncode::e($val['id'])}.html">{$val['title']}</a>
                        </li>
                    {/foreach}
                </ul>
            </div>
            <div class="function-list">
                <div class="function-title">活动文库</div>
                <ul class="function-list-content">
                    {foreach $strategy_4 as $key =>$val}
                        <li>
                            <a href="{$_root}article/{Func_NumEncode::e($val['id'])}.html">{$val['title']}</a>
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>
    </div>
    {*</div>*}
</div>

</div>
{*特别推荐*}




{*首页名企合作区*}
<div class="brand">
    <div class="brand-title">
        部分合作品牌
    </div>
    <div class="brand-content">
        <img src="img/home.v2.0/newbrand.jpg">
    </div>
</div>
<div class="link-outside">
    <div class="link">
        <p class="link-left">友情链接：</p>
        <ul class="link-right">
            <li><a href="http://jiudian.huangye88.com/" target="_blank">酒店电子商务信息平台 </a></li>
            {*<li><a href="http://www.tuanyanwang.com" target="_blank">成都婚宴酒楼</a></li>*}
            <li><a href="http://www.91dyzx.com/" target="_blank">第一资讯</a></li>
            <li><a href="http://www.huizhanfuwu.net" target="_blank">北京会务公司</a></li>
            <li><a href="http://www.bianzhihui.com/" target="_blank">编织汇</a></li>
            <li><a href="http://www.5988.com" target="_blank">创业商机网</a></li>
            <li><a href="http://www.chinapp.com/zhanhui" target="_blank">展会追踪</a></li>
            <li><a href="http://sh.52njl.com/" target="_blank">上海农家乐</a></li>
            {*<li><a href="http://www.enjoun.com" target="_blank">3d影院</a></li>*}
            <li><a href="http://www.57yx.com/" target="_blank">优游旅行网</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>