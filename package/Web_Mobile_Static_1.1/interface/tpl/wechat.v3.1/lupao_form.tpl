<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no,minimal-ui">
    <meta name="format-detection" content="telephone=no"/>
    <link type="text/css" rel="stylesheet" href="css/v1.0/style_public.css">
    <link type="text/css" rel="stylesheet" href="css/wechat.v3.0/booking_new.css">
    <title>{$event_info['title']}[云·Space 活动售票]</title>
    <style>
        .fill-adress li p{
            font-size: 14px;
        }
    </style>
</head>
<body style="background: #fff">
<ul class="booking-nav clearfix">
    <li class="active" style="width: 85%"><a href="#" >路跑报名信息（必填）</a></li>
    <li style="width:15%"><a href="{Core::$urls['referer']}" style="border: none;">返回</a></li>
</ul>
{*<div class="form_title">请留下基本信息，内测开始时会与您联系</div>*}
<form action="{$_home}event_ticket/submit_lupao_form" method="post" class="form">
<input id="id" name="id" value="10" type="hidden">
        <ul class="fill-adress">
            <li>
                <p>姓名：</p>
                <input type="text" name="data[姓名]" value="" placeholder="请输入姓名">
            </li>
            <li>
                <p>性别：</p>
                   <label style="width: 25%;display: block;height:30px;line-height:30px;float: left;margin-left: 10px;">
                       <input type="radio" class="sex" name="data[性别]" value="男" style="width:20px;height:20px;line-height:30px;-webkit-appearance:radio;margin: 8px 8px 0 0;">男
                   </label>
                    <label style="width: 25%;display: block;height:30px;line-height:30px;float: left;margin-left: 10px;">
                        <input type="radio" class="sex" name="data[性别]" value="女"style="width:20px;height:20px;line-height:30px;-webkit-appearance:radio;margin: 8px 8px 0 0;">女
                    </label>
            </li>
            <li>
                <p>赛事名称：</p>
                <input type="text" name="data[赛事名称]" value="" placeholder="请输入赛事名称" style="width: 65%;">
            </li>
            <li>
                <p>科目：</p>
                <input type="text" name="data[科目]" value="" placeholder="请输入科目">
            </li>
            <li>
                <p>手机号：</p>
                <input type="phone" name="data[手机号]" value="" placeholder="请输入手机号码" style="width: 75%;">
            </li>
            <li>
                <p>邮箱：</p>
                <input type="text" name="data[邮箱]" value="" placeholder="请输入可用邮箱">
            </li>
            <li>
                <p>紧急联系人姓名：</p>
                <input type="text" name="data[紧急联系人姓名]" value="" placeholder="请输入紧急联系人姓名" style="width: 50%;">
            </li>
            <li>
                <p>紧急联系人关系：</p>
                <input type="text" name="data[紧急联系人关系]" value="" placeholder="请输入紧急联系人关系" style="width: 50%;">
            </li>
            <li>
                <p>紧急联系人号码：</p>
                <input type="text" name="data[紧急联系人号码]" value="" placeholder="请输入紧急联系人号码" style="width: 50%;">
            </li>
            <li>
                <p>身份证号：</p>
                <input type="text" name="data[身份证号]" value="" placeholder="请输入身份证号" style="width: 70%;">
            </li>
            <li style="margin-bottom: 10px;">
                <p>t恤尺寸：</p>
                <span style="font-size: 14px;margin-left: 10px; ">均码</span>
                <input type="hidden" name="data[t恤尺寸]" value="均码" >
            </li>
        </ul>
            <div class="boki-btn" style="position: inherit;">
                <button  class="bg-green add-adress submit_form_event" >点击提交</button>
            </div>
</form>
<script src="js/v1.0/jquery-1.11.1.min.js"></script>
<script>
    $('.submit_form_event').click(function(){
       var results =  JS.GetRadioValue('sex');
        if(typeof(results)=="undefined"){
            alert('请选择性别，以便为您准备合适的战袍~');
            return false;

        }else{
            $('.form').submit();
            return false;
        }
    });
    var JS = {
        IsNullOrEmpty:function(str){
            if(typeof(str)=="undefined") {
                return true;
            }
            if(str==null){
                return true;
            }
            if(str=="") {
                return true;
            }
            return false;
        },
        GetRadioValue:function(radioName)
        {
            var radios = $('.'+radioName);
            for(var i = 0 ; i< radios.length; i++)
            {
                var radio = radios[i];
                if(radio.checked)
                {
                    if(JS.IsNullOrEmpty(radio.value)) {
                        return undefined;
                    }else{
                        return radio.value;
                    }
                }
            }
            return undefined;
        }
    }
</script>
</body>
</html>
