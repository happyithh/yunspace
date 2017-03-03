<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_goto_mobile.tpl" url="m/"}
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "home.v2.0/homepage.css"}
    {static "home.v2.0/homepage.js"}
</head>
<body>
{include file="Web_Static::v2.0/html_header.tpl"}
{include file="Web_Static::home.v2.0/carousel.php.tpl"}
<div class="contain">
    {*首页icon*}
    <div class="icon">
        <img src="img/home.v2.0/icon2.jpg">

        <div class="search-primary">
            <select class="search-select search-city">
                {foreach $_REQUEST['cities'] as $v}
                    <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
                {/foreach}
            </select>
            <select class="search-select search-type" name="">
                <option value="">选择活动场地</option>
                {foreach $spaceCategory as $k =>$v}
                    <option value="{$k}">{$v}</option>
                {/foreach}
            </select>
            <select class="search-select search-size">
                <option value="">选择场地面积</option>
                {foreach $product_size as $key=>$val}
                    <option value="{$key}">{$val}</option>
                {/foreach}
            </select>
            <button class="search-btna">搜寻活动场地</button>
            <p class="says">您也可以</p>
            <a href="{$_root}set_list" class="search-btnB">浏览超值套餐&#10142;</a>
        </div>
    </div>
    {*首页3个广告区*}
    <div class="aoo">
        {if $goldPosition[0]['path']}
            <div class="aoo_list">
                <a href="{$goldPosition[0]['url']}"><img
                            src="{Page_Site_Global::displayMedia($goldPosition[0]['path'],286,478)}"
                            alt="{$goldPosition[0]['title']}"></a>
            </div>
        {else}
            <div class="aoo_list">
                <a href="/set_list/2"><img src="img/home.v2.0/aoo1.jpg" alt="云·space，活动场地专家"></a>
            </div>
        {/if}
        {if $goldPosition[1]['path']}
            <div class="aoo_list">
                <a href="{$goldPosition[1]['url']}"><img
                            src="{Page_Site_Global::displayMedia($goldPosition[1]['path'],286,478)}"
                            alt="{$goldPosition[1]['title']}"></a>
            </div>
        {else}
            <div class="aoo_list">
                <a href="/set_list/1"><img src="img/home.v2.0/aoo2.jpg" alt="云·space，活动场地专家"></a>
            </div>
        {/if}
        {if $goldPosition[2]['path']}
            <div class="aoo_list">
                <a href="{$goldPosition[2]['url']}"><img
                            src="{Page_Site_Global::displayMedia($goldPosition[2]['path'],286,478)}"
                            alt="{$goldPosition[2]['title']}"></a>
            </div>
        {else}
            <div class="aoo_list">
                <a href="/set_list/9"><img src="img/home.v2.0/aoo3.jpg" alt="云·space，活动场地专家"></a>
            </div>
        {/if}
        {*首页我要办活动表单提交*}

        <form action="{$_root}demand_submit" method="post" id="demand_submit">
            <div class="home-form2">
                <div class="form2-title">
                    我要办活动
                </div>
                {*<div class="form2-title-small">*}
                {*提供多套活动解决方案<br/>*}
                {*快速响应解答您的需求*}
                {*</div>*}
                <div class="form2-list">
                    <div class="form2-list-left">活动城市</div>
                    <select class="form2-list-select demand-city" name="data[活动城市]">
                        {foreach  $_REQUEST['cities'] as $v}
                            <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
                        {/foreach}
                    </select>

                    <div class="clear"></div>
                </div>
                <div class="form2-list">
                    <div class="form2-list-left">联系人</div>
                    <input class="form2-list-input demand-contact-name" placeholder="联系人" name="data[联系人]">

                    <div class="clear"></div>
                </div>
                <div class="form2-list">
                    <div class="form2-list-left" placeholder="联系电话">
                        联系电话
                    </div>
                    <input class="form2-list-input demand-contact-phone" name="data[联系电话]">

                    <div class="clear"></div>
                </div>
                <textarea class="form2-list-ta demand-content" rows="5" placeholder="具体要求" name="data[具体要求]"></textarea>
                <button class="form2-btn">立即提交</button>
                <div class="weixin-home">
                    <div class="weixin-pic">
                        <img src="img/home.v2.0/weixin3.jpg" alt="我要办活动">
                    </div>
                    <div class="weixin-word">
                        <div class="weixin-word1">
                            扫一扫微信服务号<br/>
                            随时随地获取方案
                        </div>
                        <div class="weixin-word2">
                            搜索：云space
                        </div>
                    </div>
                </div>
            </div>
        </form>
        <div class="clear"></div>
    </div>
