<!DOCTYPE html>
<html>
<head>
    {include file="Web_Static::v2.0/html_head.tpl"}
    {*{static "home.v2.0/homepage.css"}*}
    {*{static "home.v2.0/homepage.js"}*}
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">

    {static "vendor_join.v2.0/vendor_join.css"}
</head>
<body>
{include file="Web_Static::v2.0/html_header3.1.tpl"}
{*<div class="cover">
    <div class="tip">
        <span class="ion-close close-sub"></span>

        <p class="sub-title"><span class="ion-ios-lightbulb-outline"></span>&nbsp;提交成功</p>

        <p class="sub-p">我们的工作人员会尽快审核与您联系</p>
        <a href="javascript:;" class="sub-ok">知道了</a>
    </div>
</div>*}
<div class="j-banner">
    <img src="img/join.v2.0/banner_02.jpg" alt=" ">

    <div class="b-title">
        <p class="b-title1">我也有不错的活动资源</p>

        <p class="b-title2">如果你也有跟活动相关的空间场地、配套服务，快来加入我们吧</p>
    </div>
</div>
<div class="j-content">
<p class="j-c-title">基本信息</p>

<div class="j-form">
<input type="hidden" name="action" value="fromSubmit">

<div class="j-input">
    <label>
        <span><i>*</i>&nbsp;城市</span>

        <div class="j-i-content">

            <span class="error-tip"></span>
            <div class="select">
                <div class="city">
                    <input type="hidden" class="input-province" name="province" value="">
                    <a href="javascript:;" class="city-selects">
                        <p>省份</p>
                        <span class="ion-arrow-down-b"></span>
                    </a>
                    <ul class="province-city ul-province">
                        {foreach $province as $key=>$val}
                            <li data-value="{$val['code']}">{$val['name']}</li>
                        {/foreach}
                    </ul>
                </div>
                <div class="city">
                    <input type="hidden" class="input-city" name="city">
                    <a href="javascript:;" class="city-selects">
                        <p>城市</p>
                        <span class="ion-arrow-down-b"></span>
                    </a>
                    <ul class="province-city ul-city">

                    </ul>
                </div>
            </div>
        </div>
    </label>
</div>
<div class="j-input">
    <label><span><i>*</i>&nbsp;主营商品</span>

        <div class="j-i-content">
            <span class="error-tip"></span>
            <div class="input-select">
                {*<select type="text" placeholder="请选择类型">*}
                {*<option value="">酒球</option>*}
                {*</select>*}
                <div class="cate">
                    <input type="text" class="select-val" data-validate="true" style="display: none"
                           name="product_type">
                    <a href="javascript:;" class="c-select">
                        <p>请选择商品类型</p>
                        <span class="ion-arrow-down-b"></span>
                    </a>
                    <ul class="c-list-parent">
                        {foreach $menuType as $key=>$val}
                            <li>
                                <a href="javascript:;">{$key}<span
                                            class="ion-arrow-right-b c-l-p-icon"></span></a>
                                <ul class="c-list-son">
                                    {foreach $val as $k=>$v}
                                        <li class="c-info">
                                            <a href="javascript:;" data-value="{$k}">{$v}</a>
                                        </li>
                                    {/foreach}
                                </ul>
                            </li>
                        {/foreach}
                    </ul>
                </div>
            </div>
        </div>

    </label>
</div>
<div class="j-input">
    <label>
        <span><i>*</i>&nbsp;商品名称</span>

        <div class="j-i-content">
            <span class="error-tip"></span>
            <input type="text" placeholder="请填写商品名称" data-validate="true" name="product_name">
        </div>
    </label>
</div>
<div class="j-input">
    <label><span><i>*</i>&nbsp;供应商名称</span>

        <div class="j-i-content">
            <span class="error-tip"></span>
            <input type="text" placeholder="请填写供应商名称(3-18位字符)" data-validate="true" name="vendor_name">

        </div>


    </label>
</div>
<div class="j-input">
    <label><span><i>*</i>&nbsp;联系人</span>

        <div class="j-i-content">
            <span class="error-tip"></span>
            <input type="text" placeholder="请填写联系人" data-validate="true" name="contact_people"
                   value="{$__user['username']}">
        </div>
    </label>
</div>
<div class="j-input">
    <label><span><i>*</i>&nbsp;联系手机</span>

        <div class="j-i-content">
            <span class="error-tip"></span>
            <input type="text" placeholder="请填写联系方式" name="phone" VALUE="{$__user['phone']}">
        </div>
    </label>
