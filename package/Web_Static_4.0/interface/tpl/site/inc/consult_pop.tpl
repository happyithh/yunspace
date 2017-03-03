{static "search.v4.0/box.css"}
{static "v4.0/data-picker.css"}
{*<div class="cover none cover1" id="cover"></div>*}
{*<div class="search-box none" id="search-code">*}
    {*<div class="search-box-close">*}
        {*<a href="javascript:;" id="search-box-close"><img src="img/v4.0/close.png" alt=""></a>*}
    {*</div>*}
    {*<div class="search-box-title">*}
        {*<span>合作咨询</span>*}
    {*</div>*}
    {*<input type="hidden" name="from_type" class="from_type" value="2" >*}
    {*<input type="hidden" name="space_id" class="space_id" value="{$page->id}">*}
    {*<input type="hidden" name="space_name" class="space_name" value="{$page->spaceName}">*}
    {*<ul class="search-box-item">*}
        {*<li>*}
            {*<div class="search-box-label">你的称呼</div>*}
            {*<input class="search-box-input" name="username" >*}
            {*<div class="search-box-placeholder">请输入你的真实姓名</div>*}
        {*</li>*}
        {*<li>*}
            {*<div class="search-box-label">你的手机号码</div>*}
            {*<input class="search-box-input"  name="phone"  >*}
            {*<div class="search-box-placeholder">查询结果将以短信方式发送给你</div>*}
        {*</li>*}
        {*<li>*}
            {*<div class="search_co_input">更多咨询</div>*}
            {*<input class="search-box-input" name="other_demand">*}
            {*<div class="search-box-placeholder">填写你想要咨询的其他问题</div>*}
        {*</li>*}
        {*<div class="clear"></div>*}
    {*</ul>*}
    {*<p class="none error_msg"></p>*}
    {*<div class="clear"></div>*}
    {*<button class="search-box-btn">提交</button>*}
    {*<div class="search-box-code-outside">*}
        {*<div class="search-box-code">*}
            {*<img src="css/search.v4.0/img/search_box_code.png">*}
        {*</div>*}
        {*<div class="search-box-code-word">*}
            {*<span>扫描二维码扫描二维码</span><br>*}
            {*立即回复，扫描二维码<br>*}
            {*加入我们！扫描二维码*}
        {*</div>*}
        {*<div class="clear"></div>*}
    {*</div>*}
{*</div>*}

<div class="search-box none" id="search-code">
    <div class="search-box-close">
        <a href="javascript:;" id="search-box-close"><img src="img/v4.0/close.png" alt=""></a>
    </div>
    {if $page->info['category_id']==200}
        <div class="search-box-title">
            <span>文创项目合作</span>
        </div>
        <input type="hidden" name="from_type" class="from_type" value="2" >
    {else}
        <div class="search-box-title">
            <span>合作咨询</span>
        </div>
        <input type="hidden" name="from_type" class="from_type" value="5" >
    {/if}
    <input type="hidden" name="space_id" class="space_id" value="{$page->id}">
    <input type="hidden" name="space_name" class="space_name" value="{$page->spaceName}">
    <input type="hidden" name="demand_city" class="demand_city" value="{$page->info['city']}">
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