</div>
{*特别推荐*}
<div class="floor">
    <div class="floor-title">
        <div class="floor-title-left"><span>特别推荐</span>&nbsp;&nbsp;•&nbsp;&nbsp;一键搞定一场活动
        </div>
        <div class="floor-title-right">
            {*<a href="#" class="more1"> 更多</a>*}
        </div>
        <div class="clear"></div>
    </div>
    <div class="floor-content">
        <div class="floor-content-left">
            <div class="floor-content-left1">
                <div class="floor1">
                    {if $recommend[5]['path']}
                        <a href="{$recommend[5]['url']}">
                            <img src="{Page_Site_Global::displayMedia($recommend[5]['path'],210,371)}"
                                 alt="{$recommend[5]['title']}"></a>
                    {else}
                        <a href="/set_list"><img src="img/home.v2.0/pic_01.jpg" alt="活动场地专家"></a>
                    {/if}
                </div>
                <div class="floor2">
                    <ul>
                        <li><a href="/set_list/2">发布会</a>&nbsp;<span>HOT!</span>
                        </li>
                        <li><a href="/set_list/8">亲子</a>
                        </li>
                        <li><a href="/set_list/9">团建</a>
                        </li>
                        <li><a href="/set_list/4">年会</a>
                        </li>
                        <li><a href="/set_list/1">派对酒会</a>
                        </li>
                        <li><a href="/set_list/6">会议</a>
                        </li>
                        <div class="clear"></div>
                    </ul>
                    <p class="more"><a href="/set_list">
                            查询更多</a></p>
                </div>
            </div>
            <div class="floor-content-left2">
                <div class="floor3">
                    {if $recommend[0]['path']}
                        <a href="{$recommend[0]['url']}"><img
                                    src="{Page_Site_Global::displayMedia($recommend[0]['path'],360,270)}"
                                    alt="{$recommend[0]['title']}"></a>
                    {else}
                        <a href="/space"><img src="img/home.v2.0/pic_02.jpg"></a>
                    {/if}
                </div>
                <div class="floor4">
                    {if $recommend[1]['path']}
                        <a href="{$recommend[1]['url']}"><img
                                    src="{Page_Site_Global::displayMedia($recommend[1]['path'],360,270)}"
                                    alt="{$recommend[1]['title']}"></a>
                    {else}
                        <a href="/spae"><img src="img/home.v2.0/pic_03.jpg"></a>
                    {/if}
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="floor-content-right">
            <div class="floor-content-right-inside clearfix">
                {if $recommend[2]['path']}
                    <div>
                        <p class="fl">
                            <a href="{$recommend[2]['url']}">
                                {$recommend[2]['content']}</a>
                        </p>
                        <a class="fr" href="{$recommend[2]['url']}"><img
                                    src="{Page_Site_Global::displayMedia($recommend[2]['path'],288,175)}"
                                    alt="{$recommend[2]['title']}"></a>
                    </div>
                {else}
                    <div>
                        <p class="fl"><a href="/space">
                                &nbsp;</a></p>
                        <a class="fr" href="/space"><img src="img/home.v2.0/pic_04.jpg"></a>
                    </div>
                {/if}
                {if $recommend[3]['path']}
                    <div>
                        <a class="fl" href="{$recommend[3]['url']}">
                            <img src="{Page_Site_Global::displayMedia($recommend[3]['path'],288,175)}"
                                 alt="{$recommend[3]['title']}"></a>

                        <p class="fr">
                            <a href="{$recommend[3]['url']}">{$recommend[3]['content']}</a>
                        </p>
                    </div>
                {else}
                    <div>
                        <a class="fl" href="/space"><img src="img/home.v2.0/pic_05.jpg"></a>

                        <p class="fr"><a href="/space">
                                &nbsp;</a></p>
                    </div>
                {/if}
                {if $recommend[4]['path']}
                    <div>
                        <p class="fl">
                            <a href="{$recommend[4]['url']}">{$recommend[4]['content']}</a>
                        </p>
                        <a class="fr" href="{$recommend[4]['url']}"><img
                                    src="{Page_Site_Global::displayMedia($recommend[4]['path'],288,175)}"
                                    alt="{$recommend[4]['title']}"></a>
                    </div>
                {else}
                    <div>
                        <p class="fl"><a href="#">&nbsp;</a>
                        </p>
                        <a class="fr" href="/space"><img src="img/home.v2.0/pic_06.jpg"></a>
                    </div>
                {/if}
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>
{*floor*}
<div class="floor_a">
    <div class="floor_a_title">
        <div class="floor_a_title_left">
            <span>1F</span>&nbsp;/&nbsp;超值套餐
        </div>
        <ul class="floor_a_pags">
            <li><a href="/set_list/2">发布会</a></li>
            <li><a href="/set_list/8">亲子</a></li>
            <li><a href="/set_list/7">沙龙</a></li>
            <li><a href="/set_list/4">年会</a></li>
            <li><a href="/set_list/1">派对酒会</a></li>
            <li><a href="/set_list/6">会议</a></li>
        </ul>
        <div class="floor_a_title_right">
            <a href="/set_list" class="more1"> 更多</a>
        </div>
    </div>
    <div class="clear"></div>
    <div class="floor_a_content">
        <ul>
            {foreach $hotSet as $k=>$val}
                {if $k <4}
                    <li class="set">
                        <div class="floor-img">
                            <a href="/set_info/{$val['id']}.html">
                                <img src="{Page_Site_Global::displayMedia($val['logo'],275,195)}"
                                     alt="{$imgAlt['热门套餐'][$k]}"></a>
                            {if $val['detail']['套餐价'] && $val['detail']['市场价']}
                                <div class="floor-pag">
                                    {intval($val['detail']['套餐价']/$val['detail']['市场价']*100)/10}
                                    折
                                </div>
                            {/if}
                        </div>
                        <div class="floor-p">
                            <a href="/set_info/{$val['id']}.html">{$val['set_name']}</a>
                        </div>
                        <div class="floor-description">
                            <a href="/set_info/{$val['id']}.html">{$val['addr']}</a>
                        </div>

                        <div class="floor-price">
                            {if $val['attr_index']['标签']}
                                <div class="special_tab">
                                    <span> {$val['attr_index']['标签']}</span>
                                </div>
                            {/if}
                            <div class="floor-price-left">
                                {if $val['set_price']>100}
                                    ￥{$val['set_price']}
                                {else}
                                    面议
                                {/if}
                            </div>
                            <div class="floor-price-right">
                                <span>{if $val['counter_view_index']>5}{$val['counter_view_index']}{else}5{/if}</span>&nbsp;人已浏览
                            </div>
                            <div class="clear"></div>
                        </div>
                    </li>
                {/if}
            {/foreach}
            <div class="clear"></div>
        </ul>
    </div>
