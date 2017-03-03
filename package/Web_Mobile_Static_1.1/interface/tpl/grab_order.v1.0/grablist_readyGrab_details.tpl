<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v1.0/grab.css"}
</head>
<body>
<div class="wrapper">
    <div class="grab-title">
        <h2 class="state">等待抢单</h2>
    </div>

    <div class="order-details">
        <div class="order-details-title clearfix">
            <div class="col-1">
                <h3>z**,152****3067</h3>
            </div>
            <div class="col-2 clearfix">
                <p class="fl">提交时间：2015.07.28  17:08:02</p>
                <p class="fr">NO.123456</p>
            </div>
        </div><!--order-details-title-end-->
        <ul class="order-details-cont clearfix">
            <li>
                <p class="name">活动人数：</p>
                <p class="substance">50-100人</p>
            </li>
            <li>
                <p class="name">活动档期：</p>
                <p class="substance">1天，2015.07.28 - 2015.08.31</p>
            </li>
            <li>
                <p class="name">活动预算：</p>
                <p class="substance">¥50000 - ¥50000</p>
            </li>
            <li>
                <p class="name">活动城市：</p>
                <p class="substance">上海</p>
            </li>
            <li>
                <p class="name">活动类型：</p>
                <p class="substance">发布会</p>
            </li>
            <li>
                <p class="name">活动标签：</p>
                <p class="substance marks">
                    <span>活动标签</span>
                    <span>活动标签</span>
                    <span>活动标签</span>
                    <span>活动标签</span>
                    <span>活动标签</span>
                    <span>活动标签</span>
                </p>
            </li>
            <li>
                <p class="name">具体要求：</p>
                <p class="substance">发布会发布会发布会发布会发布会发布会发布会</p>
            </li>
        </ul>
    </div><!--order-details-end-->

    <!--待抢单-->
    <div class="grab-order">
        <div class="count-credit clearfix">
            <p class="fl">需扣减<span>100</span>积分</p>
            <p class="fr balance">积分余额：200</p>
        </div>
        <div class="count-down">
            你还有<span>18</span>分<span>10</span>秒抢单时间
        </div>
        <a href="javascript:;" class="btn-grab">抢单</a>
    </div>

    <!--待抢单不能抢单-->
    {*<div class="grab-order">*}
        {*<div class="count-credit count-credit-no clearfix">*}
            {*<p>需扣减<span>200</span>积分</p>*}
            {*<p class="balance">积分余额：100</p>*}
        {*</div>*}
        {*<a href="javascript:;" class="btn-grab btn-grab-no">积分不足</a>*}
    {*</div>*}

</div><!--wrapper-end-->
</body>
</html>


