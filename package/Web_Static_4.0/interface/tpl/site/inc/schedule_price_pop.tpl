{static "search.v4.0/box.css"}
{static "v4.0/data-picker.css"}
{*<div class="cover none cover1" id="cover"></div>*}
<div class="search-box none" id="search-code">
    <div class="search-box-close">
        <a href="javascript:;" id="search-box-close"><img src="img/v4.0/close.png" alt=""></a>
    </div>
    <div class="search-box-title">
        <span>查询档期和价格</span>
    </div>
    <input type="hidden" name="from_type" class="from_type" value="1" >
    <input type="hidden" name="space_id" class="space_id" value="{$page->id}">
    <input type="hidden" name="space_name" class="space_name" value="{$page->spaceName}">
    <input type="hidden" name="demand_city" class="demand_city" value="{$page->info['city']}">
    <ul class="search-box-item" style="height: 135px;">
        <li>
            <div class="search-box-label">你的称呼</div>
            <input class="search-box-input" name="username" placeholder="请输入你的称呼">
            {*<div class="search-box-placeholder">请输入你的称呼</div>*}
        </li>
        <li>
            <div class="search-box-label">你的手机号码</div>
            <input class="search-box-input"  name="phone" placeholder="查询结果将以短信方式发送给你" >
            {*<div class="search-box-placeholder">查询结果将以短信方式发送给你</div>*}
        </li>
        <li>
            <div class="search-box-label">活动档期</div>
            <div class="enquiry-con-input-con">
                <input name="date_start" type="text" placeholder="开始日期" readonly style="width:33%;float: left" yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker search-date-start"  data-validate="true" data-error="请选择开始的活动日期" >
                <span style="float: left;width:4%;line-height: 30px;text-align: center">——</span>
                <input name="date_end" type="text" placeholder="结束日期" readonly style="width:33%;float: left" yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker search-date-end"  data-validate="true" data-error="请选择结束的活动日期" >
                <div class="clear"></div>
                <div class="search-date-outside">
                    <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"  yun-autohide="true" yun-autohidenode=".search-date-outside"
                         yun-with-input="false"></div>
                </div>
            </div>
        </li>
        <li>
            <div class="search-box-label">更多咨询</div>
            <input class="search-box-input" name="other_demand" placeholder="填写你想要咨询的其他问题">
            {*<div class="search-box-placeholder">填写你想要咨询的其他问题</div>*}
        </li>
        <div class="clear"></div>
    </ul>
    <p class="none error_msg"></p>
    <div class="clear"></div>
    <button class="search-box-btn">提交</button>
    <div class="search-box-code-outside">
        <div class="search-box-code">
            <img src="img/qrcode_space.png" >
        </div>
        <div class="search-box-code-word">
            <span>打开微信，扫一扫关注</span><br>
            云·space 微信公众号<br>随时随地获取报价方案
        </div>
        <div class="clear"></div>
    </div>
</div>
{static "core/yunspace.js"}