</div>

<div class="floor_a">
    <div class="floor_a_title">
        <div class="floor_a_title_left">
            <span>2F</span>&nbsp;/&nbsp;空间场地
        </div>
        <ul class="floor_a_pags">
            <li><a href="/space/113">秀场展馆</a></li>
            <li><a href="/space/114">商业广场</a></li>
            <li><a href="/space/116">体育场馆</a></li>
            <li><a href="/space/118">餐厅酒吧</a></li>
            <li><a href="/space/119">高端会所</a></li>
            <li><a href="/space/121">会务中心</a></li>
        </ul>
        <div class="floor_a_title_right">
            <a href="/space" class="more1"> 更多</a>
        </div>
    </div>
    <div class="clear"></div>
    <div class="floor_a_content">
        <ul>
            {foreach $recommend_space as $k=>$v}
                {if $k<4}
                    <li>
                        <div class="floor-img">
                            <a href="/service_info/{$v['id']}.html">
                                <img
                                        src="{Page_Site_Global::displayMedia($v['logo'],275,195)}"
                                        alt="{$imgAlt['热门空间'][$k]}"></a>
                        </div>
                        <div class="floor-p">
                            <a href="/service_info/{$v['id']}.html"> {$v['product_name']}</a>
                        </div>
                        <div class="floor-description">
                            <a href="/service_info/{$v['id']}.html"
                               title="{$v['addr']}">{$v['addr']|default:$v['vendor_name']}</a>
                        </div>
                        <div class="floor-price">
                            <div class="floor-price-left">
                                {if $v['price'] >100}
                                    ￥{$v['price']}
                                {else}
                                    面议
                                {/if}
                            </div>
                            <div class="floor-price-right">
                                <span>{$v['order_counter_view']+18}</span>&nbsp;人已浏览
                            </div>
                            <div class="clear"></div>
                        </div>
                    </li>
                {/if}
            {/foreach}

            <div class="clear"></div>
        </ul>
    </div>
</div>

