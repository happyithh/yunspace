<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::index.v1.0/inc.head_index.tpl"}

</head>
<body>
<div class="top">
    <div class="top_left">
        <a href="{$_home}"><i class="ion-ios-arrow-back"></i></a>
    </div>
    <div class="top-title">供应商加盟</div>
</div>
<div class="popup-vendor-join popup-content">
    {*<form action="{$_root}demand_submit/vendor_join" method="post">*}
    <ul>
        <li>
            <p>供应商名称</p>

            <div class="content">
                <input type="text" placeholder="输入您的公司名称" name="vendor_name" class="vendor_name">
            </div>
        </li>
        <li>
            <p>城市</p>

            <div class="content" name="data[活动城市]">
                <select>
                    {foreach $city as $k=>$v}
                        <option value="{$v['name']}" class="city">{$v['name']}</option>
                    {/foreach}

                </select>

            </div>
        </li>
        <li>
            <p>联系人</p>

            <div class="content">
                <input type="text" placeholder="输入您的真实姓名" name="contact_people" class="contact_people">
            </div>
        </li>
        <li>
            <p>手机号码</p>

            <div class="content">
                <input type="text" placeholder="您的真实手机11位数字" name="phone" class="phone">
            </div>
        </li>
        <li>
            <p>主营商品</p>


            <div class="content">
                <select name="product_type">
                    {foreach $menuType as $key=>$val}
                        <option value="{$key}" class="product_type" disabled>{$key}</option>
                        {foreach $val as $k=>$v}
                            <option value="{$v}" class="product_type">&nbsp;&nbsp;&nbsp;&nbsp;{$v}</option>
                        {/foreach}
                    {/foreach}
                </select>
            </div>
        </li>
        <li>
            <button class="submit-button" id="submit">立即提交</button>
        </li>
        <li>
            <a href=tel:4000560599">
                <div class="contact-num">服务热线:&nbsp&nbsp400-056-0599</div>
            </a>
        </li>
    </ul>
    {*</form>*}
</div>
{include "Web_Static::v2.0/html_tj.tpl"}
{static "core/yunspace.js"}
</body>
<script>
    $("#submit").on('click', function () {
        var vendor_name = $('.vendor_name').val();
        if (!vendor_name) {
            $('.vendor_name').focus();
            return false;
        }
        var city = $('.city').val();
        var contact_people = $('.contact_people').val();
        if (!contact_people) {
            $('.contact_people').focus();
            return false;
        }
        var phone = $('.phone').val();
        if (!phone) {
            $('.phone').focus();
            return false;
        }
        var product_type = $('.product_type').val();
        YunSpace.api('vendor/join.jsonp', {
            vendor_name: vendor_name,
            city: city,
            contact_people: contact_people,
            phone: phone,
            product_name: product_type
        }, function (data) {
            if (data.status == 1) {
                top.alert(data.msg);
                window.location.reload();
            } else {
                top.alert(data.msg);
            }
        });
    });
</script>
</html>