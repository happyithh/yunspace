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
<div class="dayer2 none" id="dayer2" style="position: fixed"></div>
<div class="header-find-room hide">
    <div class="black-bg"></div>
    <div class="h-f-r-container">
        <div>
            <div class="h-f-r-c-logo">
                <img src="img/home.v2.0/logo2_new_0425.png" alt="">
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
                    <a href="{$_root}map">
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
        <div class="party-title hide">
            <span class="ion-ios-bell"></span>&nbsp提交活动需求后，30分钟内(工作日)获多个场地方直接报价，直接联系场地方
        </div>

    </div>
</div>

<div class="top">
    <div class="top_center">
        <ul class="city_guide" style="overflow: visible">
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
        <ul class="service" style=" overflow: visible">
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
            <li><a href="http://d15.yunspace.com.cn/feature/2015.9/join/index.html">代理商加盟</a></li>
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

<div class="header3-bg">
    <div class="header3">
        <div class="logo1">
            <a href="{$_root}"><img src="img/home.v2.0/logo_new_0425.png" title="云·Space－活动场地专家"></a>
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
        <div class="search-bg">
            <div class="search" style="margin-top: 10px;">
                <div class="find-room">

                        <input type="text" style="display:none">
                        <div class="f-p">
                            在
                        </div>
                        <div class="f-method f-method-select-1">
                            <div class="f-m-result result1 select-click select2" style="text-align: left">
                                <input type="text" class="select-input place-input area-input" value="" id="headerCustomPlace" style="background:#f9f9f9;border-radius: 3px;"/>
                                {*<span class="ion-arrow-down-b"  style="right:10px;"></span>*}
                                {*<div>地标/商圈/场地</div>&nbsp;*}
                            </div>
                            <div class="f-m-s-result1 hide"  data-drop="1" style="z-index:12000!important;">
                                {*<ul>*}
                                    {*<li>红坊</li>*}
                                    {*<li>徐家汇</li>*}
                                    {*<li>宜山路</li>*}
                                    {*<li>上七成</li>*}
                                    {*<li>宝山</li>*}
                                    {*<li>红坊</li>*}
                                    {*<li>徐家汇</li>*}
                                    {*<li>宜山路</li>*}
                                    {*<li>上七成</li>*}
                                    {*<li>宝山</li>*}
                                {*</ul>*}
                            </div>
                        </div>
                        <div class="f-p">
                            附近
                        </div>
                        <div class="f-method f-method-select-2 distance">
                            <div class="f-m-result result1 select-click  select2" style="text-align: left">
                                <div style="padding-left: 10%;font-size: 12px;" class="par3">1公里</div>&nbsp;<span class="ion-arrow-down-b" style="right:10px;"></span>
                            </div>
                            <input type="text" class="select-input hide far-input" value="1公里" id="headerCustomDistance"/>
                            <div class="f-m-s-result1 dropDown hide"  data-drop="1"  style="z-index:12000!important;">
                                <ul class="far">
                                    <li data-value="1">1公里</li>
                                    <li data-value="3">3公里</li>
                                    <li data-value="5">5公里</li>
                                    <li data-value="5">7公里</li>
                                    <li data-value="10">10公里</li>
                                </ul>
                            </div>
                        </div>
                        <div class="f-method f-method-button">
                            <button id="goToMap"><span class="ion-ios-search-strong" style="font-size: 16px;"></span>&nbsp;找场地</button>
                        </div>


                    {*<form id="myform" action="{$_root}space?{$filter_string}" method="get">*}
                        {*<div class="fleft">*}
                            {*<select class="search-select1" name="mode" id="header-select" onchange="changeType(this)">*}
                                {*<option value="space"*}
                                        {*{if Core::$urls['route']== 'space/' || $info&&$info['is_space']}selected {/if}>*}
                                    {*空间场地*}
                                {*</option>*}
                                {*<option value="service"*}
                                        {*{if Core::$urls['route']== 'service/' || $info&&!$info['is_space']}selected {/if}>*}
                                    {*配套服务*}
                                {*</option>*}
                                {*<option value="set_list"*}
                                        {*{if Core::$urls['route']== 'set_list/' || Core::$urls['route']== 'set_list/'}selected {/if}>*}
                                    {*超值套餐*}
                                {*</option>*}
                            {*</select>*}
                        {*</div>*}
                        {*<div class="fleft">*}
                            {*<input type="text" class="search-input" placeholder="搜索供应商名称，地址，类型等" name="keyword">*}
                            {*<ul class="search_dropdown">*}

                            {*</ul>*}
                        {*</div>*}
                        {*<button class="search-button" type="submit">*}
                            {*<img src="img/raiders_list/raiders_icon_block.gif">*}
                        {*</button>*}
                    {*</form>*}
                </div>
            </div>
            <div class="clear"></div>
        </div>
        <div class="clear"></div>
    </div>

