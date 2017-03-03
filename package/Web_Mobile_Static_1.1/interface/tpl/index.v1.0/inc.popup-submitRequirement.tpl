<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {include "Web_Mobile_Static::index.v1.0/inc.head_index.tpl"}
    {static "index.v2.0/data-picker.css"}
</head>
<body>
<div class="top">
    <div class="top_left">
        <a href="{$_home}"><i class="ion-ios-arrow-back call-back"></i></a>
    </div>
    <div class="top-title">我要办活动</div>
</div>
<div class="popup-submit-requirement popup-content">
    <ul class="form-list">
        <li>
            <p class="success-tip">
                留下您的联系方式，30分钟内获多个精准场地报价，<br>场地方直接联系</p>
        </li>
        <li>
            <p>您的称呼</p>

            <div class="content">
                <input type="text" class="demand-contact-name" placeholder="输入您的称呼">
            </div>
        </li>
        <li>
            <p>手机号码</p>

            <div class="content">
                <input type="text" class="demand-contact-phone" placeholder="请输入真实手机11位数字号码">
            </div>
        </li>
        <li>
            <p>活动城市</p>

            <div class="content">
                <select name="data[活动城市]" class="demand-city" style="width:100%">
                    {foreach $_REQUEST['cities'] as $v}
                        <option {if $v==$_COOKIE['city']}selected="selected" {/if}>{$v}</option>
                    {/foreach}
                    <option>其他</option>
                </select>
            </div>
        </li>
        <li>
            <p>活动人数</p>

            <div class="content">
                <select name="data[活动人数]" class="person-input" style="width:100%">
                    <option>50人以下</option>
                    <option>50-100人</option>
                    <option>100-300人</option>
                    <option>300-500人</option>
                    <option>500人以上</option>
                </select>
            </div>
        </li>
        <li>
            <p>活动类型</p>

            <div class="content">
                <select name="data[活动类型]" class="demand-style" style="width:100%">
                    <option>派对/典礼/发布会</option>
                    <option>晚会/年会/演出</option>
                    <option>路演/展览/发布会</option>
                    <option>会议/讲座</option>
                    <option>团建/拓展</option>
                </select>
            </div>
        </li>

        <li>
            <p>预算范围</p>

            <div class="content">
                <select name="data[活动人数]" class="ys-input" style="width:100%">
                    <option>2万以下</option>
                    <option>2-5万</option>
                    <option>5-10万</option>
                    <option>10万以上</option>
                </select>
            </div>
        </li>

        <li style="height:350px;">
            <p>活动日期</p>

            <div class="content">
                <input type="text" class="demand-contact-name datePicker" placeholder="开始" name="data[联系人]" style="width:45%;float:left" readonly>

                <p class="zhi">至</p>
                <input type="text" class="demand-contact-name datePicker" placeholder="结束" name="data[联系人]" style="width:45%;float:left" readonly>

                <p style="display: block;top:35px;font-size:12px;color:#666;">
                    请在下方选择日期</p>
            </div>
            <div style="position:absolute;left:82px;top:70px;">
                <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"
                     yun-with-input="false"></div>
            </div>

        </li>
        <li>
            <p>&nbsp;</p>
            <div class="content">
                <label style="padding:0 0 0 20px">
                    <input type="checkbox" name="demand_other_4" value="1" id="demand_other_4" checked='' class="check-protocol" style="position: absolute; width:16px; height: 16px; margin: 0 0 0 -20px"/>
                    还需要其他的供应商服务
                </label>
            </div>
        </li>

        {*<li class="largeLi">*}
        {*<p>活动需求</p>*}

        {*<div class="larger-content">*}
        {*<textarea class="demand-content" name="data[具体要求]"></textarea>*}
        {*</div>*}
        {*</li>*}
        <li style="height:150px;">
            <div style="width:100%;text-align: center">
                <img src="img/index.v2.0/space_fwh.jpg" alt="" style="width:100px;height:auto">
            </div>
            <p class="focus-space">关注云·SPACE服务号,更快获取回复</p>
        </li>
        <li>
            <button class="submit-button m-demand-submit" style="background: #fe6a3a">
                <span class="ion-paper-airplane" style="font-size: 17px;"></span>
                立即提交
            </button>
        </li>
    </ul>
</div>
{include "Web_Static::v2.0/html_tj.tpl"}
<script>
    //alert(navigator.userAgent);
    isFromApp("1");
    function isFromApp(app){
        if(location.search.indexOf('app='+app)>=0){
            $(".top").css({
                display:"none"
            });
            return true;
        }
        return false;
    }
</script>
<script>
    $('.m-demand-submit').click(function () {
        var demand_city = $(".demand-city").find('option:selected').val();
        var contact_name = $(".demand-contact-name").val();
        var contact_phone = $(".demand-contact-phone").val();
        var content = $(".person-input").val();
        var content2 = $(".ys-input").val();
        var demand_style = $(".demand-style").find('option:selected').val();
        if (!contact_phone) {
            alert('请留下您的联系方式!');
            $(".demand-contact-phone").focus();
            return;
        }
        if ($("#demand_other_4").is(":checked")) {
            demand_other = 1;
        }
        YunSpace.api('demand/create.jsonp', {
            demand_city: demand_city,
            username: contact_name,
            phone: contact_phone,
            content: demand_style + ' -- ' + content + ' -- ' + content2,
            demand_style: demand_style,
            demand_other: demand_other,
            action: 'events',
            is_mobile: 1
        }, function (data) {
            if (data.status == 1) {
                alert('提交成功，云·SPACE正在为您匹配适用的场地，请稍候！');
                window.history.go(-1);
            } else {
                alert(data.msg);
            }
        });
    })
</script>
</body>
</html>