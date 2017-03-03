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
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>供应商名称</p>

            <div class="content">
                <input type="text" placeholder="输入您的公司名称" name="vendor_name" class="vendor_name">
            </div>
        </li>
        <li>
            <p> <i style="color: #fd7aae;  padding: 5px;">*</i>城市</p>

            <div class="content" name="data[活动城市]">
                <span class="error-tip"></span>
                <select class="province">
                    <option value="">请选择省份</option>
                    {foreach $city as $k=>$v}
                        <option value="{$v['code']}">{$v['name']}</option>
                    {/foreach}

                </select>
                <select class="cityname">
                    <option value="">请选择城市</option>

                </select>

            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>联系人</p>

            <div class="content">
                <input type="text" placeholder="输入您的真实姓名" name="contact_people" class="contact_people" value="{$__user['username']}">
            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>手机号码</p>

            <div class="content">
                <input type="text" placeholder="您的真实手机11位数字" name="phone" class="phone" VALUE="{$__user['phone']}">
            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>主营商品</p>


            <div class="content">
                <select name="product_type" name="data[业务类型]" id="business">
                    {foreach $categoryList[0] as $key=>$value}
                        {if $value}
                            <option value="{$key}{$value}">{$value}</option>
                        {/if}
                    {/foreach}

                    {*{foreach $menuType as $key=>$val}
                        <option value="{$key}" class="product_type" disabled>{$key}</option>
                        {foreach $val as $k=>$v}
                            <option value="{$K}"  class="product_type">&nbsp;&nbsp;&nbsp;&nbsp;{$v}</option>
                        {/foreach}
                    {/foreach}*}
                </select>
                <select class="form-control input-sm subBusiness" name="data[业务子类]" id="subBusiness" value="">
                </select>
            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;padding-right: 5px;">*</i>商品名称</p>

            <div class="content">
                <input type="text" placeholder="请填写商品名称" class="product-name" name="product-name">
            </div>
        </li>
        <li class="li-newadd li-file">
            <p><i style="color: #fd7aae;padding-right: 5px;">*</i>商品图片</p>
            <div class="content-file" id="j-file2">
                <a href="javascript:;" class="file-select" yun="upload/upload.js::init" yun-input="media" yun-type="img"
                   yun-btn="browse1" yun-list="file-list2" yun-parent="j-file2" yun-url="{$_root}order_info/upload">选择文件</a>
                <div class="hint-word">
                    <span>上传联系人的名片信息，审核会更快哦！</span>
                    <span style="color: #999">【格式为jpg,png,jpeg，大小不超过10M】</span>
                </div>
                <div class="wraper">

                    <ul id="file-list2" class="file-list">
                        <input type="text" name="media" style="display: none">
                        <div style="height: 0;clear: both"></div>
                    </ul>
                </div>
            </div>
            <div style="height: 0;clear: both"></div>
        </li>
        <li class="li-newadd">
            <p><i style="color: #fd7aae;padding-right:5px;">*</i>商品介绍</p>
            <div class="content-file">
                <textarea name="content" class="des"></textarea>
            </div>
            <div style="height: 0;clear: both"></div>
        </li>
        <li class="li-newadd li-file">
            <p style="text-indent: 12px">名片</p>
            <div class="content-file" id="j-file1">
                <a href="javascript:;" class="file-select" yun="upload/upload.js::init" yun-input="card" yun-type="img"
                   yun-btn="browse1" yun-list="file-list1" yun-parent="j-file1" yun-url="{$_root}order_info/upload">选择文件</a>
                <div class="hint-word">
                    <span>上传联系人的名片信息，审核会更快哦！</span>
                    <span style="color: #999">【格式为jpg,png,jpeg，大小不超过10M】</span>
                    <div style="height: 0;clear: both"></div>
                </div>
                <div class="wraper">
                    <ul id="file-list1" class="file-list">
                        <input type="text" name="card" style="display: none">
                        <div style="height: 0;clear: both"></div>
                    </ul>
                </div>
            </div>
            <div style="height: 0;clear: both"></div>
        </li>

