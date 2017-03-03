{static "space_info/consult_price.css"}
<div class="consult hide" id="demand_div">
    <a class="close js-close" href="javascript:;"></a>
    <div class="consult-imd hide">
        <h2>立即咨询</h2>
        <ul class="inquiry-ul-contleft clearfix">
            <li>
                <label>您的称呼</label>
                <input type="text" class="fill username" name="data[联系人]" placeholder="请输入您的真实姓名">
            </li>
            <li>
                <label>您的联系方式</label>
                <input type="text" class="fill phone" name="data[联系电话]" placeholder="请输入您的手机号码">
            </li>
            <li class="li-textrea">
                <label>您想咨询的内容</label>
                <textarea class="fill" name="data[咨询内容]" placeholder="请输入您想要了解的场地信息"></textarea>
            </li>
        </ul>
        <input type="hidden" id="ask_name" name="data[ask_name]" value=""/>
        <input type="hidden" id="ask_type" name="data[ask_type]" value=""/>
        <a href="javascript:;" class="inquiry-btn js-inquiry-btn" id="get_more">提交</a>
    </div>

    <div class="consult-versic hide">
        <h2>验证手机<span>(由于您没有登录，请输入手机验证码)</span></h2>
        <ul class="inquiry-ul-contleft clearfix">
            <li>
                <label>请输入您收到的验证码</label>
                    <input type="text" class="fill username" id="inputCode" placeholder="请输入验证码">
                    <button type="button" class="resend send-code" yun-second="30" yun-phone=".phone" href="javascript:;" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-modal="true" >重新发送（30）</button>
            </li>
        </ul>
        <div class="consult-code">
            <p>关注云·SPACE服务号，获取最新回复</p>
            <div class="img-w">
                <img src="img/space_info/qrcode.jpg">
            </div>
        </div>
        <div class="consult-btn">
            <button class="fl consult-btn1 js-consult-btn1">取消</button>
            <button class="fr consult-btn2 js-consult-btn2" id="submitCode">提交</button>
        </div>
    </div>

    <div class="consult-look-price hide">
        <div class="look-price-title">
            <h5>查看参考价</h5>
            <p>输入您的手机号，即可查看所有场地的参考价哦~</p>
        </div>
        <ul class="inquiry-ul-contleft clearfix">
            <li class="li-phone">
                <label>您的手机号</label>
                <input type="text" class="fill js-oninput phone3" placeholder="请输入您的手机号码" name="data[联系手机号码]" >
            </li>
            <li class="li-code look-more hide">
                <label>手机验证码</label>
                <input type="text" id="look_price_code" class="fill js-y-code" placeholder="请输入6位数验证码">
                <button type="button" class="get-code blue" yun-second="30" yun-phone=".phone3" href="javascript:;" yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click" yun-modal="true" >获取验证码</button>
                {*<button type="button" class="get-code gray">重新发送（59）</button>*}
            </li>
        </ul>

        <div class="look-price-btn">
            <button class="lokprc-btn gray js-lokprc-btn look_price_submit">确定</button>
        </div>
    </div>

</div>



