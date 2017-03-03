<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {static "home.v2.0/homepage.css"}
    {static "home.v2.0/homepage.js"}
</head>
<body yun-src="/yun/plugins/">
{include file="Web_Static::v2.0/html_header.tpl"}
{include file="Web_Static::home.v2.0/carousel.tpl"}

<div class="contain">

    {*首页icon*}
    <div class="icon">
        {*<img src="img/home.v2.0/img_01.jpg">*}
        {*<img src="img/home.v2.0/img_02.jpg">*}
        {*<img src="img/home.v2.0/img_03.jpg">*}
        {*<img src="img/home.v2.0/img_04.jpg">*}
        {*<div class="clear"></div>*}
        <img src="img/home.v2.0/icon.jpg">
        <div class="search-primary">
            <select class="search-select">
                <option>选择活动城市</option>
                <option>上海</option>
                <option>北京</option>
                <option>广州</option>
                <option>深圳</option>
                <option>成都</option>
                <option>杭州</option>
            </select>
            <select class="search-select">
                <option>选择活动类型</option>
                <option>上海</option>
                <option>北京</option>
                <option>广州</option>
                <option>深圳</option>
                <option>成都</option>
                <option>杭州</option>
            </select>
            <select class="search-select">
                <option>选择活动规模</option>
                <option>上海</option>
                <option>北京</option>
                <option>广州</option>
                <option>深圳</option>
                <option>成都</option>
                <option>杭州</option>
            </select>
            <button class="search-btna">搜寻活动场地</button>
            <p class="says">您也可以</p>
            <a href="{$_root}set_list" class="search-btnB">浏览超值套餐&#10142;</a>
        </div>
    </div>
    {*首页3个广告区*}
    <div class="ad">
        <div class="ad_list">
            <a href="#"><img src="img/home.v2.0/ad1.jpg"></a>
        </div>
        <div class="ad_list">
            <a href="#"><img src="img/home.v2.0/ad2.jpg"></a>
        </div>
        <div class="ad_list">
            <a href="#"><img src="img/home.v2.0/ad3.jpg"></a>
        </div>
        {*首页我要办活动表单提交*}
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
                <select class="form2-list-select">
                    <option>上海</option>
                    <option>北京</option>
                    <option>广州</option>
                    <option>深圳</option>
                    <option>成都</option>
                    <option>杭州</option>
                </select>

                <div class="clear"></div>
            </div>
            {*<div class="form2-list">*}
            {*<div class="form2-list-left">活动需求</div>*}
            {*<input class="form2-list-input">*}
            {*<div class="clear"></div>*}
            {*</div>*}
            <div class="form2-list">
                <div class="form2-list-left">联系人</div>
                <input class="form2-list-input">

                <div class="clear"></div>
            </div>
            <div class="form2-list">
                <div class="form2-list-left">联系电话</div>
                <input class="form2-list-input">

                <div class="clear"></div>
            </div>
            <textarea class="form2-list-ta" rows="5" placeholder="活动需求"></textarea>
            <button class="form2-btn">立即提交</button>
            {*<p class="line"></p>*}
            <div class="weixin-home">
                <div class="weixin-pic">
                    <img src="img/home.v2.0/weixin3.jpg">
                </div>

                <div class="weixin-word">
                    <div class="weixin-word1">
                        扫一扫微信服务号<br/>
                        随时随地获取方案
                    </div>
                    <div class="weixin-word2">搜索：云space</div>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</div>
{*特别推荐*}
<div class="floor">
    <div class="floor-title">
        <div class="floor-title-left"><span>特别推荐</span>&nbsp;&nbsp;•&nbsp;&nbsp;一键搞定一场活动</div>
        <div class="floor-title-right">
            {*<a href="#" class="more1"> 更多</a>*}
        </div>
        <div class="clear"></div>
    </div>
    <div class="floor-content">
        <div class="floor-content-left">
            <div class="floor-content-left1">
                <div class="floor1">
                    <a href="#"> <img src="img/home.v2.0/pic_01.jpg"></a>
                </div>
                <div class="floor2">
                    <ul>
                        <li><a href="#">发布会</a>&nbsp;<span>HOT!</span></li>
                        <li><a href="#">路演</a></li>
                        <li><a href="#">沙龙</a></li>
                        <li><a href="#">年会</a></li>
                        <li><a href="#">派对酒会</a></li>
                        <li><a href="#">会议培训</a></li>
                        <div class="clear"></div>
                    </ul>
                    <p class="more"><a href="#"> 查询更多</a></p>
                </div>
            </div>
            <div class="floor-content-left2">
                <div class="floor3">
                    <a href="#"><img src="img/home.v2.0/pic_02.jpg"></a>
                </div>
                <div class="floor4">
                    <a href="#"><img src="img/home.v2.0/pic_03.jpg"></a>
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="floor-content-right">
            <div class="floor-content-right-inside clearfix">
                <div>
                    <p class="fl"><a href="#">中央电视台世博大直播及个场馆专题片导演助理记录摄像英国皇家大马戏团 上海汽车嘉年华摄影师会精品展示摄影师万科馆 夏令营剪辑/科影师
                        馆后及场馆交接记录</a></p>
                    <a class="fr" href="#"><img src="img/home.v2.0/pic_04.jpg"></a>
                </div>
                <div>
                    <a class="fl" href="#"><img src="img/home.v2.0/pic_05.jpg"></a>
                    <p class="fr"><a href="#">中央电视台世博大直播及个场馆专题片导演助理记录摄像英国皇家大马戏团 上海汽车嘉年华摄影师会精品展示摄影师万科馆
                            夏令营剪辑/科影师 馆后及场馆交接记录 </a></p>
                </div>
                <div>
                    <p class="fl"><a href="#">中央电视台世博大直播及个场馆专题片导演助理记录摄像英国皇家大马戏团 上海汽车嘉年华摄影师会精品展示摄影师万科馆夏令营剪辑/科影师 馆后及场馆交接记录 </a></p>
                    <a class="fr" href="#"><img src="img/home.v2.0/pic_06.jpg"></a>
                </div>
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
            <li><a href="#">创意园区</a></li>
            <li><a href="#">码头</a></li>
            <li><a href="#">展览馆</a></li>
            <li><a href="#">试乘试驾</a></li>
            <li><a href="#">拓展训练中心</a></li>
            <li><a href="#">社会餐厅</a></li>
        </ul>
        <div class="floor_a_title_right">
            <a href="http://www.yunspace.com.cn/set_list" class="more1"> 更多</a>
        </div>
    </div>
    <div class="clear"></div>
    <div class="floor_a_content">
         <ul>
             <li>
                 <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>
                     <div class="floor-pag">
                          6折
                     </div>
                 </div>
                 <div class="floor-p">
                     <a href="#">50人起培训套餐50人起培训套餐50人起培训套餐50人起培训套餐50人起培训套餐50人起培训套餐50人起培训套餐50人起培训套餐</a>
                 </div>
                 <div class="floor-description">
                     <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                 </div>
                 <div class="floor-price">
                     <div class="floor-price-left">
                         ￥24000
                     </div>
                     <div class="floor-price-right">
                         <span>10</span>&nbsp;人已浏览
                     </div>
                     <div class="clear"></div>
                 </div>
             </li>
             <li>
                 <div class="floor-img">
                     <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>
                     <div class="floor-pag">
                         6折
                     </div>
                 </div>
                 <div class="floor-p">
                     <a href="#"> 50人起培训套餐</a>
                 </div>
                 <div class="floor-description">
                     <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                 </div>
                 <div class="floor-price">
                     <div class="floor-price-left">
                         ￥24000
                     </div>
                     <div class="floor-price-right">
                         <span>10</span>&nbsp;人已浏览
                     </div>
                     <div class="clear"></div>
                 </div>
             </li>
             <li>
                 <div class="floor-img">
                     <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>
                     <div class="floor-pag">
                         6折
                     </div>
                 </div>
                 <div class="floor-p">
                     <a href="#"> 50人起培训套餐</a>
                 </div>
                 <div class="floor-description">
                     <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                 </div>
                 <div class="floor-price">
                     <div class="floor-price-left">
                         ￥24000
                     </div>
                     <div class="floor-price-right">
                         <span>10</span>&nbsp;人已浏览
                     </div>
                     <div class="clear"></div>
                 </div>
             </li>
             <li>
                 <div class="floor-img">
                     <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>
                     <div class="floor-pag">
                         6折
                     </div>
                 </div>
                 <div class="floor-p">
                     <a href="#"> 50人起培训套餐</a>
                 </div>
                 <div class="floor-description">
                     <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                 </div>
                 <div class="floor-price">
                     <div class="floor-price-left">
                         ￥24000
                     </div>
                     <div class="floor-price-right">
                         <span>10</span>&nbsp;人已浏览
                     </div>
                     <div class="clear"></div>
                 </div>
             </li>
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
            <li><a href="#">创意园区</a></li>
            <li><a href="#">码头</a></li>
            <li><a href="#">展览馆</a></li>
            <li><a href="#">试乘试驾</a></li>
            <li><a href="#">拓展训练中心</a></li>
            <li><a href="#">社会餐厅</a></li>
        </ul>
        <div class="floor_a_title_right">
            <a href="http://www.yunspace.com.cn/space" class="more1"> 更多</a>
        </div>
    </div>
    <div class="clear"></div>
    <div class="floor_a_content">
        <ul>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
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
            <li><a href="#">创意园区</a></li>
            <li><a href="#">码头</a></li>
            <li><a href="#">展览馆</a></li>
            <li><a href="#">试乘试驾</a></li>
            <li><a href="#">拓展训练中心</a></li>
            <li><a href="#">社会餐厅</a></li>
        </ul>
        <div class="floor_a_title_right">
            <a href="http://www.yunspace.com.cn/service" class="more1"> 更多</a>
        </div>
    </div>
    <div class="clear"></div>
    <div class="floor_a_content">
        <ul>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
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
            <li><a href="#">创意园区</a></li>
            <li><a href="#">码头</a></li>
            <li><a href="#">展览馆</a></li>
            <li><a href="#">试乘试驾</a></li>
            <li><a href="#">拓展训练中心</a></li>
            <li><a href="#">社会餐厅</a></li>
        </ul>
        <div class="floor_a_title_right">
            {*<a href="http://www.yunspace.com.cn/service" class="more1"> 更多</a>*}
        </div>
    </div>
    <div class="clear"></div>
    <div class="floor_a_content">
        <ul>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <li>
                <div class="floor-img">
                    <a href="#"> <img src="img/home.v2.0/floor-img.jpg"></a>

                </div>
                <div class="floor-p">
                    <a href="#"> 50人起培训套餐</a>
                </div>
                <div class="floor-description">
                    <a href="#">区内最高档的五星级酒店，最新装修；含一天会场，一次茶饮，两次午饭。</a>
                </div>
                <div class="floor-price">
                    <div class="floor-price-left">
                        ￥24000
                    </div>
                    <div class="floor-price-right">
                        <span>10</span>&nbsp;人已浏览
                    </div>
                    <div class="clear"></div>
                </div>
            </li>
            <div class="clear"></div>
        </ul>
    </div>
