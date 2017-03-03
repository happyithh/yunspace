{static "search.v4.0/box.css"}
{static "v4.0/data-picker.css"}
<div class="search-box none" id="search-code">
    <div class="search-box-close">
        <a href="javascript:;" id="search-box-close"><img src="img/v4.0/close.png" alt=""></a>
    </div>
    <div class="search-box-title">
        <span>合作咨询</span>
    </div>
    <input type="hidden" name="from_type" class="from_type" value="5" >
    <ul class="search-box-item" style="height: 135px;">
        <li>
            <div class="search-box-label">你的称呼</div>
            <input class="search-box-input" name="username" >
            <div class="search-box-placeholder">请输入你的称呼</div>
        </li>
        <li>
            <div class="search-box-label">你的手机号码</div>
            <input class="search-box-input"  name="phone">
            <div class="search-box-placeholder">查询结果将以短信方式发送给你</div>
        </li>
        <li class="search_co_input">
            <div class="search-box-label">咨询内容</div>
            <input class="search-box-input" name="other_demand">
            <div class="search-box-placeholder">填写你想要咨询的问题</div>
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
