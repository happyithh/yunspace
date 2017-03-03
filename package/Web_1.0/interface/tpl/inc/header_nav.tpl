<!--[if lt IE 8]>
<div class="ie7_error">还在用<strong>漏洞百出的IE7浏览器</strong>么？
    为了您的浏览体验，请升级<a href="http://windows.microsoft.com/zh-CN/internet-explorer/downloads/ie">Internet
        Explorer</a>浏览器，
    或使用其他的浏览器。
</div>
<![endif]-->
{static "v2.0/header.css"}
{static 'core/yunspace.js'}
{static "v2.0/header.js"}
{static "v2.0/headerOld.css"}

<script>
     $(document).ready(function(){
         $('.city-more').hover(function() {
             $('.dropDown').css('display','block');
                     $('#icon88').removeClass('d_icon');
                     $('#icon88').addClass('u_icon');
         },function(){
                     $('.dropDown').css('display','none');
                     $('#icon88').removeClass('u_icon');
                     $('#icon88').addClass('d_icon');
                 }
         );
         $('.dropDown').hover(function() {
             $(this).css('display','block');
                     $('#icon88').removeClass('d_icon');
                     $('#icon88').addClass('u_icon');

         },function() {
             $(this).css('display','none');
                     $('#icon88').removeClass('u_icon');
                     $('#icon88').addClass('d_icon');
           }
         );
     });
</script>
<div class="dayer1"></div>
<div class="dayer_one"></div>
<div class="top">
    <div class="top_center">
        <ul class="city_guide" style="overflow: visible">
            {foreach $_REQUEST['cities1'] as $k=>$val}
                <li><a href="{$_root}city/{$k}" {if $_COOKIE['city_key'] == $k} class="city_active"{/if}>{$val}</a>
                </li>
            {/foreach}
            <li style="position: relative" class="select-hover act">
                <a href="javascript:;" class="city-more  select5">
                    <div class="par4">更多</div>  <span id="icon88" class="d_icon" style="position: absolute;top:0px;right:5px;"></span>
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
            <li><a href="http://m.yunspace.com.cn">手机版</a></li>
            <li><a href="{$_root}vendor_join">供应商加盟</a></li>
            {*<li><a href="{$_root}help">帮助中心</a></li>*}
        </ul>
        <ul class="member order_and_collect" style="display: none">
            <li>
                <a href="/user_center/user_admin/order" class="myorder">我的订单</a>
            </li>
            <li>
                <a href="/user_center/user_admin/collection" class="mycollect">我的收藏</a>
            </li>
        </ul>
        <div class="clear"></div>
    </div>
</div>
<div class="header3">
    <div class="logo1">
        <a href="{$_root}"><img src="img/home.v2.0/logo.png" title="云·Space－商业空间短租平台"></a>
    </div>
    <div class="logo_m">
        <a href="{$_root}"><img src="img/home.v2.0/logo1.png">
        </a>
    </div>
    <script>
        function changeCity(o) {
            window.location = '{$_root}?df_city=' + $(o).val() + '&t=' + (new Date()).valueOf() + '&url_back=' + window.location.href;
        }
    </script>
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
                            {if $_REQUEST['mode']=='space' || Core::$urls['route']== 'space/'}selected {/if}>
                        空间场地
                    </option>
                    <option value="service"
                            {if $_REQUEST['mode']=='service' ||  Core::$urls['route']== 'service/'}selected {/if}>
                        配套服务
                    </option>
                    <option value="set_list"
                            {if $_REQUEST['mode']=='set_list' ||  Core::$urls['route']== 'set_list/'}selected {/if}>
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
            <li>
                <a href="{$_root}"{if !$nav_index} class="guide4_active"{/if}>{if !$nav_index}商业空间短租平台{else}首页{/if}</a>
            </li>
            <li>
                <a href="{$_root}space/{$_COOKIE['city_key']}"{if $nav_index==1} class="guide4_active"{/if}>空间场地</a>
            </li>
            <li>
                <a href="{$_root}service/{$_COOKIE['city_key']}"{if $nav_index==2} class="guide4_active"{/if}>配套服务</a>
            </li>
            <li class="set">
                <a href="{$_root}set_list/{$_COOKIE['city_key']}"{if $nav_index==5} class="guide4_active"{/if}>超值套餐</a>

                <div class="hot">
                  {*  <img src="img/home.v2.0/hot_icon.png">*}
                </div>
            </li>
            <li>
                <a href="{$_root}raiders"{if $nav_index==4} class="guide4_active"{/if}>活动攻略</a>
            </li>
            <li>
                <a href="{$_root}vendor"{if $nav_index==3} class="guide4_active"{/if}>服务商户</a>
            </li>
            {*<li><a href="{$_root}join"{if $nav_index==6} class="guide4_active"{/if}>供应商加盟</a></li>*}
        </ul>
        <div class="log-outside" yun-src="{$_root}ajax_ustat_v2">

        </div>
        <p class="hotline1">服务热线：<span>400-056-0599</span>
        </p>
    </div>
</div>


<div class="guide_mobile_outside">
    <ul class="guide_mobile">

    </ul>


</div>

<script>
    $(document).ready(function () {
        changeType($('#header-select'));
    });
    function searchSubmit(mode) {
        $('#top_search input[name=mode]').val(mode);
        $('#top_search').submit();
    }
    function changeType(t) {
        var mode = $(t).val();
        var url = "{$_root}" + mode + "?{$filter_string}";
        $('#myform').attr('action', url);
    }

</script>