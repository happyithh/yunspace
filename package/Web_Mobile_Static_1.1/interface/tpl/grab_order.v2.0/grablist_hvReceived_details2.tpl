<!DOCTYPE html>
<html>
<head lang="en">
    {include "Web_Mobile_Static::v1.0/head_meta.tpl"}
    {static "v1.0/global.css"}
    {static "grab_order.v2.0/grab.css"}
</head>
<body>
<div class="wrapper">
    <div class="grab-title">
        <h2 class="state">已接单（档期咨询）</h2>
        <div class="fr progress">
            <p class="fl">进度100%</p>
            <div class="fl bar-wrap">
                <div class="bar" style="width: 100%"></div>
            </div>
        </div>
    </div>

    <div class="order-details">
        <div class="order-details-title clearfix">
            <div class="col-1 clearfix">
                <h3 class="fl">z**,152****3067</h3>
                <a class="fr contact-btn" href="tel:13133338798">联系他</a>
            </div>
            <div class="col-2 clearfix">
                <p class="fl">提交时间：2015.07.28  17:08:02</p>
                <p class="fr">NO.123456</p>
            </div>
        </div><!--order-details-title-end-->
        <ul class="order-details-cont clearfix">
            <li>
                <p class="name">活动档期：</p>
                <p class="substance wd">1天，2015.07.28 - 2015.08.31</p>
                <a class="baojia look" href="needs">查看报价(10)</a>
            </li>
            <li>
                <p class="name">咨询场地：</p>
                <p class="substance wd">奢居会-8楼露台</p>
                <a class="fr dtl" href="javascript:;">完善信息</a>
            </li>
            <li>
                <p class="name">联系人：</p>
                <p class="substance wd">李**</p>
                <a class="fr dtl" href="tel:1522*******">拨打电话</a>
            </li>
            <li>
                <p class="name">具体要求：</p>
                <p class="substance">发布会发布会发布会发布会发布会发布会发布会</p>
            </li>
        </ul>
    </div><!--order-details-end-->

    <!--更新进度记录-->
    <div class="update-records">
        <div class="update-records-title">更新进度记录</div>
        <div class="update-records-cont">
            <div class="col clearfix">
                <span class="icon icon1"></span>
                <select>
                    <option>已电话-10%</option>
                    <option>已电话-20%</option>
                    <option>此单为重复单，关闭</option>
                </select>
                <span class="icon-pull"></span>
            </div>
            <div class="col clearfix">
                <span class="icon icon2"></span>
                <textarea placeholder="请输入10个汉字以上的说明"></textarea>
            </div>
            <a class="update-btn js-update-btn" href="javascript:;">提交</a>
        </div>
    </div>

    <!--历史联系记录-->
    <div class="contact-records">
        <div class="contact-records-title">历史联系记录</div>
        <ul class="contact-records-list">
            <li>
                <div class="time">2015-11-23 16:18:26</div>
                <p>客户有意向了，客户有意向了，客户有意向了，客户有
                    意向了，客户有意向了</p>
            </li>
            <li>
                <div class="time">2015-11-23 16:18:26</div>
                <p>客户有意向了，客户有意向了，客户有意向了</p>
            </li>
            <li>
                <div class="time">2015-11-23 16:18:26</div>
                <p>客户有意向了，客户有意向了，客户有意向了</p>
            </li>
        </ul>
    </div>

</div><!--wrapper-end-->

<!--我要搜索弹窗-->
<div class="hidden search-map">
    <div class="list">
        <a class="search-baidu" href="javascript:;">百度搜索</a>
        <a class="map-baidu" href="javascript:;">百度地图</a>
        <a class="search-gaode" href="javascript:;">高德地图</a>
    </div>
    <a class="js-cancel cancel" href="javascript:;">取消</a>
</div>

<div class="hidden pop-submit">
    <div class="text">
        <p>确定提交该进度记录？</p>
    </div>
    <div class="btn-wrap">
        <a class="btn fl btn-no js-cancel" href="javascript:;">否</a>
        <a class="btn fr btn-yes" href="">是</a>
    </div>
</div>

{static "v1.0/jquery-1.11.1.min.js"}
{static "grab_order.v2.0/grab.js"}
</body>
</html>