<div class="guide4_outside">
    <div class="guide4" id="top_nav">
        <ul class="guide4_left">
            <li><a href="{$_root}"{if !$nav_index} class="guide4_active"{/if}>首页</a>
            </li>
            <li><a href="{$_root}space/{$_COOKIE['city_key']}"{if $nav_index==1} class="guide4_active"{/if}>空间场地</a></li>
            <li><a href="{$_root}service/{$_COOKIE['city_key']}"{if $nav_index==2} class="guide4_active"{/if}>配套服务</a></li>
            <li class="set">
                <a href="{$_root}set_list/{$_COOKIE['city_key']}"{if $nav_index==3} class="guide4_active"{/if}>超值套餐</a>

              {*  <div class="hot"><img src="img/home.v2.0/hot_icon.png"></div>*}
            </li>
            <li><a href="{$_root}raiders"{if $nav_index==4} class="guide4_active"{/if}>云·发现</a></li>
            <li><a href="{$_root}feature/jicai"{if $nav_index==5} class="guide4_active"{/if}>会员专区</a></li>
            <li><a href="{$_root}winchance"{if $nav_index==6} class="guide4_active"{/if}>文创项目</a></li>
        </ul>

        <div class="guide4_right-bg">
            {*<div class="log-outside" yun-src="{$_root}ajax_ustat_v2">*}

            </div>
            <p class="hotline1">服务热线：<span>400-056-0599</span></p>
        </div>
    </div>
</div>

{*<div class="cover-body hide"></div>*}


<div class="guide_mobile_outside">
   <ul class="guide_mobile">

   </ul>


</div>
{*<script>*}
    {*$("#demand_submit").submit(function () {*}
        {*var demand_city = $(".demand-city").find('option:selected').val();*}
        {*var contact_name = $(".demand-contact-name").val();*}
        {*var contact_phone = $(".demand-contact-phone").val();*}
        {*var content = $(".demand-content").val();*}
        {*YunSpace.api('demand/create.jsonp', {*}
            {*demand_city: demand_city,*}
            {*username: contact_name,*}
            {*phone: contact_phone,*}
            {*content: content,*}
            {*action: 'events'*}
        {*}, function (data) {*}
            {*alert(data.msg);*}
            {*if (data.status == 1) {*}
                {*window.location.reload();*}
            {*}*}
        {*});*}
        {*return false;*}
    {*})*}
{*</script>*}
</div>
<script>

    function getCookie(c_name)
    {
        var cookie = decodeURIComponent(document.cookie);
        if (cookie.length>0)
        {
            c_start=cookie.indexOf(c_name + "=");
            if (c_start!=-1)
            {
                c_start=c_start + c_name.length+1;
                c_end=cookie.indexOf(";",c_start);
                if (c_end==-1) c_end=cookie.length;
                return unescape(cookie.substring(c_start,c_end))
            }
        }
        return "";
    }

    function G(id) {
        return document.getElementById(id);
    }

    (function(){

        var city = getCookie("city") + '市中心';
        $('#headerCustomPlace').attr('placeholder',city);
        $('#goToMap').on('click',function(){
            var place =encodeURI(encodeURI($('#headerCustomPlace').val())) ;

            if(!place){
            }
            var distance =encodeURI(encodeURI($('#headerCustomDistance').val())) ;
            var href = 'http://'+location.host+'/map?distance='+distance+'&place='+place;
            location.href = href;

        });
        var ac2 = new BMap.Autocomplete(    //建立一个自动完成的对象
                { "input" : "headerCustomPlace"
                    ,"location" : "上海"
                });


    }());
    if(navigator.userAgent.indexOf('MSIE') >= 0){
        var trim_Version = version[1].replace(/[ ]/g, "");
        if(trim_Version == "MSIE7.0" || trim_Version == "MSIE8.0"){
            $('body').addClass('ie');
        }
    }
</script>
