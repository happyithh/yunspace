{static "v2.0/header.css"}
{static "v2.0/header.js"}
<div class="dayer1"></div>
<div class="dayer_one"></div>
<div class="top">
    <div class="top_center">
        <ul class="city_guide">
            {foreach $_REQUEST['cities'] as $key => $val}
                <li><a href="{$_root}city/{$key}" {if $_COOKIE['city'] == $val} class="city_active"{/if}>{$val}</a>
                </li>
            {/foreach}
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
            <li><a href="{$_root}vendor_join">供应商加盟</a></li>
            {*<li><a href="{$_root}help">帮助中心</a></li>*}
        </ul>
        <ul class="member order_and_collect" style="display: none">
            <li><a href="/user_center/user_admin/order" class="myorder">我的订单</a></li>
            <li><a href="/user_center/user_admin/collection" class="mycollect">我的收藏</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>

<div class="header3">
    <div class="logo1">
        <a href="{$_root}"><img src="img/home.v2.0/logo.png" title="云·Space－活动场地专家"></a>
    </div>
    <div class="logo_m">
        <a href="{$_root}"><img src="img/home.v2.0/logo1.png"> </a>
    </div>
    <select class="top_select_city" onchange="changeCity(this)">
        {foreach $_REQUEST['cities'] as $v}
            <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
        {/foreach}
    </select>

    <div class="mobile_icon">
        <div class="mobile_search">
            <img src="img/home.v2.0/mobile_search_icon.png">
        </div>
        <div class="mobile_list">
            <img src="img/home.v2.0/list_icon.png">
        </div>
        <div class="clear"></div>
    </div>
    <div class="search">
        <form id="myform" action="{$_root}space?{$filter_string}" method="get">
            <div class="fleft">
                <select class="search-select1" name="mode" id="header-select" onchange="changeType(this)">
                    <option value="space"
                            {if Core::$urls['route']== 'space/' || $info&&$info['is_space']}selected {/if}>
                        空间场地
                    </option>
                    <option value="service"
                            {if Core::$urls['route']== 'service/' || $info&&!$info['is_space']}selected {/if}>
                        配套服务
                    </option>
                    <option value="set_list"
                            {if Core::$urls['route']== 'set_list/' || Core::$urls['route']== 'set_list/'}selected {/if}>
                        超值套餐
                    </option>
                </select>
            </div>
            <div class="fleft">
                <input type="text" class="search-input" placeholder="搜索供应商名称，地址，类型等" name="keyword">
                <ul class="search_dropdown">

                </ul>
            </div>
            <button class="search-button" type="submit">
                <img src="img/raiders_list/raiders_icon_block.gif">
            </button>
        </form>
    </div>
    <div class="clear"></div>
</div>

<div class="guide4_outside">
    <div class="guide4" id="top_nav">
        <ul class="guide4_left">
            <li><a href="{$_root}"{if !$nav_index} class="guide4_active"{/if}>{if !$nav_index}活动场地专家{else}首页{/if}</a>
            </li>
            <li><a href="{$_root}space/{$_COOKIE['city_key']}"{if $nav_index==1} class="guide4_active"{/if}>空间场地</a></li>
            <li><a href="{$_root}service/{$_COOKIE['city_key']}"{if $nav_index==2} class="guide4_active"{/if}>配套服务</a></li>
            <li class="set">
                <a href="{$_root}set_list/{$_COOKIE['city_key']}"{if $nav_index==3} class="guide4_active"{/if}>超值套餐</a>

                <div class="hot"><img src="img/home.v2.0/hot_icon.png"></div>
            </li>
            <li><a href="{$_root}raiders"{if $nav_index==4} class="guide4_active"{/if}>活动攻略</a></li>
            <li><a href="{$_root}vendor"{if $nav_index==5} class="guide4_active"{/if}>服务商户</a></li>
            {*<li><a href="{$_root}join"{if $nav_index==6} class="guide4_active"{/if}>供应商加盟</a></li>*}
        </ul>
        <div class="log-outside" yun-src="{$_root}ajax_ustat_v2">

        </div>
        <p class="hotline1">服务热线：<span>400-056-0599</span></p>
    </div>
</div>

<div class="guide_mobile_outside">
   <ul class="guide_mobile">

   </ul>


</div>

