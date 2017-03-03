<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
    {static "index.v2.0/data-picker.css"}

</head>
<body class="body-fff">
<div class="wrapper padding-bottom-68">
    <div class="activity-needs-title">
        <a class="back" href="javascript:history.go(-1);"></a>

        <h2 class="title">活动需求</h2>
    </div>
    <ul class="activity-needs-list">
        {*<li>*}
        {*<p class="name">活动城市</p>*}

        {*<div class="substance length-100">*}
        {*<select name="city" class="td-txt">*}
        {*{foreach $_REQUEST['cities'] as $val}*}
        {*<option {if $val==$data['city']} selected{/if}>{$val}</option>*}
        {*{/foreach}*}
        {*</select>*}
        {*</div>*}
        {*</li>*}
        <li>
            <p class="name">活动人数</p>

            <div class="substance length-100">
                <select class="td-slt td-txt" name="people">
                    {foreach $option['people'] as $key =>$val}
                        <option {if $data['demand']['活动人数']==$val}selected{/if}>{$val}</option>
                    {/foreach}
                </select>
                <span class="icon-pull"></span>
            </div>
        </li>
        <li>
            <p class="name">活动类型</p>

            <div class="substance length-100">
                <select class="td-slt td-txt" name="activity_type">
                    {foreach $option['活动类型'] as $val}
                        <option>{$val}</option>
                    {/foreach}
                </select>
                <span class="icon-pull"></span>
            </div>
        </li>
        <li>
            <p class="name">预算范围</p>

            <div class="substance range">
                <input type="text" name="price_up" placeholder="最低价格" value="{$data['price_up']}">
                <span>至</span>
                <input type="text" name="price_down" placeholder="最高价格" value="{$data['price_down']}">
            </div>
        </li>
        <li>
            <p class="name">活动日期</p>

            <div class="substance range">
                {*<input type="text" name="time_a" placeholder="2015-10-26" value="{$data['demand']['开始时间']}">*}

                <input name="time_a" type="text" placeholder="开始日期" readonly
                       yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker fl fill"
                       data-validate="true"
                       data-error="请填写完整的活动日期" value="{$data['demand']['开始时间']}">

                <span>至</span>
                {*<input type="text" name="time_b" placeholder="2015-10-30" value="{$data['demand']['结束时间']}">*}

                <input name="time_b" type="text" placeholder="结束日期" readonly
                       yun="product.v2.0/enquiry.js::dateSelect@click" class="datePicker fl fill"
                       data-validate="true"
                       data-error="请填写完整的活动日期" value="{$data['demand']['结束时间']}">
            </div>
        </li>
        <li>
            <p class="name">活动标签</p>

            <div class="substance marks" id="needs-tags">
                <input type="hidden" name="tags" value="">

                <p>
                    为活动需求贴个标签吧
                </p>
                <a class="fr btn-in" href="?action=needsTags"></a>
            </div>
        </li>
        <li>
            <p class="name">具体要求</p>

            <div class="substance range">
                <textarea style="width: 100%;border-radius: 3px;" name="mark">{$data['demand']['具体要求']}</textarea>
            </div>
        </li>

    </ul>

    <!--底部确认收集报价按钮-->
    <a class="collect-btn" href="javascript:;" onclick="operation.needsEditSubmit(this)"
       data-id="{$data['id']}">确认收集报价</a>
</div>

{*日历插件*}
<div class="cover1 "
     style="display: none;position: fixed; left: 0px;top: 0px;width: 100%;height: 100%; background: rgba(0,0,0,0.5);z-index: 100;"></div>
<div class="date "
     style="display: none ;position: absolute; left: 50%;top: 10%;margin-left: -124px;z-index: 101;width: 248px;">
    <div yun="data-picker/js/date-picker.js::initPlugin" class="date-picker" yun-input=".datePicker"
         yun-with-input="false" style="background: rgb(255, 255, 255);border-radius: 8px;"></div>
</div>
{static "v1.0/jquery-1.11.1.min.js"}
{static "core/yunspace.js"}
{static "grab_order.v1.0/operation.js"}
<!--wrapper-end-->
<script>
    $(document).ready(function () {
        $("#needs-tags p").on('click',function(){
                window.location.href="?action=needsTags";
        });
        var tagsString = localStorage.getItem('needsTags');

        if (tagsString) {
            var tags = tagsString.toString();

            $("#needs-tags input").val(tags);

            var arr = tags.split(',');

            var html = '';
            for (var key in arr) {
                if (arr[key])
                    html += '<span>' + arr[key] + '</span>';
            }
            $("#needs-tags p").html(html);

        }
    });
</script>
</body>
</html>