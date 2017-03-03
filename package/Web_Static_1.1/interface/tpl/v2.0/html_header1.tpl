{static "v2.0/header.css"}
{static "v2.0/header.js"}
<div class="dayer1"></div>
<div class="dayer_one"></div>

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
                            <input type="text" class="select-input person-input hide " value="50人"/>
                            <span class="ion-arrow-down-b"></span>
                            <div  class="par1">50人</div>
                        </div>
                        <div class="f-m-s-result1 dropDown hide per-in"  data-drop="1" style="top:35px;">
                            <ul style="margin-right: 10px;font-size: 15px;height:246px;">
                                <li>50人</li>
                                <li>100人</li>
                                <li>300人</li>
                                <li>500人</li>
                                <li>1000人</li>
                                <li>2000+人</li>
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
            <span class="ion-ios-bell"></span>&nbsp提交活动需求后，30分钟内获多个精准场地报价
        </div>

    </div>
</div>

<div class="top">
    <div class="top_center">
        <ul class="city_guide">
            {foreach $_REQUEST['cities'] as $val}
                <li><a href="{$_root}city/{$val}" {if $_COOKIE['city'] == $val} class="city_active"{/if}>{$val}</a>
                </li>
            {/foreach}
            <li style="position: relative" class="select-hover">
                <a href="javascript:;" class="city-more  select5">
                    <div class="par4">更多</div>  <span class="ion-chevron-down" style="position: absolute;top:0px;right:5px;"></span>
                </a>
                <input type="text" class="select-input hide city-input"/>
                <div>
                    <ul class="city-select dropDown hide"  data-drop="1">
                        <li><a href="javascript:;">北京</a></li>
                        <li><a href="javascript:;">上海</a></li>
                        <li><a href="javascript:;">天津</a></li>
                        <li><a href="javascript:;">重庆</a></li>
                        <li><a href="javascript:;">河北</a></li>
                        <li><a href="javascript:;">山西</a></li>
                        <li><a href="javascript:;">辽宁</a></li>
                        <li><a href="javascript:;">吉林</a></li>
                        <li><a href="javascript:;">黑龙江</a></li>
                        <li><a href="javascript:;">内蒙古</a></li>
                        <li><a href="javascript:;">北京</a></li>
                        <li><a href="javascript:;">上海</a></li>
                        <li><a href="javascript:;">天津</a></li>
                        <li><a href="javascript:;">重庆</a></li>
                        <li><a href="javascript:;">河北</a></li>
                        <li><a href="javascript:;">山西</a></li>
                        <li><a href="javascript:;">辽宁</a></li>
                        <li><a href="javascript:;">吉林</a></li>
                        <li><a href="javascript:;">黑龙江</a></li>
                        <li><a href="javascript:;">内蒙古</a></li>
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
            <li><a href="">|</a></li>
            <li><a href="{$_root}user_center/login">登录</a></li>
            <li><a href="{$_root}user_center/register">免费注册</a></li>
            {*<li><a href="{$_root}help">帮助中心</a></li>*}
        </ul>
        <ul class="member order_and_collect" style="display: none">
            <li><a href="/user_center/user_admin/order" class="myorder">我的订单</a></li>
            <li><a href="/user_center/user_admin/collection" class="mycollect">我的收藏</a></li>
        </ul>
        <div class="clear"></div>
    </div>
</div>

