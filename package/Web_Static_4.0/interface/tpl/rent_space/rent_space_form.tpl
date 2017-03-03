<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::v4.0/html_goto_mobile.tpl" url="m/"}
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "get_space/form_space.css"}
    {static "v4.0/data-picker.css"}
</head>
<body yun="form_space.v4.0/form_space.js::init" data-name="{$space['space_name']}">
{include file="Web_Static::inc/header_rent_space.tpl"}
<div yun="inc.v4.0/localData.js::pageController"></div>
<div class="form-container">
    <div class="form-header">
        <a href="{$_home}">首页</a>&nbsp;>&nbsp;<a href="" class="page-active">我要租场地</a>
    </div>
    <div class="form-body clearfix">
        <div class="form-body-left fl">
            <div class="form-left-header">
                <div class="form-left-title"><span>一键租场地</span></div>
            </div>
            {if $space}
                <div class="rec-block clearfix">
                    <a href="http://{Core::$urls['host']}/site/{Func_Url::str_urlencode($space['space_name'])}" target="_blank">
                    <div class="rec-img fl">
                        {if $space['logo']}
                            <img src="{Page_Site_Global::displayMedia($space['logo'],123,102)}" alt="">
                        {else}
                            <img src="img/no_img.jpg">
                        {/if}
                    </div>
                    <div class="rec-info fl">
                        <div class="rec-title">{$space["space_name"]}</div>
                        <div class="rec-code">
                            {foreach $space['tags'] as $k=>$v}
                                <span>{$v}</span>
                            {/foreach}
                        </div>
                        <div class="rec-addr">
                            {$space["city"]}市&nbsp;&nbsp;{$space["addr"]}
                        </div>
                    </div>
                    <div class="rec-tip">
                        <div>
                            <span>意向</span>
                        </div>
                    </div>
                    </a>
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
                    <div class="input-body fl">
                        <input type="text" placeholder="请输入你的手机号码" id="phone_space" class="error">
                    </div>
                    <div class="input-error fl">
                        手机号（仅支持中国大陆）
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
                <div class="form-input clearfix">
                    <div class="input-label fl line-every">场地预算</div>
                    <input type="text" hidden id="act_money">
                    <div class="form-select fl">
                        <ul class="form-select-list">
                            {*<li><a href="javascript:;" class="select-active1">0-1万</a></li>*}
                            <li><a href="javascript:;" class="select-active1">2万以下</a></li>
                            <li><a href="javascript:;">2-5万</a></li>
                            <li><a href="javascript:;">5-10万</a></li>
                            <li><a href="javascript:;">10-30万</a></li>
                            <li><a href="javascript:;">30-50万</a></li>
                            <li><a href="javascript:;">50万以上</a></li>
                            <li><a href="javascript:;">不限</a></li>
                        </ul>
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="input-label fl line-every">目标城市</div>
                    <input type="text" hidden id="act_city">
                    <div class="form-select fl">
                        <ul class="form-select-list"  data-many="true">
                            {foreach $page->cities as $k=>$v}
                                <li><a href="javascript:;">{$v}</a></li>
                            {/foreach}
                            {*<li><a href="javascript:;" class="select-active2">上海</a></li>*}
                            <li class="select-disabled">(可多选)</li>
                        </ul>
                    </div>
                </div>
                <div class="form-input clearfix">
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
                </div>
                <div class="form-input clearfix">
                    <div class="input-label fl line-every">活动类型</div>
                    <input type="text" hidden id="act_cate" value="{$activity}">
                    <div class="form-select fl">
                        <ul class="form-select-list">
                            <li><a href="javascript:;" {if $activity=="路演/展览/发布会"} class="select-active1"{/if}>路演/展览/发布会</a></li>
                            <li><a href="javascript:;" {if $activity=="派对/典礼/沙龙"} class="select-active1"{/if}>派对/典礼/沙龙</a></li>
                            <li><a href="javascript:;" {if $activity=="晚会/年会/演出"} class="select-active1"{/if}>晚会/年会/演出</a></li>
                            <li><a href="javascript:;" {if $activity=="会议/讲座"} class="select-active1"{/if}>会议/讲座</a></li>
                            <li><a href="javascript:;" {if $activity=="团建/拓展"} class="select-active1"{/if}>团建/拓展</a></li>
                            <li><a href="javascript:;" {if $activity=="短租/快闪店/移动店铺"} class="select-active1"{/if}>短租/快闪店/移动店铺</a></li>
                            <li><a href="javascript:;" {if $activity=="商业地推"} class="select-active1"{/if}>商业地推</a></li>
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
                    <div class="input-label fl line-every">场地要求</div>
                    <div class="form-textarea fl">
                        <textarea name="" id="act_demand" cols="30" rows="3"></textarea>
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="form-btn">
                        <button id="space-submit">提交</button>
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
</body>
</html>