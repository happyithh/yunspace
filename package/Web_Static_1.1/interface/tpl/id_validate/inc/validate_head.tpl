{static "v2.0/style_public.css"}
{static "v2.0/header.css"}
{static "id_validate/validate_head_foot.css"}
{static "v2.0/header.js"}
<div class="dayer1"></div>
<div class="top">
    <div class="top_center">
        <ul class="city_guide">

            {foreach $_REQUEST['cities'] as $val}
                <li><a href="{$_root}city/{$val}" {if $_COOKIE['city'] == $val} class="city_active"{/if}>{$val}</a>
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
            <li><a href="http://m.yunspace.com.cn">手机版</a></li>
            <li><a href="{$_root}vendor_join">商户加盟</a></li>
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