</div>
</div>
{*首页横幅广告*}
<div class="banner">
    <a href="http://www.yunspace.com.cn/vendor_join"> <img src="img/home.v2.0/banner.jpg"></a>
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
                <li><a href="#">实我有时候还是挺怀念从前那种候还是挺</a></li>
                <li><a href="#">每张图的时钟显示那里用了纯黑色</a></li>
                <li><a href="#">破坏了整个画面的青春活力感</a></li>
                <li><a href="#">虽然没有现在这么高级，但是真的很可爱</a></li>
            </ul>
        </div>
        <div class="function-list">
            <div class="function-title">经典案例</div>
            <ul class="function-list-content">
                <li><a href="#">实我有时候还是挺怀念从前那种候还是挺</a></li>
                <li><a href="#">每张图的时钟显示那里用了纯黑色</a></li>
                <li><a href="#">破坏了整个画面的青春活力感</a></li>
                <li><a href="#">虽然没有现在这么高级，但是真的很可爱</a></li>
            </ul>
        </div>
        <div class="function-list">
            <div class="function-title">经验分享</div>
            <ul class="function-list-content">
                <li><a href="#">实我有时候还是挺怀念从前那种候还是挺</a></li>
                <li><a href="#">每张图的时钟显示那里用了纯黑色</a></li>
                <li><a href="#">破坏了整个画面的青春活力感</a></li>
                <li><a href="#">虽然没有现在这么高级，但是真的很可爱</a></li>
            </ul>
        </div>
        <div class="function-list">
            <div class="function-title">精选专题</div>
            <ul class="function-list-content">
                <li><a href="#">实我有时候还是挺怀念从前那种候还是挺</a></li>
                <li><a href="#">每张图的时钟显示那里用了纯黑色</a></li>
                <li><a href="#">破坏了整个画面的青春活力感</a></li>
                <li><a href="#">虽然没有现在这么高级，但是真的很可爱</a></li>
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
            <li><a href="http://www.jd.com/">京东商城</a></li>
            <li><a href="http://www.qq.com/">腾讯网</a></li>
            <li><a href="#">石油公司</a></li>
            <li><a href="#">中国石油化工国</a></li>
            <li><a href="#">埃克森美孚</a></li>
            <li><a href="#">英国石油</a></li>
            <li><a href="#">国家电网公司</a></li>
            <li><a href="#">英国石油</a></li>
            <li><a href="#">大众公司</a></li>
            <li><a href="#">非田汽车公司</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
{include file="Web_Static::v2.0/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>