<div class="floor_a">
    <div class="floor_a_title">
        <div class="floor_a_title_left">
            <span>3F</span>&nbsp;/&nbsp;配套服务
        </div>
        <ul class="floor_a_pags">
            <li><a href="/service/2">硬体搭建</a></li>
            <li><a href="/service/9">设备租赁</a></li>
            <li><a href="/service/19">展台搭建</a></li>
            <li><a href="/service/20">舞台搭建</a></li>
            <li><a href="/service/23">户外搭建</a></li>
            <li><a href="/service/52">投影设备租赁</a></li>
        </ul>
        <div class="floor_a_title_right">
            <a href="/service" class="more1"> 更多</a>
        </div>
    </div>
    <div class="clear"></div>
    <div class="floor_a_content">
        <ul>
            {foreach $recommend_service as $k=>$v}
                {if $k <4}
                    <li>
                        <div class="floor-img">
                            <a href="/service_info/{$v['id']}.html">
                                <img
                                        src="{Page_Site_Global::displayMedia($v['logo'],275,195)}"
                                        alt="{$imgAlt['热门场地搭建'][$k]}"></a>

                        </div>
                        <div class="floor-p">
                            <a href="/service_info/{$v['id']}.html"> {$v['product_name']}</a>
                        </div>
                        <div class="floor-description">
                            <a href="/service_info/{$v['id']}.html" title="{$v['vendor_name']}">{$v['vendor_name']}</a>
                        </div>
                        <div class="floor-price">
                            <div class="floor-price-left">
                                {if $v['price'] >100}
                                    ￥ {$v['price']}
                                {else}
                                    面议
                                {/if}
                            </div>
                            <div class="floor-price-right">
                                <span>{$v['order_counter_view']+18}</span>&nbsp;人已浏览
                            </div>
                            <div class="clear"></div>
                        </div>
                    </li>
                {/if}
            {/foreach}
            <div class="clear"></div>
        </ul>
    </div>
</div>

<div class="floor_a">
    <div class="floor_a_title">
        <div class="floor_a_title_left">
            <span>4F</span>&nbsp;/&nbsp;多媒体制作
        </div>
        <ul class="floor_a_pags">
            <li><a href="/service/108">视频制作</a></li>
            <li><a href="/service/37">活动拍摄</a></li>
        </ul>
        <div class="floor_a_title_right">
            <a href="/service/146" class="more1"> 更多</a>
        </div>
    </div>
    <div class="clear"></div>
    <div class="floor_a_content">
        <ul>

            {foreach $media_service as $k=>$v}
                {if $k <4}
                    <li>
                        <div class="floor-img">
                            <a href="/service_info/{$v['id']}.html">
                                <img
                                        src="{Page_Site_Global::displayMedia($v['logo'],275,195)}"
                                        alt="{$imgAlt['多媒体制作'][$k]}"></a>
                        </div>
                        <div class="floor-p">
                            <a href="/service_info/{$v['id']}.html"> {$v['product_name']}</a>
                        </div>
                        <div class="floor-description">
                            <a href="/service_info/{$v['id']}.html" title="{$v['vendor_name']}">{$v['vendor_name']}</a>
                        </div>
                        <div class="floor-price">
                            <div class="floor-price-left">
                                {if $v['price'] >100}
                                    ￥ {$v['price']}
                                {else}
                                    面议
                                {/if}
                            </div>
                            <div class="floor-price-right">
                                <span>{$v['order_counter_view']+18}</span>&nbsp;人已浏览
                            </div>
                            <div class="clear"></div>
                        </div>
                    </li>
                {/if}
            {/foreach}
            <div class="clear"></div>
        </ul>
    </div>
</div>
{if !empty($xinqite_service)}
    <div class="floor_a">
        <div class="floor_a_title">
            <div class="floor_a_title_left">
                <span>5F</span>&nbsp;/&nbsp;新奇特
            </div>
            {*<ul class="floor_a_pags">*}
            {*<li><a href="/service/108">视频制作</a></li>*}
            {*<li><a href="/service/37">活动拍摄</a></li>*}
            {*</ul>*}
            <div class="floor_a_title_right">
                <a href="/service/146" class="more1"> 更多</a>
            </div>
        </div>
        <div class="clear"></div>
        <div class="floor_a_content">
            <ul>

                {foreach $xinqite_service as $k=>$v}
                    {if $k <4}
                        <li>
                            <div class="floor-img">
                                <a href="/service_info/{$v['id']}.html">
                                    <img
                                            src="{Page_Site_Global::displayMedia($v['logo'],275,195)}"
                                            alt="{$imgAlt['新奇特'][$k]}"></a>
                            </div>
                            <div class="floor-p">
                                <a href="/service_info/{$v['id']}.html"> {$v['product_name']}</a>
                            </div>
                            <div class="floor-description">
                                <a href="/service_info/{$v['id']}.html"
                                   title="{$v['vendor_name']}">{$v['vendor_name']}</a>
                            </div>
                            <div class="floor-price">
                                <div class="floor-price-left">
                                    {if $v['price'] >100}
                                        ￥ {$v['price']}
                                    {else}
                                        面议
                                    {/if}
                                </div>
                                <div class="floor-price-right">
                                    <span>{$v['order_counter_view']+18}</span>&nbsp;人已浏览
                                </div>
                                <div class="clear"></div>
                            </div>
                        </li>
                    {/if}
                {/foreach}
                <div class="clear"></div>
            </ul>
        </div>
    </div>
{/if}
{*首页横幅广告*}
<div class="banner">
    <a href="/vendor_join">
        <img src="img/home.v2.0/banner.jpg"></a>
