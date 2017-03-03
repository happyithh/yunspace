<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Static::inc/head_meta.tpl"}
    {static "v4.0/common.css"}
    {static "get_space/success.css"}
    {static "v4.0/data-picker.css"}
</head>
<body yun="form_space.v4.0/form_space.js::init">
{include file="Web_Static::inc/header_rent_space.tpl"}
<div yun="inc.v4.0/localData.js::pageController"></div>
<div class="success-container">
    <input type="hidden" name="demand_id" value="{$demand_id}">
    <input type="hidden" name="phone" id="rent_phone" value="{$phone}">
    <div class="success-header">
        <a href="">首页</a>&nbsp;>&nbsp;<a href="" class="page-active">我要租场地</a>
    </div>
    <div class="success-content">
        <div class="success-title">
            <p>提交成功 !</p>
        </div>
        <div class="success-des" style="line-height: 26px;">
            {if $is_work_time}
                你的需求已提交成功，系统将会为你适配合适的场地，30分钟之内会有工作人员与你联系。
            {else}
                你的需求已提交成功，系统将会为你适配合适的场地，待工作时间会有工作人员与你联系，请保持通讯正常 <br />我们工作时间是周一至周五 9：00-18：00
            {/if}
        </div>
        <div class="success-code">
            <div class="form-body-left-bottom clearfix">
                <div class="form-footer-body clearfix">
                    <p class="yun-code fl">
                        <img src="img/weixin2.jpg">
                    </p>
                    <p class="yun-code-p fl">
                        <span class="yun-code-p1">举起手机，扫一扫关注</span><br/>
                        <span class="yun-code-p2">云SPACE微信公众号<br/>随时随地获取方案</span>
                    </p>
                </div>
            </div>
        </div>
    </div>
    <div class="success-footer">
        <div class="success-process">
            <ul class="success-process-list clearfix">
                <li>
                    <div class="success-pro-name"><p class="success-ok ok-one">提交需求</p></div>
                    <div class="success-pro-line "></div>
                    <div class="circle">
                        <div class="oked"></div>
                    </div>
                </li>
                <li>
                    <div class="success-pro-name"><p class="">需要更多场地</p></div>
                    <div class="success-pro-line"></div>
                    <div class="circle">
                        <div class="oked"></div>
                    </div>
                </li>
                <li>
                    <div class="success-pro-name"><p class="">免费VIP服务</p></div>
                    <div class="success-pro-line"></div>
                    <div class="circle">
                        <div class="oked"></div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="success-process-body">
            <div class="success-process-body-p"><p>我们将向您提供场地的报价和联系方式，如果您需要除报价之外的其他信息，请完善以下内容。</p></div>
            <div class="success-form">
                {*<div class="form-input clearfix">*}
                    {*<div class="input-label fl line-every">场地价格</div>*}
                    {*<input type="text" hidden id="act_price">*}
                    {*<div class="form-select fl">*}
                        {*<ul class="form-select-list"  data-many="true">*}
                            {*<li><a href="javascript:;" class="select-active2">报价</a></li>*}
                            {*<li><a href="javascript:;">市场价</a></li>*}
                            {*<li class="select-disabled">(可多选)</li>*}
                        {*</ul>*}
                    {*</div>*}
                {*</div>*}
                <div class="form-input clearfix">
                    <div class="input-label fl line-every">场地图片</div>
                    <input type="text" hidden id="act_img">
                    <div class="form-select fl">
                        <ul class="form-select-list"  data-many="true" data-initDisabled="true">
                            <li><a href="javascript:;">外景图</a></li>
                            <li><a href="javascript:;">内景图</a></li>
                            <li><a href="javascript:;">平面图</a></li>
                            <li><a href="javascript:;">案例图</a></li>
                            <li class="select-disabled">(可多选)</li>
                        </ul>
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="input-label fl line-every">基本信息</div>
                    <input type="text" hidden id="act_info">
                    <div class="form-select fl">
                        <ul class="form-select-list"  data-many="true"  data-initDisabled="true">
                            <li><a href="javascript:;">面积</a></li>
                            <li><a href="javascript:;">层高</a></li>
                            <li><a href="javascript:;">承重</a></li>
                            <li><a href="javascript:;">供电量</a></li>
                            <li><a href="javascript:;">吊点</a></li>
                            <li><a href="javascript:;">停车位</a></li>
                            <li><a href="javascript:;">其他配套</a></li>
                            <li class="select-disabled">(可多选)</li>
                        </ul>
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="form-btn">
                        <button id="success-submit-one">提交</button>
                    </div>
                </div>
            </div>

        </div>
        <div class="success-process-body none">
            <div class="success-process-body-p">
                <p>您的需求已提交成功，如果您还需要更多的场地及配套服务，请完善以下内容，获取免费VIP服务。</p>
            </div>
            <div class="success-form">
                <div class="form-input clearfix">
                    <div class="input-label fl">公司名称</div>
                    <div class="input-body fl">
                        <input type="text" placeholder="请填写真实的公司名称" id="company" class="error">
                    </div>
                </div>
                <div class="form-input clearfix" id="j-file1">
                    <input type="text" hidden id="act_file" name="person">
                    <div class="input-label fl">个人名片</div>
                    <ul class="input-img fl" id="input-img">

                    </ul>
                    <div class="file-submit fl">
                        <div class="file-submit-body">
                            <p id="upload-file" yun="upload/upload.js::init" yun-input="person" yun-type="img"
                            yun-btn="browse1" yun-list="input-img" yun-parent="j-file1" yun-only="true"
                                yun-url="{$_root}order_info/upload">上传</p>
                        </div>
                    </div>
                </div>
                <div class="form-input clearfix">
                    <div class="form-btn">
                        <button id="success-submit-two">提交</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="success-process-body none">
            <div class="success-process-body-p"><p class="success-all">您已成功获取免费VIP服务！活动顾问将尽快与您联系，请耐心等待...<br/></p></div>
        </div>
    </div>
</div>
{include file="Web_Static::inc/html_footer.tpl"}
{static "core/yunspace.js"}
</body>
</html>