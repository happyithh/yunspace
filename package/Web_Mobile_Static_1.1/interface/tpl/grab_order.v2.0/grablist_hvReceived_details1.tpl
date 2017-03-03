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
        <h2 class="state">已接单（重复单）</h2>
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
                <a class="baojia" href="needs">收集报价</a>
                {*<a class="baojia" href="needs">查看报价（10）</a>*}
            </li>
            <li>
                <p class="name">咨询场地：</p>
                <p class="substance wd">奢居会-8楼露台</p>
                <a class="fr dtl" href="javascript:;">完善信息</a>
            </li>
            <li>
                <p class="name">联系人：</p>
                <p class="substance wd">暂无</p>
                <a class="fr dtl js-search" href="javascript:;">我要搜索</a>
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
            <form method="">
                <div class="col clearfix">
                    <span class="icon icon1"></span>
                    <select id="col-selected">
                        <option>已电话-10%</option>
                        <option>已电话-20%</option>
                        <option value="1000">此单为重复单，关闭</option>
                    </select>
                    <span class="icon-pull"></span>
                </div>
                <div class="col col-reason hide clearfix">
                    <h6>请选择关闭理由</h6>
                    <ul class="reason-list">
                        <li><label><input type="radio" name="reason" value="客户预算不足">客户预算不足</label></li>
                        <li><label><input type="radio" name="reason" value="没有合适的产地推荐">没有合适的产地推荐</label></li>
                        <li><label><input type="radio" name="reason" value="客户跳单">客户跳单</label></li>
                        <li><label><input type="radio" name="reason" value="客户已经自己找到场地">客户已经自己找到场地</label></li>
                        <li><label><input type="radio" name="reason" value="活动取消">活动取消</label></li>
                        <li><label><input type="radio" name="reason" value="客户不再接听电话">客户不再接听电话</label></li>
                        <li><label><input type="radio" name="reason" value="公关公司比稿失败">公关公司比稿失败</label></li>
                        <li><label><input type="radio" name="reason" class="reason-other" value="2000">其他</label></li>
                        <li class="hide reason-textarea"><textarea rows="3" placeholder="请输入关闭的理由"></textarea></li>
                    </ul>
                </div>
                {*<div class="col clearfix">*}
                    {*<span class="icon icon2"></span>*}
                    {*<textarea placeholder="请输入10个汉字以上的说明"></textarea>*}
                {*</div>*}

                <a class="update-btn js-update-btn" href="javascript:;">提交</a>
            </form>
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
</div><!--wrapper-end-->

{static "v1.0/jquery-1.11.1.min.js"}
{static "grab_order.v2.0/grab.js"}
</body>
</html>