<div class="header3" style="margin-top:20px!important;margin-bottom:20px!important;">
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
    <div class="search" style="margin-top: 10px;">
        {*<div class="find-room">*}
            {*<input type="text" style="display:none">*}
            {*<div class="f-p">*}
                {*在*}
            {*</div>*}
            {*<div class="f-method f-method-select-1" style="width:31%">*}
                {*<div class="f-m-result result1 select-click select2" style="text-align: left">*}
                    {*<input type="text" class="select-input place-input area-input" placeholder="地标/商圈/场地"/>*}
                    {*<span class="ion-arrow-down-b"  style="right:10px;"></span>*}
                    {*<div>地标/商圈/场地</div>&nbsp;*}
                {*</div>*}
                {*<div class="f-m-s-result1 dropDown hide"  data-drop="1" style="z-index:12000!important;">*}
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
                {*</div>*}
            {*</div>*}
            {*<div class="f-p"  style="width:14%">*}
                {*附近*}
            {*</div>*}
            {*<div class="f-method f-method-select-2 distance">*}
                {*<div class="f-m-result result1 select-click  select2" style="text-align: left">*}
                    {*<div style="padding-left: 10%;font-size: 12px;" class="par3">2.0公里</div>&nbsp;<span class="ion-arrow-down-b" style="right:10px;"></span>*}
                {*</div>*}
                {*<input type="text" class="select-input hide far-input" value="2.0公里"/>*}
                {*<div class="f-m-s-result1 dropDown hide"  data-drop="1"  style="z-index:12000!important;">*}
                    {*<ul class="far">*}
                        {*<li>0.5公里</li>*}
                        {*<li>1.0公里</li>*}
                        {*<li>1.5公里</li>*}
                        {*<li>2.0公里</li>*}
                        {*<li>2.5公里</li>*}
                        {*<li>3.0公里以上</li>*}
                    {*</ul>*}
                {*</div>*}
            {*</div>*}
            {*<div class="f-method f-method-button">*}
                {*<button><span class="ion-ios-search-strong" style="font-size: 16px;"></span>&nbsp;找场地</button>*}
            {*</div>*}
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
    <div class="clear"></div>
</div>

<div class="guide4_outside">
    <div class="guide4" id="top_nav">
        <ul class="guide4_left">
            <li><a href="{$_root}"{if !$nav_index} class="guide4_active"{/if}>首页</a>
            </li>
            <li><a href="{$_root}space"{if $nav_index==1} class="guide4_active"{/if}>空间场地</a></li>
            <li><a href="{$_root}service"{if $nav_index==2} class="guide4_active"{/if}>配套服务</a></li>
            <li class="set">
                <a href="{$_root}set_list"{if $nav_index==3} class="guide4_active"{/if}>超值套餐</a>

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

<div class="cover-body hide"></div>



<div class="demand-body demand-one">
    <div class="demand-close"><span class="ion-close"></span></div>
    <div style="position: relative;height:100%">

        <div class="demand-submit">
            {*<form action=""  data-validate="true"  yun="form-validate/form-validate.js::formSubmit" yun-error=".d-s-error">*}
            <div class="ajax-form"  data-validate="true" style="height:450px">
                <div class="d-s-body">
                    <div class="d-s-form" style="position: absolute;top:0px;width:50%;left:25%">
                        <div class="d-s-title">
                            我要办活动
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="show-demand" style="margin-bottom: 70px;margin-top:50px;">

                        {*<div class="demand-full demand-first">*}
                        <div class="d-s-form" style="color:#999999;font-size:12px;margin:10px 0px;">
                            留下你的联系方式
                        </div>
                        <div class="d-s-form">
                            <div class="d-s-name"><i style="color:#ff0000">*</i>&nbsp;&nbsp;&nbsp;联系人</div>
                            <div class="d-s-input">
                                <input type="text" data-validate="true" data-error="请填写联系人"  yun="form-validate/form-validate.js::typeValidate@keyup" name="username" placeholder="请填写联系人"/>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d-s-form">
                            <div class="d-s-name"><i style="color:#ff0000">*</i>&nbsp;&nbsp;&nbsp;手机号码</div>
                            <div class="d-s-input">
                                <input type="text" yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11" placeholder="请填写11位的手机号码"
                                       name="phone"     yun-type="phone"  yun-error="" yun-style="fontSize:25px,position:absolute,right:5px,line-height:30px,color:#ff0000" data-validate="true"/>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <div class="d-s-form">
                            <div class="d-s-name"><i style="color:#ff0000"></i>人数</div>
                            <div class="d-s-input">
                                <input type="text" class="per-in hide select-input person-input" name="person_num" value="50人"/>
                                {*<input type="text" class="hide select-input place-input" data-validate="true" data-error="请将预算范围填写完整" name="pre_range"/>*}
                                <div class="d-s-input-val select-click select4"><div style="font-size:14px;"  class="par1">50人</div><span class="ion-arrow-down-b p-r-icon" style="color:#c5c5c5"></span></div>
                                <span class="down"></span>
                                <div class="drop-down-home dropDown pre-range hide" style="background:rgba(255,255,255,1);z-index:12000!important;border-color: #c4c4c4 ;border-top:none;margin-left:-1px;"  data-drop="1">
                                    <ul>
                                        <li>50人</li>
                                        <li>100人</li>
                                        <li>300人</li>
                                        <li>500人</li>
                                        <li>1000人</li>
                                        <li>2000+人</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                        <div class="d-s-form">
                            <div class="d-s-name"><i style="color:#ff0000"></i>活动类型</div>
                            <div class="d-s-input">
                                {*<input type="text" data-validate="true" data-error="请填写活动类型" class="act-out" name="activity_name"/>*}
                                <input type="text" class="act-in hide select-input  cate-input" name="activity_name" value="路演/展览/发布会"/>
                                <div class="d-s-input-val select-click select4" style="z-index:1"><div style="font-size:14px"  class="par2">路演/展览/发布会</div><span class="ion-arrow-down-b p-r-icon"  style="color:#c5c5c5"></span></div>
                                <span class="down"></span>
                                <div class="drop-down-home dropDown pre-range hide" style="background:rgba(255,255,255,1);z-index:12000;border-color: #c4c4c4 ;border-top:none;margin-left:-1px;height:204px;"  data-drop="1">
                                    <ul>
                                        <li>派对/典礼/沙龙</li>
                                        <li>晚会/年会/演出</li>
                                        <li>路演/展览/发布会</li>
                                        <li>会议/讲座</li>
                                        <li>团建/拓展</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>

                        <div class="d-s-form" style="margin-bottom: 10px;">
                            <div class="d-s-error">
                            </div>
                            <div class="clear"></div>
                        </div>
                        {*</div>*}
                    </div>

                    <div class="d-s-form bottom-submit" style="margin-top: 20px;position: absolute;bottom:0px;width:70%;left:50%;margin-left:-35%;">
                        <div class="d-s-button" style="width:100%">
                            <button yun="form-validate/form-validate.js::ajaxSubmit@click" yun-url="" yun-ajax="demand"
                                    yun-error=".d-s-error" yun-form=".ajax-form" data-id="0">提交</button>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                {*</form>*}
            </div>
        </div>
    </div>
