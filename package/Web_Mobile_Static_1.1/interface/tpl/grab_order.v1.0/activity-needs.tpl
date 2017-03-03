<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
</head>
<body class="body-fff">
<div class="wrapper padding-bottom-68">
    <div class="activity-needs-title">
        <a class="back" href="javascript:;"></a>
        <h2 class="title">活动需求</h2>
    </div>
    <ul class="activity-needs-list">
        <li>
            <p class="name">活动城市</p>
            <div class="substance length-100">
                <input type="text" value="上海">
            </div>
        </li>
        <li>
            <p class="name">活动人数</p>
            <div class="substance length-100">
                <select>
                    <option>50人以下</option>
                    <option>50人以下</option>
                    <option>50人以下</option>
                </select>
                <span class="icon-pull"></span>
            </div>
        </li>
        <li>
            <p class="name">活动类型</p>
            <div class="substance length-100">
                <select>
                    <option>排队/典礼/发布会</option>
                    <option>排队/典礼/发布会</option>
                    <option>排队/典礼/发布会</option>
                </select>
                <span class="icon-pull"></span>
            </div>
        </li>
        <li>
            <p class="name">预算范围</p>
            <div class="substance range">
                <input type="text" placeholder="0">
                <span>至</span>
                <input type="text" placeholder="20000">
            </div>
        </li>
        <li>
            <p class="name">活动日期</p>
            <div class="substance range">
                <input type="text" placeholder="2015-10-26">
                <span>至</span>
                <input type="text" placeholder="2015-10-30">
            </div>
        </li>
        <li>
            <p class="name">活动标签</p>
            <div class="substance marks">
                <p>
                    {*<span>文体娱乐</span>*}
                    {*<span>秀场展馆</span>*}
                    为活动需求贴个标签吧
                </p>
                <a class="fr btn-in" href=""></a>
            </div>
        </li>
    </ul>

    <!--底部确认收集报价按钮-->
    <a class="collect-btn" href="javascript:;">确认收集报价</a>
</div><!--wrapper-end-->
</body>
</html>