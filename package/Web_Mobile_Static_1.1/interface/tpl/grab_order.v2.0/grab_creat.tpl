<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v2.0/grab_creat.css"}
    {static "v1.0/jquery-1.11.1.min.js"}
    {static "grab_order.v2.0/fill.js"}
</head>
<body class="body-fff padding-bottom-68">
<div class="wrapper">
    <div class="grab-creat-logo">
        <a class="creat-logo" href="javascript:;"><img src="img/grab_order.v1.0/grab_logo.png"></a>
    </div>

    <div class="grab-creat-order">
        <h2>新建订单</h2>
        <ul class="creat-order-fill clearfix">
            <li>
                <label>活动城市</label>
                {*<input type="text" class="fill" name="data[活动城市]" placeholder="请输入活动城市">*}
                <select class="fill" name="data[活动城市]">
                    {foreach $_REQUEST['cities'] as $k=>$v}
                        <option>{$v}</option>
                    {/foreach}
                    <option>其他</option>
                </select>
            </li>
            <li>
                <label>联系人</label>
                <input type="text" class="fill username" name="data[联系人]" placeholder="请输入联系人">
            </li>
            <li>
                <label>联系人的手机号码</label>
                <input type="text" class="fill phone" name="data[联系电话]" placeholder="请输入有效的11位数字">
            </li>
            <li>
                <label>活动日期</label>
                <div class="range clearfix">
                    <input type="text" class="fl fill" name="data[活动日期]" placeholder="开始日期">
                    <span class="fl">—</span>
                    <input type="text" class="fr fill" name="data[结束日期]" placeholder="结束日期">
                </div>
            </li>
            <li>
                <label>预算范围</label>
                <div class="range clearfix">
                    <input type="text" class="fl fill" placeholder="预算最小值">
                    <span class="fl">—</span>
                    <input type="text" class="fr fill" placeholder="预算最大值">
                </div>
            </li>
            <li>
                <label>活动类型</label>
                <select class="fill" name="data[活动类型]">
                    <option>路演/展览/发布会</option>
                    <option>年会/晚会/演出</option>
                    <option>路演/展览/发布会</option>
                    <option>会议/讲座</option>
                    <option>团建/拓展</option>
                </select>
            </li>
            <li>
                <label>活动人数</label>
                <select class="fill" name="data[活动人数]">
                    <option>50-100人</option>
                    <option>100-300人</option>
                    <option>300-500人</option>
                    <option>500人以上</option>
                </select>
            </li>
            <li>
                <label>场地类型</label>
                <select class="fill">
                    <option>商业广场</option>
                    <option>商业广场</option>
                    <option>商业广场</option>
                </select>
            </li>
            <li class="li-textrea">
                <label>具体要求</label>
                <textarea class="fill" name="data[具体要求]" placeholder="请输入具体要求。"></textarea>
            </li>
        </ul>
    </div>

    <p class="hint">信息审核通过后，可得30积分哦！</p>
    <!--底部导航-->
    <div class="grab-creat-menu">
        <a class="fr alink" href="javascript:;">
            自己留着攒分
        </a>
    </div>
</div><!--wrapper-end-->
</body>
</html>