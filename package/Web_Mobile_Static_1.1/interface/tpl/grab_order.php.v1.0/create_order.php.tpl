<!DOCTYPE html>
<html>
<head lang="en">
    <title>创建订单</title>

    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab_creat.css"}

    {static "index.v2.0/data-picker.css"}


</head>
<body class="body-fff padding-bottom-48">
<div class="wrapper">

    {*<div class="grab-creat-logo">*}
    {*<a class="creat-logo" href="javascript:;"><img src="img/grab_order.v1.0/grab_logo.png"></a>*}
    {*</div>*}
    <div class="grab-creat-order">
        <h2>新建订单</h2>
        <ul class="creat-order-fill clearfix" id='grab_order'>
            <li>
                <label>活动城市</label>
                <select class="fill" name="city">
                    {foreach $_REQUEST['cities'] as $k=>$v}
                        <option value="{$v}">{$v}</option>
                    {/foreach}
                    <option value="其他">其他</option>
                </select>
            </li>
            <li>
                <label>联系人</label>
                <input type="text" class="fill username" name="contact" placeholder="联系人不能超过6个字符">
            </li>
            <li>
                <label>联系人的手机号码</label>
                <input type="number" class="fill phone" name="contact_phone" placeholder="请输入有效的11位数字">
            </li>
            <li>
                {*<label>活动日期</label>*}

                {*<div class="range clearfix">*}
                {*<input type="text" class="fl fill" name="start_time" placeholder="开始日期">*}
                {*<span class="fl">—</span>*}
                {*<input type="text" class="fr fill" name="end_time" placeholder="结束日期">*}
                {*</div>*}
                <label class="enquiry-con-input-name" yun="product.v2.0/enquiry.js::dateSelect@click">
                    活动日期
                </label>

                <div class="range clearfix ">
                    <input name="start_time" type="text" placeholder="开始日期" readonly style="width:33%;float: left"
                           yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker fl fill"
                           data-validate="true"
                           data-error="请填写完整的活动日期">
                    <span class="fl">—</span>
                    <input name="end_time" type="text" placeholder="结束日期" readonly style="width:33%;float: left"
                           yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker fl fill"
                           data-validate="true"
                           data-error="请填写完整的活动日期">
                </div>
            </li>
            <li>
                <label>预算范围</label>

                <div class="range clearfix">
                    <input type="number" class="fl fill" name="price_up" placeholder="预算最小值">
                    <span class="fl">—</span>
                    <input type="number" class="fr fill" name="price_down" placeholder="预算最大值">
                </div>
            </li>
            {*<li>*}
            {*<label>活动类型</label>*}
            {*<select class="fill" name="type">*}
            {*<option>团建/拓展</option>*}
            {*</select>*}
            {*</li>*}
            <li>
                <label>活动人数</label>
                <select class="fill" name="people">
                    <option>50-100人</option>
                    <option>100-300人</option>
                    <option>300-500人</option>
                    <option>500人以上</option>
                </select>
            </li>
            <li>
                <label>活动类型</label>
                <select class="fill" name="activity_type">
                    {foreach $option['活动类型'] as $val}
                        <option value="{$val}">{$val}</option>
                    {/foreach}
                </select>
            </li>
            <li class="li-textrea">
                <label>具体要求</label>
                <textarea class="fill" name="mark" placeholder="请输入具体要求。"></textarea>
            </li>
        </ul>
    </div>
    <div style="text-align: center">
        可以攒20积分哦！
    </div>
    <!--底部导航-->
    <div class="grab-creat-menu">

        {*<a class="fl alink" href="javascript:;" onclick="operation.createNeedsOrderSubmit(this,'grab_order')">*}
        {*让其他人抢单*}
        {*</a>*}
        <a class="fr alink" href="javascript:;" onclick="operation.createNeedsOrderSubmit(this,'my_order')"
           style="width: 100%;text-align: center">
            自己留着攒分
        </a>
    </div>

    {*input选项*}
    <div class="cover1 "
         style="display: none;position: fixed; left: 0px;top: 0px;width: 100%;height: 100%; background: rgba(0,0,0,0.5);z-index: 100;"></div>
    <div class="date "
         style="display: none ;position: absolute; left: 50%;top: 10%;margin-left: -124px;z-index: 101;width: 248px;">
        <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"
             yun-with-input="false" style="background: rgb(255, 255, 255);border-radius: 8px;"></div>
    </div>
</div>
<!--wrapper-end-->
{*{include "Web_Mobile_Static::grab_order.php.v1.0/inc/menu.tpl"}*}
{static "v1.0/jquery-1.11.1.min.js"}
{static "grab_order.v1.0/fill.js"}
{static "grab_order.v1.0/operation.js"}
{static "core/yunspace.js"}
</body>
</html>