</div>

{*首页名企合作区*}
<div class="brand">
    <div class="brand-title">
        部分合作品牌
    </div>
    <div class="brand-content">
        <img src="img/home.v2.0/newbrand.jpg">
    </div>
</div>
{*首页站内优化区*}
<div class="function">
    <div class="function-content">
        <div class="function-list">
            <div class="function-title">活动方案</div>
            <ul class="function-list-content">
                {foreach $strategy_1 as $key =>$val}
                    <li>
                        <a href="{$_root}raiders-info/{$val['id']}.html">{$val['title']}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <div class="function-list">
            <div class="function-title">经典案例</div>
            <ul class="function-list-content">
                {foreach $strategy_2 as $key =>$val}
                    <li>
                        <a href="{$_root}raiders-info/{$val['id']}.html">{$val['title']}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <div class="function-list">
            <div class="function-title">经验分享</div>
            <ul class="function-list-content">
                {foreach $strategy_3 as $key =>$val}
                    <li>
                        <a href="{$_root}raiders-info/{$val['id']}.html">{$val['title']}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
        <div class="function-list">
            <div class="function-title">精选专题</div>
            <ul class="function-list-content">
                {foreach $strategy_4 as $key =>$val}
                    <li>
                        <a href="{$_root}raiders-info/{$val['id']}.html">{$val['title']}</a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </div>
</div>
{*提示弹出框*}
<div class="hint" id="hint">
    <div class="hint-center">
        <div class="hit-img">
            <img src="img/home.v2.0/icon3.png">
        </div>
        <div class="hint-word">
            <p class="hint-word1">提交成功</p>

            <p class="hint-word2">工作人员将会在30分钟内与您电话联系</p>
        </div>
        <div class="clear"></div>
    </div>
    <div class="hint-close">
        <a href="#"> 关闭</a>
    </div>
</div>
<div class="dayer2" id="dayer2"></div>
<div class="link-outside">
    <div class="link">
        <p class="link-left">友情链接：</p>
        <ul class="link-right">
            <li><a href="http://jiudian.huangye88.com/" target="_blank">酒店电子商务信息平台 </a></li>
            <li><a href="http://www.xitieba.com/" target="_blank">微请柬 </a></li>
            <li><a href="http://www.31huiyi.com/" target="_blank">会议 </a></li>
            {*<li><a href="http://www.tuanyanwang.com" target="_blank">成都婚宴酒楼</a></li>*}
            <li><a href="http://www.91dyzx.com/" target="_blank">第一资讯</a></li>
            <li><a href="http://www.cdmxff.com/" target="_blank">成都展览搭建工厂</a></li>
            {*<li><a href="http://www.daocaofang.com.cn/" target="_blank">北京农家院</a></li>*}
            <li><a href="http://www.huizhanfuwu.net" target="_blank">北京会务公司</a></li>
            <li><a href="http://www.edoc2.com" target="_blank">文件管理系统</a></li>
            <li><a href="http://bsuc.cc/" target="_blank">今日头条</a></li>

        </ul>
        <div class="clear"></div>
    </div>
</div>
{include file="Web_Static::v2.0/html_footer.tpl"}
<script>
    $("#demand_submit").submit(function () {
        var demand_city = $(".demand-city").find('option:selected').val();
        var contact_name = $(".demand-contact-name").val();
        var contact_phone = $(".demand-contact-phone").val();
        var content = $(".demand-content").val();
        YunSpace.api('demand/create.jsonp', {
            demand_city: demand_city,
            username: contact_name,
            phone: contact_phone,
            content: content,
            action: 'events'
        }, function (data) {
            alert(data.msg);
            if (data.status == 1) {
                window.location.reload();
            }
        });
        return false;
    })
</script>
</body>
</html>