<ul class="js-input hide">
        <li class="li-newadd">
            <div class="title">
                <h2>快捷登录</h2>
            </div>
        </li>
        <li class="li-newadd">
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>手机号码</p>

            <div class="content-log log-nmb">
                <input type="text" placeholder="您的真实手机11位数字" name="account_phone" class="join-phone">
            </div>
            <div style="height: 0;clear: both"></div>
        </li>
        <li class="li-newadd">
            <p style="width: 30%"><i style="color: #fd7aae;  padding: 5px;">*</i>手机验证码</p>

            <div class="content-log log-code">
                <input type="text" name="code"  data-validate="true" class="code" >
                <button class="send-code" yun-phone=".join-phone" yun-second="30"
                   yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click">发送验证码</button>
            </div>
            <div class="hint-log">提示：未注册的手机号，登录时江自动注册云·SPACE账号，且代表您已阅读并同意<a href="javascript:;" target="_blank" class="agree">《云·SPACE通行证注册协议》</a></div>
            <div style="height: 0;clear: both"></div>
        </li>


</ul>


        <li class="j-submit">
            <button class="submit-button" id="submit">立即提交</button>
        </li>
        <li style="height: 36px;margin: 15px 0;">
            <a href=tel:4000560599">
                <div class="contact-num">服务热线:&nbsp&nbsp400-056-0599</div>
            </a>
        </li>
    </ul>
    {*</form>*}
</div>


<div class="cover-agreement"></div>
<div class="agreement">
    <div class="agreement-content">
        <p class="close-agreement"><span class="ion-close-round"></span></p>
        {include 'user_center.v1.0/inc.agreement.tpl'}
    </div>


{include "Web_Static::v2.0/html_tj.tpl"}
{static "core/yunspace.js"}
</body>
<script>
    $(".agree").on("click",function(){
        $(".cover-agreement").fadeIn(400);
        $(".agreement").css({
            top:"12%",
            opacity:"1"
        })
    });
    $(".close-agreement,.cover-agreement").on("click",function(){
        $(".cover-agreement").fadeOut(400);
        $(".agreement").css({
            top:"100%",
            opacity:"0"
        })
    });



    var category = [
        {foreach $categoryList[0] as $k=>$v}
        {if $v}
        {
            'b': '{$v}',
            's': [
                {foreach $categoryList[$k] as $kk=>$vv}{if $vv}

                '{$vv}',
                {/if}{/foreach}
            ],
            'n':[
                {foreach $categoryList[$k] as $kk=>$vv}{if $vv}

                '{$kk}',
                {/if}{/foreach}
            ]
        },
        {/if}
        {/foreach}
    ];

    var bHtml = '<option value="{$data['business']}">{$data['business']}</option>';
    $('#business').change(function () {
        var index = $('#business').get(0).selectedIndex;
        if (index >= 0) {
            oSubBusiness(index);
        } else {
            $('#subBusiness').attr("disabled", true);
            $('#subBusiness').html('<option value="{$data['sub_business']}">{$data['sub_business']}</option>');
        }

    })
    for (var i = 0; i < category.length; i++) {
        bHtml += "<option value='" + category[i]['b'] + "'>" + category[i]['b'] + "</option>";
    }

    var oSubBusiness = function (i) {
        var oSubBusinessList = category[i]['s'], sHtml;
        for (var j = 0; j < category[i]['s'].length; j++) {
            sHtml += "<option value='" + category[i]['s'][j] + "' valueId ='"+category[i]['n'][j]+"' >" + category[i]['s'][j] + "</option>";
        }
        $('#subBusiness').html(sHtml);
        $('#subBusiness').removeAttr('disabled')
    }
    //选择城市
    $(".province").change( function () {
        var province_code = $('.province option:selected').attr('value');
        var name = $('.province option:selected').text();
        YunSpace.api('city/auto/complete.jsonp', {
            'province_code': province_code
        }, function (data) {

            if (data.status == 1) {
                var k = '';
                var liHtml = '';
                for (k in data.data) {
                    liHtml += '<option value="' + data.data[k]['name'] + '">' + data.data[k]['name'] + '</option>';
                }

                $(".cityname").html(liHtml);
                /* setTimeout(function(){
                 $(".cityname").trigger("click")
                 $(".cityname").focus();
                 console.log("sdfsdfsdf")
                 },200)*/

            }
        });
    });
    $(document).ready(function () {
        var business_val = $('#business').attr('value');
        if (!business_val) {
            oSubBusiness(0);
        }
    });
</script>
{static "vendor_join.v2.0/vendor_join.v2.0.js"}
</html>