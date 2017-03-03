{static "v2.0/home-fu.css"}
<!-[if lt IE 9]>
{static "home.v3.0/home-ie.css"}
<![endif]->
{static "v2.0/header.css"}
<link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
{static "core/yunspace.js"}
{static "v2.0/header.js"}
<!--引用百度地图API-->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>
<div class="dayer1"></div>
<div class="dayer_one"></div>
<div class="hearderMinNav">
    <div class="header-find-room hide">
        <div class="h-f-r-container">
            <div>
                <div class="h-f-r-c-logo">
                    <img src="img/home.v2.0/logo2.png" alt="">
                </div>
                <div class="h-f-r-c-search" style="width:63%">
                    <div class="c-s-con" style="width:78%">
                        <div class="c-s-c-p" style="width:20%">
                            我要办一场约
                        </div>
                        <div class="c-s-c-select2" style="width:18%">
                            <div class="c-s-c-s-con select-click select3"  style="padding-left:13%;box-sizing: border-box">
                                <input type="text" class="select-input person-input hide " value="50-100人"/>
                                <span class="ion-arrow-down-b"></span>
                                <div  class="par1">50-100人</div>
                            </div>
                            <div class="f-m-s-result1 dropDown hide per-in"  data-drop="1" style="top:35px;">
                                <ul style="margin-right: 10px;font-size: 15px;height:246px;">
                                    <li>50人以下</li>
                                    <li>50-100人</li>
                                    <li>100-300人</li>
                                    <li>300-500人</li>
                                    <li>500人以上</li>
                                </ul>
                            </div>
                        </div>
                        <div class="c-s-c-p">
                            的
                        </div>
                        <div class="c-s-c-select2 distance" style="width:27%">
                            <div class="c-s-c-s-con select-click select3" style="padding-left:13%;box-sizing: border-box"><div  class="par2">路演/展览/发布会</div><span class="ion-arrow-down-b"></span></div>
                            <input type="text" class="select-input hide act-in cate-input" value="路演/展览/发布会"/>
                            <div class="f-m-s-result1 dropDown hide" data-drop="1" style="top:35px;">
                                <ul style="margin-right: 10px;font-size: 15px;height:205px;">
                                    <li>派对/典礼/沙龙</li>
                                    <li>年会/年会/演出</li>
                                    <li>路演/展览/发布会</li>
                                    <li>会议/讲座</li>
                                    <li>团建/拓展</li>
                                </ul>
                            </div>
                        </div>
                        <div class="c-s-c-button" style="float:right">
                            <button type="button" style="background: #fe6a3a" class="f-room">提交</button>
                        </div>
                    </div>
                    <div class="c-s-button-activity " style="width:20%;">
                        <a href="{$_root}space">
                            <p style="color:#fff;background: none;border: 1px solid #fff;line-height: 32px;font-size:13px;"><span class="ion-ios-search-strong"  style="font-size: 13px"></span></span>&nbsp;找场地</p>
                        </a>
                        {*<div class="triangle-down hide"></div>*}
                    </div>
                </div>
                <div class="h-f-r-c-phone" style="width:15%">
                    服务热线：400-056-0599
                </div>
                <div class="clear" style="clear: both"></div>
            </div>
            <div class="party-title hide" style="margin-top: 10px;">
                <span class="ion-ios-bell"></span>&nbsp提交活动需求后，30分钟内(工作日)获多个场地方直接报价，直接联系场地方
            </div>

        </div>
    </div>

    <div class="top">

        <div class="top_center">

            <ul class="city_guide" style="overflow: visible">
                {*<li><a href="{$_root}"><img src="img/home.v2.0/logo1.png"> </a></li>*}
                {foreach $_REQUEST['cities1'] as $k=>$val}
                    <li><a href="{$_root}city/{$k}" {if $_COOKIE['city_key'] == $k} class="city_active"{/if}>{$val}</a>
                    </li>
                {/foreach}
                <li style="position: relative" class="select-hover">
                    <a href="javascript:;" class="city-more  select5">
                        <div class="par4">更多</div>  <span class="ion-chevron-down" style="position: absolute;top:0px;right:5px;"></span>
                    </a>
                    <input type="text" class="select-input hide city-input"/>
                    <div>
                        <ul class="city-select dropDown hide"  data-drop="1">
                            {foreach  $_REQUEST['cities2'] as $k=>$val}
                                <li><a href="{$_root}city/{$k}" >{$val}</a></li>
                            {/foreach}
                        </ul>
                    </div>
                </li>
            </ul>
            <ul class="service">
                {*<li class="weixin-title">*}
                {*<a href="#">微信服务号</a>*}

                {*<div class="weixin">*}
                {*<div class="close_icon">*}
                {*<img src="img/home.v2.0/close_icon.jpg">*}
                {*</div>*}
                {*<img src="img/home.v2.0/weixin.jpg">*}
                {*</div>*}
                {*</li>*}
                <li class="mobile_phone">
                    <a href="http://m.yunspace.com.cn" onclick="return false;">手机版</a>
                    <div class="mobile_phone_sao">
                        <p>扫一扫进入手机版</p>
                        <img src="img/home.v2.0/phone.jpg">
                    </div>
                </li>
                <li><a href="{$_root}vendor_join">商户加盟</a></li>
                {*<li><a href="">|</a></li>*}
                {*<li><a href="{$_root}user_center/login">登录</a></li>*}
                {*<li><a href="{$_root}user_center/register">免费注册</a></li>*}
                {*<li><a href="{$_root}help">帮助中心</a></li>*}
            </ul>
            <ul class="service order_and_collect" style="display: none">
                <li><a href="/user_center/user_admin/order">我的订单</a></li>
                <li><a href="/user_center/user_admin/collection" class="mycollect">我的收藏</a></li>
            </ul>
            <div class="clear"></div>
        </div>
    </div>

    <div class="guide4_outside hearderMinNext" id="hearderMinNext">
        <a href="{$_root}" class="home_logo"><img src="img/home.v2.0/logo2.png" alt=""></a>
        <div class="guide4" id="top_nav">
            <ul class="guide4_left">
                {*<li><a href="{$_root}"{if !$nav_index} class="guide4_active"{/if}>首页</a>*}
                {*</li>*}
                <li><a href="{$_root}space/{$_COOKIE['city_key']}"{if $nav_index==1} class="guide4_active"{/if}>空间场地</a></li>
                <li><a href="{$_root}service/{$_COOKIE['city_key']}"{if $nav_index==2} class="guide4_active"{/if}>配套服务</a></li>
                <li class="set">
                    <a href="{$_root}set_list/{$_COOKIE['city_key']}"{if $nav_index==3} class="guide4_active"{/if}>超值套餐</a>

                    {*  <div class="hot"><img src="img/home.v2.0/hot_icon.png"></div>*}
                </li>
                <li><a href="{$_root}raiders"{if $nav_index==4} class="guide4_active"{/if}>活动攻略</a></li>
                <li><a href="{$_root}feature/jicai"{if $nav_index==5} class="guide4_active"{/if}>会员专区</a></li>
            </ul>

            <div class="guide4_right-bg">
                <div class="log-outside" yun-src="{$_root}ajax_ustat_v2">

                </div>
                <p class="hotline1">服务热线：<span>400-056-0599</span></p>
            </div>
        </div>
    </div>
</div>

