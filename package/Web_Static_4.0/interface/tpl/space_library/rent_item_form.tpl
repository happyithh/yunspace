<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "get_space/form_space.css"}
    {static "v4.0/data-picker.css"}
</head>
<body yun="form_space.v4.0/form_space.js::init" data-name="{$item['space_name']}" data-item_id="{$item['item_id']}">
{*{include file="Web_Static::inc/header_rent_space.tpl"}*}
{include file="Web_Static::inc/header_1.tpl"}
<div yun="inc.v4.0/localData.js::pageController"></div>
<div class="form-container">
    <div class="form-header">
        {* <a href="{$_home}">首页</a>&nbsp;>&nbsp;<a href="{$_home}space_library">子空间</a>&nbsp;>&nbsp; *}
        <a href="javascript:;" class="page-active">预订空间</a>
    </div>
    <div class="form-body clearfix">
        <div class="form-body-left fl">
            <div class="form-left-header">
                <div class="form-left-title"><span>预订场地</span></div>
            </div>
            {if $item}
                <div class="space-details clearfix">
                    <div class="fl space-details-img">
                        {if $item['logo']}
                            <img src="{Page_Site_Global::displayMedia($item['logo'],123,102)}" alt="">
                        {else}
                            <img src="img/no_img.jpg">
                        {/if}
                    </div>
                    <div class="fl space-details-cont">
                        <h3 class="item_space_name">
                            <a href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($item['space_name'],1)}-{Func_NumEncode::e($item['item_id'])}" target="_blank">
                            {$item["item_space_name"]}
                        </a>
                        </h3>
                        <div class="marks">
                            {foreach $item['tags'] as $k=>$v}
                                <span>{$v}</span>
                            {/foreach} 
                        </div>
                        <div class="place">
                            {$item["city"]}市&nbsp;&nbsp;{$item["addr"]}
                        </div>
                    </div>
                    <div class="img-intent"><img src="img/space_library/img-intent.png" /></div>
                </div>
            {/if}
            <div class="form-body">
                <div class="form-input clearfix">
                    <div class="input-label fl"><i>*</i>&nbsp;&nbsp;你的称呼</div>
                    <div class="input-body fl">
                        <input type="text" placeholder="请留下你的称呼" class="error" id="username">
                    </div>
                    <div class="input-error fl">
                        方便我们与你联系
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="input-label fl"><i>*</i>&nbsp;&nbsp;手机号码</div>
                    {* <div class="input-body input-body-zkj fl"> *}
                    <div class="input-body fl input-body-zkj">
                        <input type="text" placeholder="请输入你的手机号码" id="phone_space" class="error">
                    </div>
                    <div class="input-yzm fl">
                        <button id="yzm_captcha" class="yzm">①滑块拼图验证</button>
                         <button class="yzm">验证码</button>
                        <input class="hide yzm-ipt" type="text">
                        <button class="yzm js-yzm" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-phone="#phone_space">②获取短信验证码</button>
                    </div>
                    <div id="captcha"></div>
                    <script src="http://static.geetest.com/static/tools/gt.js"></script>
                    <div class="input-error fl">
                        请输入11位有效的手机号码
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="input-label fl"><i>*</i>&nbsp;&nbsp;使用日期</div>
                    <div class="input-body fl input-date" id="input-date">
                        <input name="date_start" type="text" placeholder="开始日期" readonly style="width:33%;float: left" yun="product.v2.0/enquiry.js::dateSelect@click"
                               class="datePicker"  id="start_time" class="error">
                        <p>-</p>
                        <input name="date_end" type="text" placeholder="结束日期" readonly style="width:33%;float: left" yun="product.v2.0/enquiry.js::dateSelect@click"
                               class="datePicker"  id="end_time" class="error">
                    </div>
                    <div class="input-error fl">
                        请选择使用日期
                    </div>
                    <div class="date-select none" id="date-select">
                        <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"
                             yun-with-input="false" yun-autohidenode="#date-select" yun-autohide="true"></div>
                    </div>
                </div>
                <input type="text" hidden id="demand_city" value="{$item['city']}">
                <div class="form-input clearfix">
                    {if $people && is_numeric($people)}
                        <div class="input-label fl">活动人数</div>
                        <div class="input-body fl">
                            <input type="text" id="act_persons" value="{$people}人">
                        </div>
                    {else}
                        <div class="input-label fl line-every">活动人数</div>
                        <input type="text" hidden id="act_persons" value="{$people}">
                        <div class="form-select fl">
                            <ul class="form-select-list">
                                <li><a href="javascript:;" {if $people=="1-49人"} class="select-active1"{/if}>1-49人</a></li>
                                <li><a href="javascript:;" {if $people=="50-99人"} class="select-active1"{/if}>50-99人</a></li>
                                <li><a href="javascript:;" {if $people=="100-299人"} class="select-active1"{/if}>100-299人</a></li>
                                <li><a href="javascript:;" {if $people=="300-499人"} class="select-active1"{/if}>300-499人</a></li>
                                <li><a href="javascript:;" {if $people=="500人以上"} class="select-active1"{/if}>500人以上</a></li>
                            </ul>
                        </div>
                    {/if}

                </div>
                <div class="form-input clearfix">
                    <div class="input-label fl line-every">活动类型</div>
                    <input type="text" hidden id="act_cate" value="{$activity}">
                    <div class="form-select fl">
                        <ul class="form-select-list">
                            <li><a href="javascript:;" {if $activity=="展览/发布会/品鉴会"} class="select-active1"{/if}>展览/发布会/品鉴会</a></li>
                            <li><a href="javascript:;" {if $activity=="路演/地推"} class="select-active1"{/if}>路演/地推</a></li>
                            <li><a href="javascript:;" {if $activity=="生日聚会/主题派对"} class="select-active1"{/if}>生日聚会/主题派对</a></li>
                            <li><a href="javascript:;" {if $activity=="晚会/演出/典礼"} class="select-active1"{/if}>晚会/演出/典礼座</a></li>
                            <li><a href="javascript:;" {if $activity=="会议/讲座/沙龙"} class="select-active1"{/if}>会议/讲座/沙龙</a></li>
                            <li><a href="javascript:;" {if $activity=="团建/拓展"} class="select-active1"{/if}>团建/拓展</a></li>
                            <li><a href="javascript:;" {if $activity=="快闪店/SHOWROOM"} class="select-active1"{/if}>快闪店/SHOWROOM</a></li>
                        </ul>
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="input-label fl line-every">其他要求</div>
                    <input type="text" hidden id="act_other">
                    <div class="form-select fl">
                        <ul class="form-select-list" data-many="true">
                            <li><a href="javascript:;" class="select-active2">搭建</a></li>
                            <li><a href="javascript:;">舞台</a></li>
                            <li><a href="javascript:;">用餐</a></li>
                            <li><a href="javascript:;">报批</a></li>
                            <li><a href="javascript:;">媒体设备</a></li>
                            <li><a href="javascript:;">演员</a></li>
                            <li><a href="javascript:;">背景板</a></li>
                            <li><a href="javascript:;">桁架</a></li>
                            <li><a href="javascript:;">VIP休息室</a></li>
                            <li><a href="javascript:;">座椅</a></li>
                            <li><a href="javascript:;">发电车</a></li>
                            <li><a href="javascript:;">安保</a></li>
                            <li><a href="javascript:;">保洁</a></li>
                            <li><a href="javascript:;">摇臂</a></li>
                            <li><a href="javascript:;">游机</a></li>
                            <li><a href="javascript:;">摄影师</a></li>
                            <li><a href="javascript:;">摄像师</a></li>
                            <li class="select-disabled">(可多选)</li>
                        </ul>
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="input-label fl line-every" style="margin-top: 10px;">补充要求</div>
                    <div class="form-textarea fl">
                        <textarea name="" cols="30" rows="3" placeholder="请详细填写具体要求，方便系统及时快速适配！"></textarea>
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="form-btn">
                        <button id="item-submit">提交</button>
                    </div>
                    <div class="other-req clearfix">
                        <input type="checkbox" checked>
                        <p>还需要其他的供应商服务</p>
                    </div>
                </div>
                {*<div class="form-input clearfix">*}
                {*<div class="form-checkbox">*}
                {*<label for="vendor">*}
                {*<input type="checkbox" id="vendor" class="checkbox">*}
                {*还需要其他供应商服务*}
                {*</label>*}
                {*</div>*}
                {*</div>*}
            </div>
            <div class="form-footer">
                <div class="form-body-left-bottom clearfix">
                    <div class="form-footer-body clearfix">
                        <p class="yun-code fl">
                            <img src="img/weixin2.jpg">
                        </p>
                        <p class="yun-code-p fl">
                            <span class="yun-code-p1">举起手机，扫一扫关注</span><br/>
                            <span class="yun-code-p2">云·space微信公众号<br/>随时随地获取方案</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="form-body-right fr">
            <div class="form-right-body">
                <div class="form-right-header">服务流程</div>
                <ul class="form-right-list">
                    <li class="icon-one">快速提交场地需求</li>
                    <li class="icon-two">30分钟获得场地报价</li>
                    <li class="icon-three">顾问带您实地看场</li>
                    <li class="icon-four">确定场地并签订合同</li>
                    <li class="icon-five">现场协调，顺利办活动</li>
                </ul>
            </div>

        </div>
    </div>
