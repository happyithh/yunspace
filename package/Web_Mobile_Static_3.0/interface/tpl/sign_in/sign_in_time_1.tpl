<!DOCTYPE html>
<html lang="en">
<head>
    {*{include file="Web_Mobile_Static::inc/header_meta.tpl"}*}
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    {static "v3.0/common.css"}
    {static "sign_in/mobiscroll_002.js"}
    {static "sign_in/mobiscroll_004.js"}
    {static "sign_in/mobiscroll.js"}
    {static "sign_in/mobiscroll_003.js"}
    {static "sign_in/mobiscroll_005.js"}
    {static "sign_in/mobiscroll_003.css"}
    {static "sign_in/mobiscroll_002.css"}
    {static "sign_in/mobiscroll.css"}
    {static "sign_in/sign_in.css"}
    <title>公出签到申请</title>
</head>
<body>
<div class="sign-fill-title">
    <a href="{$_home}sign_in">
    <i class="icon-back"></i>
    <p>请填写您的公出信息</p>
    </a>
</div>
<ul class="sign-time-cont">
    <li class="demos time-leave clearfix">
        <label for="leaveDateTime">离开时间：</label>
        <input value="" class="ipt-time ipt-dtl" readonly="readonly" name="leaveDateTime" id="leaveDateTime" type="text">
        <i class="icon-calendar"></i>
    </li>
    <li class="demos time-back clearfix">
        <label for="backDateTime">返回时间：</label>
        <input value="" class="ipt-time ipt-dtl" readonly="readonly" name="backDateTime" id="backDateTime" type="text">
        <i class="icon-calendar"></i>
    </li>
    <li class="demos time-leave clearfix">
        <label for="trea-adress">公出地址：</label>
        <textarea id="trea-adress" class="ipt-trea ipt-dtl" placeholder="请填写公出地址"></textarea>
    </li>
    <li class="demos time-leave clearfix">
        <label for="trea-reason">公出事由：</label>
        <textarea id="trea-reason" class="ipt-trea ipt-dtl" placeholder="请填写公出事由"></textarea>
    </li>
    <input value="list/status_all" type="hidden" id="url" type="text">
</ul>

<a href="javascript:;" onclick="submitApply(this)" class="sign-submit">提交</a>


{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
<script type="text/javascript">
    {literal}
    $(function () {
        var currYear = (new Date()).getFullYear();
        var opt={};
        opt.date = {preset : 'date'};
        opt.datetime = {preset : 'datetime'};
        opt.time = {preset : 'time'};
        opt.default = {
            theme: 'android-ics light', //皮肤样式
            display: 'modal', //显示方式
            mode: 'scroller', //日期选择模式
            dateFormat: 'yyyy-mm-dd',
            lang: 'zh',
            nowText: "今天",
            startYear: currYear - 10, //开始年份
            endYear: currYear + 10, //结束年份
            showNow: true
        };
//        $("#appDate").mobiscroll($.extend(opt['date'], opt['default']));
        var optDateTime = $.extend(opt['datetime'], opt['default']);
//        var optTime = $.extend(opt['time'], opt['default']);
        $("#leaveDateTime").mobiscroll(optDateTime).datetime(optDateTime);
        $("#backDateTime").mobiscroll(optDateTime).datetime(optDateTime);
//        $("#appTime").mobiscroll(optTime).time(optTime);
    });
    {/literal}
    function submitApply(e){
        var outside_time = $('#leaveDateTime').val();
        var back_time = $('#backDateTime').val();
        var address = $('#trea-adress').val();
        var outside_reason = $('#trea-reason').val();
        var url = $('#url').val();
        YunSpace.api('sign/in/apply/create.jsonp',{
            outside_time:outside_time,back_time:back_time,address:address,outside_reason:outside_reason
        },function(data){
            if(data.status ==1){
                window.location=url;
                return false
            }else{
                alert(data.msg);
            }
        },'json')
    }
</script>
</body>
</html>
