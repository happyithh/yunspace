<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::index.v1.0/inc.head_index.tpl"}
    <link type="text/css" rel="stylesheet" href="css/vendor_join.v2.0/space_info_list.css">
</head>

<body>
<div class="space-title">
    <h1>填写您的场地信息</h1>
    <p>简单提交，快速审核</p>
</div>
<div class="popup-vendor-join popup-content">
   {* <form action="{$_root}new_space/aaaa" method="post">*}
    <ul>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>场地名称 <span class="error-tip"></span></p>

            <div class="content">
                <input type="text" placeholder="请填写场地名称" name="product_name" class="product_name">
            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>场地类型 <span class="error-tip"></span></p>
            <div class="content">
               <a href="javascript:;" class="c-select">  </a>
                <select class="space-kinds" >
                    <option value="">请选择场地类型</option>
                    {foreach $categoryTree[112] as $key=>$val}
                        <option value="{$key}"
                                {*{if $_demand['demand']['场地类型']==$val}selected{/if}*}>{$val}</option>
                    {/foreach}
                </select>
            </div>
        </li>
        <li class="li-select">
            <p> <i style="color: #fd7aae;  padding: 5px;">*</i>所属区域  <span class="error-tip"></span></p>

            <div class="content" name="data[活动城市]" >
                <a href="javascript:;" class="city-selects">
                </a>
                <select class="province">
                    <option value="">请选择省份</option>
                    {foreach $city as $k=>$v}
                        <option data-id="{$v['code']}" value="{$v['name']}">{$v['name']}</option>
                    {/foreach}

                </select>
                <select class="cityname">
                    <option value="">请选择城市</option>

                </select>
                <select class="countyname">
                    <option value="">请选择区县</option>

                </select>

            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>地址<span class="error-tip"></span></p>

            <div class="content">
                <input type="text" placeholder="请填写场地详细地址" name="addr" class="addr" >
            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>联系人<span class="error-tip"></span></p>

            <div class="content">
                <input type="text" placeholder="请填写联系人" name="contact_people" class="contact_people" >
            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>联系手机<span class="error-tip"></span></p>

            <div class="content">
                <input type="text" placeholder="请填写联系手机号码" name="phone" class="phone" >
            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>验证码<span class="error-tip"></span></p>

            <div class="content">
                <input type="text"  name="code" style="width: 72%;margin-right: 2%;float: left" data-validate="true" class="code">
                <button class="send-code" yun-phone=".phone" yun-second="30"
                        yun="identify-code.v1.0/identify-code.v1.0.js::sendCode@click">发送验证码</button>
            </div>
        </li>
        <li>
            <p><i style="color: #fd7aae;  padding: 5px;">*</i>邮箱<span class="error-tip"></span></p>

            <div class="content">
                <input type="text" placeholder="请填写邮箱" name="e-mail" >
            </div>
        </li>
        <li class="li-newadd li-file">
            <p><i style="color: #fd7aae;padding-right: 5px;">*</i>名片/营业执照<span class="error-tip"></span></p>
            <div class="content-file" id="j-file1">
                <a href="javascript:;" class="file-select" yun="upload/upload.js::init" yun-input="card" yun-type="img"
                   yun-btn="browse1" yun-list="file-list1" yun-parent="j-file1" yun-url="{$_root}order_info/upload">选择文件</a>
                <div class="hint-word">
                    <span>上传名片或营业执照信息，审核会更快哦！</span>
                    <span style="color: #999">【格式为jpg,png,jpeg，大小不超过2M】</span>
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
        <li class="j-submit">
            <button class="submit-button" id="submit" data-id="{$account_id}">提交</button>
        </li>
    </ul>
    {*</form>*}
</div>

{include "Web_Static::v2.0/html_tj.tpl"}
{static "core/yunspace.js"}
</body>
<script>

    //选择城市
    $(".province").change( function () {
        var province_code = $('.province option:selected').data('id');
        var name = $('.province option:selected').text();
        YunSpace.api('city/auto/complete.jsonp', {
            'province_code': province_code
        }, function (data) {

            if (data.status == 1) {
                var k = '';
                var liHtml = '';
                for (k in data.data) {
                    liHtml += '<option data-id="'+data.data[k]['code']+'" value="' + data.data[k]['name'] + '">' + data.data[k]['name']+'</option>';
                }
                $(".cityname").html(liHtml);

                var city_code = $('.cityname option:selected').data('id');
                var name = $('.cityname option:selected').text();
                YunSpace.api('city/auto/complete.jsonp', {
                    'city_code': city_code
                }, function (data) {
                    if (data.status == 1) {
                        var k = '';
                        var litml = '';
                        for (k in data.data) {
                            litml += '<option data-id="'+data.data[k]['code']+'" value="' + data.data[k]['name'] +  '">' + data.data[k]['name'] + '</option>';
                        }
                        $(".countyname").html(litml);
                    }

                });
                /* setTimeout(function(){
                 $(".cityname").trigger("click")
                 $(".cityname").focus();
                 console.log("sdfsdfsdf")
                 },200)*/

            }
        });
    });

    $(".cityname").change( function () {
        var city_code = $('.cityname option:selected').data('id');
        var name = $('.cityname option:selected').text();
        YunSpace.api('city/auto/complete.jsonp', {
            'city_code': city_code
        }, function (data) {

            if (data.status == 1) {
                var k = '';
                var litml = '';
                for (k in data.data) {
                    litml += '<option data-id="'+data.data[k]['code']+'" value="' + data.data[k]['name'] +  '">' + data.data[k]['name'] + '</option>';
                }

                $(".countyname").html(litml);


            }
        });
    });
</script>
{static "new_space1.0/new_space.js"}
</html>