</div>

{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
<script>
    var handler = function (captchaObj) {
        captchaObj.onReady(function(){
            var elements_n = $('.gt_holder');
            if (elements_n.length > 0) {
                elements_n.first().css({ 'z-index' : 10 });
            }
            var elements = $('.gt_mask');
            if (elements.length > 0) {
                elements.first().css({ 'z-index' : 500 });
            }
        });
        // 将验证码加到id为captcha的元素里
        captchaObj.bindOn("#yzm_captcha");
        captchaObj.onSuccess(function(){
            $("#yzm_captcha").hide();
            $(".js-yzm").show();
        });
        captchaObj.appendTo("#captcha");
    };
    $.ajax({
        // 获取id，challenge，success（是否启用failback）
        url:"http://{Core::$urls['host']}/static/api/common/start/cs.json?rand="+Math.round(Math.random()*100),
        type: "get",
        dataType: "json", // 使用jsonp格式
        success: function (data) {
            // 使用initGeetest接口
            // 参数1：配置参数，与创建Geetest实例时接受的参数一致
            // 参数2：回调，回调的第一个参数验证码对象，之后可以使用它做appendTo之类的事件
            initGeetest({
                gt: data.gt,
                challenge: data.challenge,
                product: "popup", // 产品形式
                offline: !data.success
            }, handler);
        }
    });
</script>
</body>
</html>