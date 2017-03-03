{static "product.v2.0/consult_price.css"}
{static "product.v2.0/product_consult_price.js"}
<div class="consult hide" id="demand_div">
    <a class="close js-close" href="javascript:;"></a>
    <div class="consult-look-price">
        <div class="look-price-title">
            <h5>查看参考价</h5>
            <p>输入您的手机号，即可查看所有场地的参考价哦~</p>
        </div>
        <ul class="inquiry-ul-contleft clearfix">
            <li class="li-phone">
                <label>您的手机号</label>
                <input type="text" class="fill js-oninput phone3" placeholder="请输入有效的11位数字" name="data[联系手机号码]" >
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