</div>
<div class="clear"></div>
<div class="j-file" id="j-file1">
    <span> &nbsp;&nbsp;名片</span>
    <a href="javascript:;" class="file-select" yun="upload/upload.js::init" yun-input="card" yun-type="img"
       yun-btn="browse1" yun-list="file-list1" yun-parent="j-file1" yun-url="{$_root}order_info/upload">选择文件</a>

    <div class="pic-tip">
        <span>上传联系人的名片信息，审核会更快哦!</span><br/>
        <span>【格式为jpg,png,jpeg，大小不超过10M】</span>
    </div>
    <div class="wraper">
        <ul id="file-list1" class="file-list">
            <input type="text" name="card" style="display: none">
        </ul>
    </div>
    <div class="clear"></div>
</div>
<div class="clear"></div>
<div class="j-file" id="j-file2">

    <span><i>*</i>&nbsp;商品图片</span>
    <a href="javascript:;" class="file-select2" yun="upload/upload.js::init" yun-input="media" yun-type="img"
       yun-btn="browse2" yun-list="file-list2" yun-parent="j-file2" yun-url="{$_root}order_info/upload">选择文件</a>

    <div class="pic-tip">
        <span></span>
        <span>【格式为jpg,png,jpeg，大小不超过10M】</span>
    </div>
    <div class="wraper">
        <span class="error-tip" style="left:0%;top:80%;width:50%;display: inherit;padding-left: 15.7%"></span>
        <ul id="file-list2" class="file-list">
            <input type="text" name="media" style="display: none">

        </ul>
    </div>

    <div class="clear"></div>

</div>
<div class="clear"></div>
<div class="j-about">

    <span><i>*</i>&nbsp;商品介绍</span>
    <textarea name="product_des" id=""data-validate="true" style="border: 1px solid #ccc">
    </textarea>
    <span class="error-tip" style="top:97%;width:100%;padding-left: 16%;left:0px;"></span>
    <div class="clear"></div>
</div>
{********************未登录用户 start**************}

<div class="j-register hide">
    <p class="j-r-title">您还未登录，可以快速登录下啦</p>

    <div class="j-l-input">
        <p><i>*</i>&nbsp;手机号</p>

        <div class="j-r-i-input">
            <input type="text" class="join-phone" name="account_phone">
        </div>
    </div>
    <div class="j-l-input">
        <p><i>*</i>&nbsp;验证码</p>

        <div class="j-r-i-input">
            <div class="j-r-i-code">
                <input type="text" data-validate="true" name="code" class="code">
                <button class="send-code" type="button" yun-phone=".join-phone" yun-second="30"
                        yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click">发送验证码
                </button>
                <div class="clear"></div>
            </div>
            <span></span>
        </div>
    </div>
    <div class="j-l-input">
        <div class="j-check">
            <div class="input-check" style="display: none"><span style="color:#666"></span></div>
            <div style="text-align:left;float:left;width:89%;color:#666;font-size:13px;">
                提示:未注册的手机号，登录时将自动注册云·SPACE且代表您已阅读并同意<a href="javascript:;" target="_blank" class="read-agreement"
                                                       style="color:#2284e9;font-size: 13px;">《云·SPACE通行证注册协议》</a>
            </div>

            <input type="checkbox" style="display: none">

            <div class="clear"></div>
        </div>
    </div>
    {*<div class="j-l-input">*}
    {*<button class="send-code" type="button" id="register">*}
    {*提交*}
    {*</button>*}
    {*</div>*}
</div>

{****************未登录用户*end************}
<p class="error-info"></p>

{*<div class="j-check">*}
{*<div class="input-check"><span style="color:#666"></span></div>*}
{*&nbsp;&nbsp;<a href="javascript:;" target="_blank" class="read-agreement">我已阅读并同意《云·SPACEE通行证注册协议》</a>*}
{*<input type="checkbox" style="display: none">*}

{*<div class="clear"></div>*}
{*</div>*}
<div class="j-submit">
    <button type="submit" id="register">提交申请</button>
</div>
</div>
</div>
{*加盟协议*}
<div class="cover2"></div>
<div class="agreement">
    <p class="close-agreement"><span class="ion-close"></span></p>

    <div class="agreement-content">
        {include file="Web_Static::vendor_join.v2.0/agreement.tpl"}
    </div>
</div>
{include file="Web_Static::v2.0/form.tpl"}
{include file="Web_Static::v2.0/html_footer.tpl"}
<script src="js/vendor_join.v2.0/vendor_join.js"></script>
{*{static "vendor_join.v2.0/vendor_join.js"}*}
{*{static "core/yunspace.js"}*}

</body>
</html>