</div>

<div class="demand-body demand-two" style="top:-130%;">
    <div class="demand-close"><span class="ion-close"></span></div>
    <div style="position: relative;height:100%">
        <div class="demand-submit">
            {*<form action=""  data-validate="true"  yun="form-validate/form-validate.js::formSubmit" yun-error=".d-s-error">*}
            <div class="ajax-form"  data-validate="true" style="height:450px;">
                <div class="d-s-body" style="height:330px;">
                    <div class="d-s-form" style="position: absolute;top:0px;width:50%;left:25%">
                        <div class="d-s-title" style="color:#06e1e1">
                            <span class="ion-ios-lightbulb-outline" style="font-size: 25px;"></span>&nbsp;&nbsp;提交成功
                        </div>

                        <div class="clear"></div>
                    </div>
                    <div class="d-s-form submit-text"  style="color:#999999;font-size:12px;margin:20px 0px;margin-top: 50px;">
                        请完善您的活动信息，云·SPACE场地报价系统将在 <span style="color:#59ebeb;font-size:13px;">30分钟内</span>为您提供多份精准场地报价
                    </div>
                    <div class="show-demand show2" style="margin-bottom: 70px;margin-top:20px;padding-top: 20px;border-top:1px dashed #ddd;height: 400px;">
                        <iframe src="" style="border: 0px; width:100%;height:100%" class="iframe" id="home-frame" name="home-frame">
                        </iframe>
                    </div>
                    <div class="d-s-form bottom-submit  bottom-submit2" style="margin-top: 20px;position: absolute;bottom:0px;width:100%;left:0px;">
                        <div class="d-s-button" style="width:100%;padding-left: 10%">
                            <button yun="form-validate/form-validate.js::ajaxSubmit@click" yun-url="" yun-ajax="demand_next" style="width:50%;float:left;margin-left:15%"
                                    class="demand-ok"
                                    yun-error=".d-s-error" yun-form=".ajax-form" data-id="2">确认</button>
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
                {*</form>*}
            </div>
        </div>
    </div>
</div>

<div class="guide_mobile_outside">
   <ul class="guide_mobile">

   </ul>


</div>

