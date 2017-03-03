<!DOCTYPE html>
<html lang="en">
<head>
    {include file="Web_Mobile_Static::inc/header_meta.tpl"}
    {static "v1.0/global.css"}
    {static "product.v2.0/product_enquiry.css"}
    {*{static "plugins/Swiper-master/css/swiper.min.css"}*}
    <link rel="stylesheet" href="plugins/Swiper-master/css/swiper.min.css">
    <link rel="stylesheet" href="plugins/ionicons-master/css/ionicons.min.css">
    {static "index.v2.0/data-picker.css"}
</head>
<body yun="product.v2.0/enquiry.js::init">
<div yun="hide-app/hide-app.js::isApp"></div>
<div class="content">
    {*<a href="{$_root}" class="enquiry-header-logo">*}
        {*<img src="img/logo.png" alt="">*}
    {*</a>*}
    <div class="enquiry-tab none">
        <div class="enquiry-tab-eq fl enquiry-tab-eq-active">
            需求信息
        </div>
        <div class="enquiry-tab-eq fl">
            询价表单
        </div>
    </div>
    <div class="enquiry-tab-body">
        <div class="enquiry-tab-body-eq">
            <div class="enquiry-con-header">
                <p>文创项目加盟</p>
            </div>
            <div class="enquiry-con-header" style="border: 0">
                <span>一键加盟文创项目</span>
                <span>我们将在30分钟后尽快与您联系</span>
            </div>
            <div class="enquiry-con">
                <div class="enquiry-con-body ajax-form"  data-validate="true" >
                    <input type="hidden"  name="action" value="join">
                    <div class="enquiry-con-input">
                        <div class="enquiry-con-input-name">
                            <span class="red">*</span>
                            <span>您的称呼</span>
                        </div>
                        <div class="enquiry-con-input-con">
                            <input type="text" placeholder="请输入您的真实姓名"  data-validate="true" data-error="请填写您的称呼"  yun="form-validate/form-validate.js::typeValidate@keyup" name="username" >
                        </div>
                    </div>

                    <div class="enquiry-con-input">
                        <div class="enquiry-con-input-name">
                            <span class="red">*</span>
                            <span>您的联系方式</span>
                        </div>
                        <div class="enquiry-con-input-con">
                            <input type="text" placeholder="请输入有效的11位手机号码"  yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请填写11位的手机号码" data-length="11"
                             name="phone" yun-type="phone" class="phone3" yun-error="" yun-style="fontSize:25px,position:absolute,right:5px,line-height:30px,color:#ff0000" data-validate="true">
                        </div>
                    </div>
                    <div class="enquiry-con-input">
                        <div class="enquiry-con-input-name">
                            <span class="red">*</span>
                            <span>手机验证码</span>
                        </div>
                        <div class="enquiry-con-input-con">
                            <input type="text" id="look_price_code" name="code" yun-type="code" yun-phone=".phone3"  yun-error="" yun="form-validate/form-validate.js::typeValidate@keyup" data-error="请输入正确验证码" class="fill js-y-code" placeholder="请输入6位数验证码" data-validate="true" data-length="6">
                        </div>
                        <button id="yzm_captcha" class="get-code orange">①滑块拼图验证</button>
                        <button type="button" style="display: none"  class="get-code orange  rend_space" yun-second="30" yun-phone=".phone3" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" >获取验证码</button>
                        {*<button type="button" class="get-code gray">重新发送（59）</button>*}
                        <div id="captcha"></div>
                        <script src="http://static.geetest.com/static/tools/gt.js"></script>
                    </div>

                    <div class="enquiry-con-input" yun="product.v2.0/enquiry.js::select@click" yun-select="1">
                        <div class="enquiry-con-input-name">
                            <span>项目类型</span>
                        </div>
                        <div class="enquiry-con-input-con">
                            <input type="text" placeholder="请选择项目类型" readonly class="select" name="date_activity"  value=""/>
                            <span class="dropDown-icon ion-arrow-down-b"></span>
                        </div>
                    </div>

                    <input type="text" class="price-look"/>
                </div>
            </div>
        </div>

        {*<div class="enquiry-tab-body-eq" >*}
            <div class="enquiry-tab-body-eq none">
                <div class="enquiry-con"style="padding: 0px;">
                    {*ion-checkmark enquiry-li-check-active*}
                    <div class="enquiry-li none">
                        <input type="text" class="enquiry-checked none">
                        <div class="enquiry-li-check fl">
                            <span class="check-cir ion-checkmark enquiry-li-check-active"></span>
                        </div>
                        <div class="enquiry-li-p fl">
                            <span></span>
                        </div>
                        <div class="enquiry-li-delete">
                            <span>删除</span>
                        </div>
                    </div>


                </div>
                {*<div class="enquiry-btn">*}
                    {*<button>一键询价</button>*}
                {*</div>*}
            </div>
        {*</div>*}
    </div>
    <div class="enquiry-btn">
        <button yun="form-validate/form-validate.js::ajaxSubmit@click" yun-url="demand/create.jsonp" yun-ajax="ip_join"
                yun-error=".d-s-error" yun-form=".ajax-form" data-id="0" class="demand-submit-btn">立即加盟</button>
    </div>
    {*input选项*}
    <div class="cover1 none"></div>

    <div class="show-select-list none">
        <div class="show-select-li">50人以下</div>
        <div class="show-select-li">50-100人</div>
        <div class="show-select-li">100-300人</div>
        <div class="show-select-li">300-500人</div>
        <div class="show-select-li">500人以上</div>
    </div>
    <div class="show-select-list none">
        {foreach $category as $k=>$v}
            <div class="show-select-li">{$v}</div>
        {/foreach}
        {*<div class="show-select-li">派对/典礼/沙龙</div>*}
        {*<div class="show-select-li">晚会/年会/演出</div>*}
        {*<div class="show-select-li">路演/展览/发布会</div>*}
        {*<div class="show-select-li">会议/讲座</div>*}
        {*<div class="show-select-li">团建/拓展</div>*}
    </div>
        {*<div class="show-select-list none">*}
            {*{foreach $_REQUEST['cities'] as $k=>$val}*}
            {*<div class="show-select-li">{$val}</div>*}
            {*{/foreach}*}
            {*<div class="show-select-li">其他</div>*}
        {*</div>*}

    <div class="error-all none">
        <span>用户名必须填写</span>
    </div>

    <div class="date none">
        <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"
             yun-with-input="false"></div>
    </div>

</div>

<script src="plugins/Swiper-master/js/swiper.min.js"></script>
{*<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=aaNCRRcGGai6klHMOGZ8yBbP"></script>*}
{static "v1.0/jquery-1.11.1.min.js"}
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
            $(".rend_space").show();
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