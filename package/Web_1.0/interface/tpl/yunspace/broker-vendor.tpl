<!DOCTYPE html>
<html>
<head>
    {include "inc/html_head.tpl"}
    <link rel="stylesheet" type="text/css" href="css/yunspace.css">
</head>
<body>
{include "inc/header_nav.tpl"}
<div class="content">
    <div class="wbs" style="padding-bottom:0px;">
        <div class="wrap">
            <div class="btn-group btn-group-justified about_tab_phone" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <a href="./about_us" class="btn btn-default ">关于我们</a>
                </div>
                <div class="btn-group" role="group">
                    <a href="./business" class="btn btn-default">业务合作</a>
                </div>
                <div class="btn-group" role="group">
                    <a href="./recruitment" class="btn btn-default">职务招聘</a>
                </div>
            </div>
            <div class="btn-group btn-group-justified about_tab_phone" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <a href="./contact_us" class="btn btn-default">联系我们</a>
                </div>
                <div class="btn-group" role="group">
                    <a href="./agreement" class="btn btn-default about_tab_phone_active">云·Space协议</a>
                </div>
                <div class="btn-group" role="group">
                    <a href="./drawback" class="btn btn-default">退款说明</a>
                </div>
            </div>
            <div class="row about_tab">
                <div class="col-md-8">
                    <ul class="nav nav-tabs nav-justified">
                        <li role="presentation" class="tab">
                            <a href="./about_us" style="border: none; padding:15px 10px;">关于我们</a>
                        </li>
                        <li role="presentation" class="tab">
                            <a href="./business" style="border: none; padding:15px 10px;">业务合作</a>
                        </li>
                        <li role="presentation" class="tab">
                            <a href="./recruitment" style="border: none; padding:15px 10px;">职务招聘</a>
                        </li>
                        <li role="presentation" class="tab">
                            <a href="./contact_us" style="border: none; padding:15px 10px;">联系我们</a>
                        </li>
                        <li role="presentation" class="tab active1">
                            <a href="./agreement" style="border: none; padding:15px 10px;">云·Space协议</a>
                        </li>
                        <li role="presentation" class="tab">
                            <a href="./drawback" style="border: none; padding:15px 10px;">退款说明</a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4"></div>
            </div>
        </div>
    </div>
    <div class="wrap clearfix mt45 mb110">
        <div class="col-md-8">
            <div class="ct">
                <h2>云·SPACE经纪人规则-商户版</h2>
                <hr>

                <p class="text">
                <h4>什么样的订单才有佣金收益</h4>
                <ul>
                    <li>经纪人向客户的推荐方式满足下述情况的任何一种
                        <ol>
                            <li>
                                通过云 Space 消息系统向客户推荐
                            </li>
                            <li>
                                使用云经纪 App 生成/分享的商品链接
                            </li>
                            <li>
                                登录后使用商品详情页的专属二维码进行推荐
                            </li>
                        </ol>
                    </li>
                    <li>客户下单时使用您推荐的商品链接。</li>
                </ul>
                </p>

                <p class="text">
                <h4>商户的佣金如何结算</h4>
                <ul>
                    <li>佣金月结：次月10号前支付上月交易已完成的订单佣金给云space，线上支付或线下转账均可；</li>
                    <li>超过五个工作日仍未支付佣金，每天收取订单总金额百分之一滞纳金；</li>
                    <li>超过十个工作日仍未支付佣金，降低信用等级，商户产品／套餐强制下线。</li>
                </ul>
                </p>

            </div>
<style>
    .ct ul, .ct ol{ margin-left: 20px;}
    .ct ul li{ list-style-type: disc;}
    .ct ol li{ list-style-type: decimal;}
</style>

        </div>
        <div class="col-md-4 pr15">
            <div class="right_us">
                <h5>官方公众平台</h5>
                <img src="images/wenxin.jpg" class="img-responsive">
            </div>
        </div>
        <div class="clear"></div>
    </div>

</div>
{include file="Web_Static::v2.0/html_footer.tpl"}

</body>
</html>